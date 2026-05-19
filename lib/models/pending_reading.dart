class PendingReading {

  final int meterId;

  final String reading;

  PendingReading({

    required this.meterId,

    required this.reading,
  });

  Map<String, dynamic> toJson() {

    return {

      'meterId': meterId,

      'reading': reading,
    };
  }

  factory PendingReading.fromJson(
    Map<String, dynamic> json,
  ) {

    return PendingReading(

      meterId: json['meterId'],

      reading: json['reading'],
    );
  }
}