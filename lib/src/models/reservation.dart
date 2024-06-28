class Reservation {
  double originLatitude;
  double originLongitude;
  String originName;
  double destinationLatitude;
  double destinationLongitude;
  String destinationName;
  String distance;
  String duration;

  Reservation({
    required this.originLatitude,
    required this.originLongitude,
    required this.originName,
    required this.destinationLatitude,
    required this.destinationLongitude,
    required this.destinationName,
    required this.distance,
    required this.duration,
  });
}
