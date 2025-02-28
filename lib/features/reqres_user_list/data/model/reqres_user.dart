import 'package:suitmedia_competency_test/features/reqres_user_list/domain/entity/reqres_user.dart';

class ReqresUserModel extends ReqresUserEntity {
  const ReqresUserModel({
    int? id,
    String? email,
    String? firstName,
    String? lastName,
    String? avatar,
  }) : super(id, email, firstName, lastName, avatar);

  factory ReqresUserModel.fromJson(Map<String, dynamic> map) {
    return ReqresUserModel(
      id: map['id'] ?? 0,
      email: map['email'] ?? '',
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      avatar: map['avatar'] ?? '',
    );
  }
}
