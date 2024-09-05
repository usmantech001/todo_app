class LocationModel {
  late String lat;
  late String lon;
  late String name;
  late String displayName;

  LocationModel(
      {required this.displayName,
      required this.lat,
      required this.lon,
      required this.name});

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
        displayName: json['display_name'],
        lat: json['lat'],
        lon: json['lon'],
        name: json['name']);
  }
}
