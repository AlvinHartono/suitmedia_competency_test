import 'package:suitmedia_competency_test/core/resources/data_state.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/entity/reqres_user.dart';

abstract class ReqresUserRepository {
  Future<DataState<List<ReqresUserEntity>>> getReqresUsers({
    required int page,
    required int perPage,
  });
}
