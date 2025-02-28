import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:suitmedia_competency_test/core/constant/constants.dart';
import 'package:suitmedia_competency_test/features/reqres_user_list/data/model/reqres_user.dart';

part 'reqres_user_api_service.g.dart';

@RestApi(baseUrl: reqresBaseUrl)
abstract class ReqresUserApiService {
  factory ReqresUserApiService(Dio dio) = _ReqresUserApiService;

  @GET("/users")
  Future<HttpResponse<ReqresUserResponseModel>> getReqresUsers(
    @Query('page') int page,
    @Query('per_page') int perPage,
  );
}

class ReqresUserResponseModel {
  final int page;
  final int perPage;
  final int total;
  final int totalPages;
  final List<ReqresUserModel> data;

  ReqresUserResponseModel({
    required this.page,
    required this.perPage,
    required this.total,
    required this.totalPages,
    required this.data,
  });

  factory ReqresUserResponseModel.fromJson(Map<String, dynamic> json) {
    return ReqresUserResponseModel(
      page: json['page'] ?? 0,
      perPage: json['per_page'] ?? 0,
      total: json['total'] ?? 0,
      totalPages: json['total_pages'] ?? 0,
      data: List<ReqresUserModel>.from(
        (json['data'] as List).map(
          (userJson) => ReqresUserModel.fromJson(userJson),
        ),
      ),
    );
  }
}
