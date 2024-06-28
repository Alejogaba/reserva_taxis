import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:reserva_taxis/constants.dart';
import 'package:reserva_taxis/src/login_page/login_page_view.dart';
import 'package:reserva_taxis/generated/l10n.dart'; // Importa el archivo de localización generado

import '../models/reservation.dart';
import 'package:art_sweetalert/art_sweetalert.dart';

class ReservationPageView extends StatelessWidget {
  final Reservation reservation;

  const ReservationPageView({super.key, required this.reservation});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.current.reservationDetailsTitle),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(Icons.place),
              title: Text(S.current.origin),
              subtitle: Text(reservation.originName),
            ),
            ListTile(
              leading: const Icon(Icons.place),
              title: Text(S.current.destination),
              subtitle: Text(reservation.destinationName),
            ),
            ListTile(
              leading: const Icon(Icons.directions_car),
              title: Text(S.current.distance),
              subtitle: Text(reservation.distance),
            ),
            ListTile(
              leading: const Icon(Icons.access_time),
              title: Text(S.current.estimatedDuration),
              subtitle: Text(reservation.duration.replaceAll('hours', S.current.hours)),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        foregroundColor: primaryColor,
        backgroundColor: btnPrimaryBackgroundColor,
        onPressed: () {
          ArtSweetAlert.show(
            context: context,
            artDialogArgs: ArtDialogArgs(
              confirmButtonColor: primaryColor,
              onConfirm: () {
                Navigator.of(context).pop();
                Get.offAll(() => const LoginPageView());
              },
              onDispose: () {
                Navigator.of(context).pop();
                Get.offAll(() => const LoginPageView());
              },
              type: ArtSweetAlertType.success,
              title: S.current.completedTitle,
              text: S.current.reservationSuccess,
            ),
          );
        },
        label: Text(S.current.createReservation),
        icon: const Icon(Icons.check),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
