import 'package:flutter_application_1/common/base_client.dart';
import 'package:flutter_application_1/screens/user/update/user_update_dto.dart';
import 'package:flutter_application_1/user/user_dto.dart';

class UserClient {
    final String _userUri = '/user';
    final String _userLogin = '/user/login';
    final String _updateUserCredentials = '/user/credentials';
    final String _updateUserPassword = '/user/password';

    final BaseClient _baseClient = BaseClient();

    Future<Map<String, dynamic>> login(String email, String userPassword) async {
        return _baseClient.post(
            _userLogin, 
            Map<String, dynamic>.from({ 'password': userPassword, 'email': email })
        );
    }

    Future<Map<String, dynamic>> create(UserDTO userDTO) {
        return _baseClient.post(
            _userUri, 
            Map<String, dynamic>.from({ 
              'email': userDTO.email, 
              "name":userDTO.username, 
              'password': userDTO.password, 
            })
        );
    }

    Future<Map<String, dynamic>> changeCredentials(UserUpdateDTO userDTO){
        return _baseClient.patch(
            _updateUserCredentials, 
            Map<String, dynamic>.from({ 
                'email': userDTO.email, 
                "name":userDTO.username, 
                'password': userDTO.password, 
            }) 
        );
    }


    Future<Map<String, dynamic>> changePassword(UserUpdateDTO userDTO){
        return _baseClient.patch(
            _updateUserPassword, 
            Map<String, dynamic>.from({ 
                'password': userDTO.password, 
                'new_password': userDTO.newPassword
            }) 
        );
    }
}
