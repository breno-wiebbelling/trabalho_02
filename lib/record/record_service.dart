import 'package:flutter_application_1/record/record_client.dart';
import 'package:flutter_application_1/record/record_dto.dart';

class RecordService {

  final RecordClient _recordClient = RecordClient();

  Future<List<RecordDTO>> getRecordsByMonthAndYear(int month, int year) async {
    return _recordClient
      .getByMonthAndYear(month, year)
      .then(( recordClientResponse ) {
        return List.from(recordClientResponse['records'])
          .map((record) { 
            return RecordDTO(
              record['_id'], 
              record['name'], 
              record['type'], 
              (record['amount'] as int).toDouble(),                  
              record['date'], 
              record['description']
            );
          }).toList();
      });
  } 

  Future<void> create(RecordDTO recordDTO){
    return _recordClient.create(recordDTO);
  }

  Future<void> update(RecordDTO recordDTO) {
    return _recordClient.update( recordDTO );
  }

  Future<void> delete(String recordId){
    return _recordClient.delete(recordId);
  }

}

