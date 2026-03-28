
import '../Api/endpoints.dart';

class ErrorModel {
  final String errorMessage;
  //final int? status;

  ErrorModel({required this.errorMessage,/*this.status*/});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
  return ErrorModel(
    errorMessage: jsonData[ApiKey.message]?.toString() ?? "Unknown error",
    // status: jsonData[ApiKey.statusCode] is int
    //     ? jsonData[ApiKey.statusCode]
    //     : int.tryParse(jsonData[ApiKey.statusCode]?.toString() ?? ''),
  );
}

}
