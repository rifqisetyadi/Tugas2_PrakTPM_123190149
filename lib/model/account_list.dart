import 'package:hive/hive.dart';

part 'account_list.g.dart';

@HiveType(typeId: 1)
class AccountList{
  AccountList({required this.username, required this.password});

  @HiveField(0)
  String username;

  @HiveField(1)
  String password;

  @override
  String toString() {
    return 'AccountList{username: $username, password: $password}';
  }
}