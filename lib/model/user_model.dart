import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

enum Gender { male, female }

enum Status { active, inactive }

@JsonSerializable()
/*The User class extends Equatable that helps with value equality. 
We just need to implement the props getter function which defines the list of properties 
that will be used to determine whether two instances are equal.
*/
class User extends Equatable {
  final int? id;
  final String name;
  final String email;
  final Gender gender;
  final Status status;

  const User({
    this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  bool? get stringify => true;

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
