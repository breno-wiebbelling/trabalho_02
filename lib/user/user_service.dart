import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/user/login.dart';
import 'package:flutter_application_1/screens/user/update/user_update_dto.dart';
import 'package:flutter_application_1/user/user_client.dart';
import 'package:flutter_application_1/user/user_dto.dart';
import 'package:flutter_application_1/common/local_storage.dart';

class UserService {
    final UserClient   _userClient   = UserClient();
    final LocalStorage _localStorage = LocalStorage();

    final RegExp _upperCaseRegex   = RegExp(r'^(?=.*?[A-Z])');
    final RegExp _lowerCaseRegex   = RegExp(r'^(?=.*?[a-z])');
    final RegExp _specialCharRegex = RegExp(r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+=' "'" ']');
    final RegExp _numberRegex = RegExp(r'^(?=.*?[0-9])');
    final RegExp _lengthRegex = RegExp(r'^.{8,16}');
  
    Future<bool> login(String email, String password) async {
        return _userClient
            .login(email, password)
            .then((userResponse) {
                if( !userResponse.containsKey("token") ) return false;

                return _performLogin(userResponse);
            });
    }

    void logout(BuildContext context) async {
        await _localStorage.logout();

        if(context.mounted){
            Navigator.of(context)
                .pushNamedAndRemoveUntil(LoginScreen.routeName, (Route<dynamic> route) => false);
        }
    }
    
    Future<bool> create(UserDTO userDTO) {
        return _userClient
            .create(userDTO)
            .then((userResponse) async {
                if( !userResponse.containsKey("token") ) return false;

                return await _performLogin(userResponse);
            });
    }
    
    Future<UserDTO> get() async {
      return UserDTO(
          await _localStorage.getString("username"), 
          await _localStorage.getString("email"), 
          ""
      );
    }
   
    Future<bool> updateUserCredentials(UserUpdateDTO userUpdateDTO) async {

        if(userUpdateDTO.email == "")    userUpdateDTO.email = await _localStorage.getString("email");
        if(userUpdateDTO.username == "") userUpdateDTO.username = await _localStorage.getString("username");

        return _userClient 
            .changeCredentials(userUpdateDTO)
            .then((userResponse) async {
                
                if(userUpdateDTO.email != "")    await _localStorage.setString("email", userUpdateDTO.email ?? "");
                if(userUpdateDTO.username != "")    await _localStorage.setString("username", userUpdateDTO.username ?? "");

                return true;
            });    
    }

    Future<bool> updateUserPassword(UserUpdateDTO userUpdateDTO){
        return _userClient 
            .changePassword(userUpdateDTO)
            .then((userResponse){
                return true; 
            });    
    }

    Future<bool> _performLogin(Map<String, dynamic> responseBody) async {
        return await _localStorage
            .setListOfString(
                List.of(['token', 'username', 'email']), 
                List.of([responseBody['token'], responseBody['user']['name'], responseBody['user']['email']])
            )
            .then((value) => true);
    }

    Future<bool> isLoggedId() async {

      return await _localStorage.getString("token") != "";
    }

    String? validatePassword(String? password) {
        if (password!.isEmpty) return "Adicione uma senha!";

        if ( !_upperCaseRegex.hasMatch(password) )   return "A senha deve possuir uma letra maiuscula.";
        if ( !_lowerCaseRegex.hasMatch(password) )   return "A senha deve possuir uma letra minuscula.";
        if ( !_numberRegex.hasMatch(password)    )   return "A senha deve possuir um numero.";
        if ( !password.contains(_specialCharRegex) ) return "A senha deve possuir um caracter especial.";
        if ( !_lengthRegex.hasMatch(password)    )   return 'Sua senha possui ${password.length} caracteres. \nPorém deve ter entre 8 e 16 caracteres.';
        
        return null;
    }

    String? emailValidator(String? value) {
        if( value!.isEmpty )       return "Ensira um email";
        if( !value.contains("@") ) return "Ensira um email válido";

        return null ;
    }

    String? usernameValidator(String? value) {
        if( value!.isEmpty ) return "Ensira um username";

        return null;
    }

}