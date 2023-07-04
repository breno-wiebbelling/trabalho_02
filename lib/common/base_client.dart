import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_1/common/local_storage.dart';

class BaseClient{
  final String _baseUrl = "https://pdm-back.vercel.app";
  final LocalStorage _localStorage = LocalStorage();

  Future<Object> get( String uri ) async {

    return http.get(  
      Uri.https(_baseUrl, uri), 
      headers: { 'authorization': await _localStorage.getObject('token') }
    ); 
  }
  
  Future<Object> post(String uri, String body) async {
    var response = await http.post( 
      Uri.parse(_baseUrl+uri), 
      body: jsonEncode(<String, String>{
        'password':'senha',
        'email':'usuario@gmail.com',
      }),
      headers: { 'authorization':await _localStorage.getObject('token') } 
    );

    if(response.statusCode != 200){
      throw http.ClientException(jsonDecode(response.body)['error']);
    }

    return jsonDecode(response.body);
  }

  Future<Object> delete(String uri, Map body) async {

    return http.delete( 
      Uri.https(_baseUrl, uri),
      body: body,
      headers: { 'authorization':await _localStorage.getObject('token') } 
    ); 
  }

}