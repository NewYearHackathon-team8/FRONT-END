class Residence {
  final int homeId;
  final String address;
  final int deposit;
  final int monthlyRent;
  final bool matched;

  Residence({
    required this.homeId,
    required this.address,
    required this.deposit,
    required this.monthlyRent,
    required this.matched,
  });

  factory Residence.fromJson(Map<String, dynamic> json) {
    return Residence(
      homeId: json['homeId'],
      address: json['address'],
      deposit: json['deposit'],
      monthlyRent: json['mothlyLent'],
      matched: json['matched'],
    );
  }
}
