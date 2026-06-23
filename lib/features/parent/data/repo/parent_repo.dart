import '../../../../../core/Api/api_consumer.dart';
import '../models/parent_child_model.dart';

class ParentRepo {
  final ApiConsumer api;

  ParentRepo({required this.api});

  Future<List<ParentChildModel>> getChildren() async {
    final resp = await api.get('/api/v1/auth/parent/children');
    // expect resp to be a list or contain data list
    final raw = resp is Map && resp['data'] != null ? resp['data'] : resp;
    if (raw is List) {
      return raw
          .map((e) => ParentChildModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }
    return [];
  }
}
