import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geo;
import 'package:get/get.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:google_maps_place_picker_mb/google_maps_place_picker.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:reserva_taxis/constants.dart';
import 'package:reserva_taxis/src/home_page/home_page_controller.dart';
import 'package:reserva_taxis/src/models/reservation.dart';
import 'package:reserva_taxis/src/reservation_page/reservation_page_view.dart';

import '../../generated/l10n.dart';

class HomePageView extends StatefulWidget {
  const HomePageView({super.key});

  @override
  State<HomePageView> createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  Set<Polyline> polylines = {};
  List<LatLng> polylineCoordinates = [];

  String addressDestination = "";
  String distance = "";
  String duration = "";

  bool loading = false;
  bool locationServiceEnabled = false;
  bool invalidRoute = false;

  Location location = Location();
  LocationData? currentLocation;
  LatLng? destinationLocation;
  BitmapDescriptor destinationIcon =
      BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan);
  MarkerId selectedMarker = const MarkerId("current");

  late GoogleMapController _googleMapController;
  late Set<Marker> markerList = {};

  final Completer<GoogleMapController> _controllerMaps = Completer();
  final CameraTargetBounds _cameraTargetBounds = CameraTargetBounds.unbounded;
  final MinMaxZoomPreference _minMaxZoomPreference =
      MinMaxZoomPreference.unbounded;

  @override
  void initState() {
    super.initState();
    getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(
              child: CircularProgressIndicator(
              color: primaryColor,
            ))
          : Center(
              child: currentLocation == null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.location_disabled_outlined,
                          size: 35,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          S.current.locationNotAvailable,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: () {
                            getCurrentLocation();
                          },
                          style: ElevatedButton.styleFrom(
                            foregroundColor: primaryColor,
                            backgroundColor: btnPrimaryBackgroundColor,
                          ),
                          child: Text(
                            S.current.activateLocation,
                            style: const TextStyle(fontSize: 18),
                          ),
                        ),
                      ],
                    )
                  : Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            bottom: HomePageController()
                                .defineBottomPadding(context),
                          ),
                          child: showMapWidget(context),
                        ),
                        _showOverlay(context),
                      ],
                    ),
            ),
    );
  }

  Widget showMapWidget(BuildContext context) {
    return SizedBox(
      width: HomePageController().contentWidth(context),
      child: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(
                  currentLocation!.latitude!, currentLocation!.longitude!),
              zoom: 13.4746,
            ),
            compassEnabled: true,
            mapToolbarEnabled: true,
            cameraTargetBounds: _cameraTargetBounds,
            minMaxZoomPreference: _minMaxZoomPreference,
            mapType: MapType.normal,
            rotateGesturesEnabled: true,
            scrollGesturesEnabled: true,
            tiltGesturesEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: false,
            indoorViewEnabled: false,
            myLocationEnabled: true,
            myLocationButtonEnabled: false,
            buildingsEnabled: true,
            trafficEnabled: true,
            liteModeEnabled: false,
            polylines: polylines,
            markers: markerList,
            onMapCreated: (controller) {
              setState(() {
                loading = false;
              });
              if (!_controllerMaps.isCompleted) {
                _controllerMaps.complete(controller);
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _showOverlay(BuildContext ctx) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          color: Colors.transparent,
          padding: const EdgeInsets.only(top: 30.0),
        ),
        FittedBox(
          fit: BoxFit.fitHeight,
          child: Container(
              width: MediaQuery.of(ctx).size.width,
              // height: MediaQuery.of(ctx).size.aspectRatio <= 0.5 ? MediaQuery.of(ctx).size.height * .16: MediaQuery.of(ctx).size.height * .25,
              decoration: const BoxDecoration(
                color: primaryBackgroundColor,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50.0),
                  topLeft: Radius.circular(50.0),
                ),
                border: Border(
                  top: BorderSide(
                    color: borderLineColor,
                    width: 1.5,
                  ),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 20.0, 0.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width * 0.1,
                          right: MediaQuery.of(context).size.width * 0.1),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: AutoSizeText(
                              polylines.isNotEmpty
                                  ? S.current.confirmRouteMessage
                                  : invalidRoute
                                      ? S.current.invalidRouteMessage
                                      : S.current.selectRouteMessage,
                              minFontSize: 6,
                              maxFontSize: 20,
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: invalidRoute
                                    ? btnDangerColor
                                    : primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          MediaQuery.of(context).size.width * 0.15,
                          4.0,
                          MediaQuery.of(context).size.width * 0.15,
                          4.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      MediaQuery.of(context).size.width * 0.02),
                              child: ElevatedButton(
                                onPressed: () {
                                  pickDestination();
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: polylines.isEmpty
                                      ? primaryColor
                                      : btnAltertnativeColor,
                                  backgroundColor: polylines.isEmpty
                                      ? btnPrimaryBackgroundColor
                                      : btnAltertnativeBackgroundColor,
                                ),
                                child: Text(
                                  S.current.selectDestination,
                                  textAlign: TextAlign.center,
                                  maxLines: 2,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                            ),
                          ),
                          if (polylines.isNotEmpty)
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    right: MediaQuery.of(context).size.width *
                                        0.02),
                                child: ElevatedButton(
                                  onPressed: () async {
                                    setState(() {
                                      loading = true;
                                    });
                                    String currentAddress =
                                        S.current.yourLocation;
                                    try {
                                      List<geo.Placemark> placemarks =
                                          await geo.placemarkFromCoordinates(
                                              currentLocation!.latitude!,
                                              currentLocation!.longitude!);
                                      currentAddress =
                                          '${placemarks[0].street}, ${placemarks[0].locality}, ${placemarks[0].administrativeArea}';
                                    } on Exception catch (e) {
                                      Logger().e(
                                          'Error al obtener dirección de origen: $e');
                                    }
                                    setState(() {
                                      loading = false;
                                    });
                                    Get.to(ReservationPageView(
                                        reservation: Reservation(
                                            originLatitude:
                                                currentLocation!.latitude!,
                                            originLongitude:
                                                currentLocation!.longitude!,
                                            destinationLatitude:
                                                destinationLocation!.latitude,
                                            destinationLongitude:
                                                destinationLocation!.longitude,
                                            originName: currentAddress,
                                            destinationName: addressDestination,
                                            distance: distance,
                                            duration: duration)));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: primaryColor,
                                    backgroundColor: btnPrimaryBackgroundColor,
                                  ),
                                  child: Text(
                                    S.current.continueButton,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    )
                  ],
                ),
              )),
        ),
      ],
    );
  }

  void pickDestination() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PlacePicker(
          hintText: S.current.searchDestinationHint,
          outsideOfPickAreaText: S.current.outsidePickAreaText,
          searchingText: S.current.searchingText,
          apiKey: googleApiKey,
          onPlacePicked: (result) async {
            Logger().i('Resultado: ${result.formattedAddress}');
            addressDestination = result.formattedAddress!;
            destinationLocation = LatLng(
                result.geometry!.location.lat, result.geometry!.location.lng);
            Navigator.of(context).pop();
            await fetchPolylines(
                PointLatLng(
                    currentLocation!.latitude!, currentLocation!.longitude!),
                PointLatLng(destinationLocation!.latitude,
                    destinationLocation!.longitude));
          },
          initialPosition: LatLng(
              currentLocation!.latitude! + 0.005, currentLocation!.longitude!),
          useCurrentLocation: false,
          resizeToAvoidBottomInset: false,
          selectInitialPosition: false,
        ),
      ),
    );
  }

  //Obtiene la ubicacion actual
  Future getCurrentLocation() async {
    locationServiceEnabled = await location.serviceEnabled();
    if (!locationServiceEnabled) {
      locationServiceEnabled = await location.requestService();
      if (!locationServiceEnabled) {
        // El usuario ha denegado el acceso al servicio de ubicación
        setState(() {
          currentLocation = null;
        });
        return;
      }
    }

    await Permission.location.request();
    var status = await Permission.location.status;
    if (status.isDenied) {
      Logger().e('Permiso ubicación denegado');
      turnOnLocationSnackBar();
      setState(() {
        currentLocation = null;
      });
      return;
    }

    // Si el servicio de ubicación está habilitado, se puede proceder a obtener la ubicación actual
    Logger().i('Obteniendo ubicacion actual');
    setState(() {
      loading = true;
    });
    await location.getLocation().then((value) {
      setState(() {
        currentLocation = value;
        Logger().t(
            'Ubicacion actual obtenida: ${value.heading}${value.provider}$value');
        loading = false;
      });
    });

    _googleMapController = await _controllerMaps.future;

    //Escucha los cambios de ubicacion
    location.onLocationChanged.listen((newLoc) async {
      try {
        currentLocation = newLoc;
        var cameraPosition = LatLng(newLoc.latitude!, newLoc.longitude!);
        if (destinationLocation == null) {
          _googleMapController.animateCamera(CameraUpdate.newCameraPosition(
              CameraPosition(target: cameraPosition, zoom: 15)));
        }
        Logger().t(
            'Ubicancion nueva: ${currentLocation!.latitude}${currentLocation!.longitude}');
      } on Exception catch (e) {
        Logger().e('Error al obtener la ubicacion: $e');
        setState(() {
          currentLocation = null;
        });
      }
    });
  }

  //Obtiene la ruta entre dos puntos
  Future fetchPolylines(PointLatLng origin, PointLatLng destination) async {
    polylines.clear();
    polylineCoordinates.clear();
    markerList.clear();
    try {
      PolylinePoints polylinePoints = PolylinePoints();
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
          request: PolylineRequest(
              origin: origin,
              destination: destination,
              mode: TravelMode.driving),
          googleApiKey: googleApiKey);
      Logger().t('Ruta obtenida: ${result.points.length}');
      Logger().t('Distancia: ${result.distanceTexts![0]}');
      Logger().t('Duracion: ${result.durationTexts![0]}');
      distance = result.distanceTexts![0];
      duration = result.durationTexts![0];
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
      polylines.add(Polyline(
          width: 5,
          polylineId: const PolylineId('route'),
          color: primaryColor,
          points: polylineCoordinates));

      markerList.add(Marker(
        markerId: const MarkerId("destination"),
        position: LatLng(destination.latitude, destination.longitude),
        icon: destinationIcon,
      ));
      setState(() {
        invalidRoute = false;
      });
      //Centra la camara en la ruta obtenida
      await Future.delayed(const Duration(milliseconds: 1200), () async {
        LatLngBounds bounds =
            HomePageController().boundsFromLatLngList(polylineCoordinates);
        GoogleMapController googleMapController = await _controllerMaps.future;
        googleMapController
            .animateCamera(CameraUpdate.newLatLngBounds(bounds, 40));
      });
    } on Exception catch (e) {
      Logger().e('Error al obtener la ruta: $e');
      setState(() {
        invalidRoute = true;
      });
    }
  }

  turnOnLocationSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          S.current.turnOnLocation,
          style: TextStyle(fontSize: 15, color: Colors.white),
        ),
        backgroundColor: btnDangerColor,
      ),
    );
  }
}
