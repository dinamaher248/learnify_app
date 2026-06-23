class ParentChildModel {
  final String id;
  final String firstName;
  final String lastName;

  ParentChildModel({
    required this.id,
    required this.firstName,
    required this.lastName,
  });

  factory ParentChildModel.fromJson(Map<String, dynamic> json) {
    return ParentChildModel(
      id: json['id']?.toString() ?? '',
      firstName: json['firstName']?.toString() ?? '',
      lastName: json['lastName']?.toString() ?? '',
    );
  }
}
