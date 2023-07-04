// import 'package:trabalho1/user/user_client.dart';
// import 'package:trabalho1/user/user_dto.dart';

// class UserService {
//   final UserClient userClient = UserClient();

//   final RegExp _upperCaseRegex = RegExp(r'^(?=.*?[A-Z])');
//   final RegExp _lowerCaseRegex = RegExp(r'^(?=.*?[a-z])');
//   final RegExp _specialCharRegex =
//       RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' "'" ']');
//   final RegExp _numberRegex = RegExp(r'^(?=.*?[0-9])');
//   final RegExp _lengthRegex = RegExp(r'^.{8,16}');

//   String? validatePassword(String? password) {
//     if (password!.isEmpty) return "Adicione uma senha!";

//     if (!_upperCaseRegex.hasMatch(password)) {
//       return "A senha deve possuir uma letra maiuscula.";
//     }
//     if (!_lowerCaseRegex.hasMatch(password)) {
//       return "A senha deve possuir uma letra minuscula.";
//     }
//     if (!_numberRegex.hasMatch(password)) {
//       return "A senha deve possuir um numero.";
//     }
//     if (!password.contains(_specialCharRegex)) {
//       return "A senha deve possuir um caracter especial.";
//     }
//     if (!_lengthRegex.hasMatch(password)) {
//       return 'Sua senha possui ${password.length} caracteres. \nPorém deve ter entre 8 e 16 caracteres.';
//     }

//     return null;
//   }

//   Future<bool> login(String email, String password) async {
//     return userClient.login(email, password).then((userResponse) {
//       //todo
//       return userResponse.token != null;
//     });
//   }

//   Future<UserDTO> get() {
//     return userClient
//         .getUser()
//         //todo
//         .then((userResponse) =>
//             UserDTO("userResponse.username", "userResponse.email"));
//   }

//   Future<Object> create(UserDTO) {
//     return userClient.createUser(UserDTO);
//   }
// }