class ResourceMeter {
  final int id;
  final String meterCode;
  final String location;

  ResourceMeter({
    required this.id,
    required this.meterCode,
    required this.location,
  });

  factory ResourceMeter.fromJson(
    Map<String, dynamic> json,
  ) {

    return ResourceMeter(
      id: json['id'],
      meterCode: json['meter_code'],
      location: json['location'],
    );
  }
}