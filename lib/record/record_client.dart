import 'package:flutter_application_1/common/base_client.dart';
import 'package:flutter_application_1/record/record_dto.dart';


class RecordClient{
  final String recordUri = '/record';

  final BaseClient _baseClient = BaseClient();

  Future<Map<String, dynamic>> getByMonthAndYear(int month, int year)async {
    return _baseClient.get('$recordUri/$month/$year'); 
  }

  Future<Map<String, dynamic>> create(RecordDTO recordDTO) async {
    return _baseClient.post(
      recordUri,
      Map<String, dynamic>.from({ 
        'name': recordDTO.name, 
        'type': recordDTO.type,
        'amount': recordDTO.amount.toString(), 
        'date': recordDTO.date,
        'description': recordDTO.description, 
      })
    ); 
  }

  Future<Map<String, dynamic>> update(RecordDTO recordDTO) async {
    return _baseClient.patch(
      recordUri,
      Map<String, dynamic>.from({ 
        'record_id': recordDTO.getId(),
        'record_name': recordDTO.name, 
        'record_type': recordDTO.type,
        'record_amount': recordDTO.amount.toString(), 
        'record_date': recordDTO.date,
        'record_description': recordDTO.description, 
      })
    ); 
  }

  Future<Map<String, dynamic>> delete(String recordId) async {
    return _baseClient.delete('$recordUri/$recordId'); 
  }
}