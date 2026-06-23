class ParentCodeModel {
  final String code;
  final String expiryDate;

  ParentCodeModel({
    required this.code,
    required this.expiryDate,
  });

  factory ParentCodeModel.fromJson(Map<String, dynamic> json) {
    return ParentCodeModel(
      code: json['code'] ?? '',
      expiryDate: json['expiryDate'] ?? '',
    );
  }
}