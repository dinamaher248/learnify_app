class ParentCodeModel {
  final String code;
  final String expiryDate;

  ParentCodeModel({
    required this.code,
    required this.expiryDate,
  });

  factory ParentCodeModel.fromJson(Map<String, dynamic> json) {
    final data = json.containsKey('data') ? (json['data'] as Map<String, dynamic>? ?? json) : json;
    return ParentCodeModel(
      code: data['code']?.toString() ?? '',
      expiryDate: data['expiryDate']?.toString() ?? '',
    );
  }
}