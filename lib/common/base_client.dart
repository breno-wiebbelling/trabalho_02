import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/common/local_storage.dart';

class BaseClient{
  final String _baseUrl = "https://pdm-back.vercel.app";
  final LocalStorage _localStorage = LocalStorage();

    Future<Map<String, dynamic>> get( String uri ) async {
        var response =  await http.get(  
            Uri.parse('$_baseUrl$uri'), 
            headers: { 'authorization': await _localStorage.getString('token') }
        ); 
        if(response.body.contains("error")){
            throw http.ClientException(jsonDecode(response.body)["error"]);
        }

        return jsonDecode(response.body);
    }
  
    Future<Map<String, dynamic>> post(String uri, Map<String, dynamic> requestBody) async {
        var response = await http.post(
            Uri.parse('$_baseUrl$uri'), 
            headers: { 'authorization':await _localStorage.getString('token') },
            body: requestBody
        );

        if(response.body.contains("error")){
            throw http.ClientException(jsonDecode(response.body)["error"]);
        }
        return jsonDecode(response.body);
    }

    Future<Map<String, dynamic>> patch(String uri, Map<String, dynamic> requestBody) async {
        var response = await http.patch(
            Uri.parse('$_baseUrl$uri'), 
            headers: { 'authorization':await _localStorage.getString('token') },
            body: requestBody
        );

        if(response.body.contains("error")){
            throw http.ClientException(jsonDecode(response.body)["error"]);
        }

        return jsonDecode(response.body);
    }

    Future<Map<String, dynamic>> delete(String uri) async {
      var response = await http.delete( 
          Uri.parse('$_baseUrl$uri'), 
          headers: { 'authorization':await _localStorage.getString('token') } 
      ); 

      if(response.body.contains("error")){
          throw http.ClientException(jsonDecode(response.body)["error"]);
      }

      return jsonDecode(response.body);
    }

}