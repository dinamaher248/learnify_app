import '../Api/endpoints.dart';

class ErrorModel {
  final String errorMessage;
  //final int? status;

  ErrorModel({required this.errorMessage /*this.status*/});
  factory ErrorModel.fromJson(Map<String, dynamic> jsonData) {
    // handle common error shapes: {"message":"..."}, {"errors":[...]}, or plain string
    String message = 'Unknown error';

    try {
      if (jsonData.isEmpty) {
        message = 'Unknown error';
      } else if (jsonData[ApiKey.message] != null) {
        message = jsonData[ApiKey.message].toString();
      } else if (jsonData['errors'] != null) {
        final errors = jsonData['errors'];
        if (errors is List) {
          message = errors.map((e) => e.toString()).join(', ');
        } else {
          message = errors.toString();
        }
      } else {
        // fallback to full payload
        message = jsonData.toString();
      }
    } catch (_) {
      message = jsonData.toString();
    }

    return ErrorModel(errorMessage: message);
  }
}
