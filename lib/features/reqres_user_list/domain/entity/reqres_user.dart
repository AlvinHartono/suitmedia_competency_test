import 'package:equatable/equatable.dart';

class ReqresUserEntity extends Equatable {
  final int? id;
  final String? email;
  final String? firstName;
  final String? lastName;
  final String? avatar;

  const ReqresUserEntity(
    this.id,
    this.email,
    this.firstName,
    this.lastName,
    this.avatar,
  );

  @override
  List<Object?> get props {
    return [id, email, firstName, lastName, avatar];
  }
}
