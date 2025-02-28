import 'package:suitmedia_competency_test/core/resources/data_state.dart';
import 'package:suitmedia_competency_test/core/usecases/usecase.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/entity/reqres_user.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/repository/reqres_user_repository.dart';

class GetReqresUserUsecase
    implements UseCase<DataState<List<ReqresUserEntity>>, void> {
  final ReqresUserRepository _reqresUserRepository;

  GetReqresUserUsecase(this._reqresUserRepository);
  @override
  Future<DataState<List<ReqresUserEntity>>> call({void params}) {
    return _reqresUserRepository.getReqresUsers(page: 1, perPage: 10);
  }
}
