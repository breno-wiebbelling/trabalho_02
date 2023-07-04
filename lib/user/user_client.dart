// import 'package:trabalho1/common/base_client.dart';
// import 'package:trabalho1/user/user_dto.dart';

// class UserClient {
//   final String _userUri = '/user';
//   final String _userLogin = '/user/login';

//   final BaseClient _baseClient = BaseClient();

//   Future<Object> login(String email, String userPassword) async {
//     return _baseClient.post(_userLogin, "");
//   }

//   Future<Object> getUser() {
//     return _baseClient.get(_userUri);
//   }

//   Future(Object) create(UserDTO userDTO){
//     //todo
//     return _baseClient.post(_userUri, body);
//   }

//   Future(Object) changePassword(UserDTO userDTO){
//     //todo
//     return _baseClient.post(_userUri, "body");
//   }

//   Future(Object) changeUsername(UserDTO userDTO){
//     //todo
//     return _baseClient.post(_userUri, "body");
//   }

//   Future(Object) changeEmail(UserDTO userDTO){
//     //todo
//     return _baseClient.post(_userUri, "body");
//   }
// }
