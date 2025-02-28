import 'package:dio/dio.dart';
import 'package:suitmedia_competency_test/core/resources/data_state.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/data/data_sources/remote/reqres_user_api_service.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/data/model/reqres_user.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/domain/repository/reqres_user_repository.dart';

class ReqresUserRepositoryImpl implements ReqresUserRepository {
  final ReqresUserApiService _apiService;

  ReqresUserRepositoryImpl(this._apiService);
  @override
  Future<DataState<List<ReqresUserModel>>> getReqresUsers({
    int page = 1,
    int perPage = 10,
  }) async {
    try {
      final httpResponse = await _apiService.getReqresUsers(page, perPage);
      if (httpResponse.response.statusCode == 200) {
        print("total data: ${httpResponse.data.total}");
        return DataSuccess(httpResponse.data.data);
      } else {
        return DataFailed(
          DioException(
            requestOptions: httpResponse.response.requestOptions,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            error: httpResponse.response.statusMessage,
          ),
        );
      }
    } on DioException catch (e) {
      print(e.message);
      return DataFailed(e);
    } catch (e) {
      return DataFailed(
        DioException(
          requestOptions: RequestOptions(path: ''),
          type: DioExceptionType.unknown,
          error: e.toString(),
        ),
      );
    }
  }
}
