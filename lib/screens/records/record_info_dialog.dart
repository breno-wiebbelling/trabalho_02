import 'package:flutter/material.dart';
import 'package:flutter_application_1/record/record_dto.dart';
import 'package:flutter_application_1/record/record_service.dart';
import 'package:flutter_application_1/screens/records/record_creation_dialog.dart';

class RecordInfoDialog extends StatefulWidget {

	final RecordDTO record;

    const RecordInfoDialog({super.key, required this.record});

	@override
	_RecordInfoDialogDialogState createState() => _RecordInfoDialogDialogState();
}

class _RecordInfoDialogDialogState extends State<RecordInfoDialog> {
    
    final RecordService _recordService = RecordService();

    void _dialogEditRec(BuildContext context, RecordDTO givenRecord) async {
        Navigator.pop(context);
        showDialog(
            context: context,
            builder: (context) {
                return RecordCreationDialog(edit:true, record:givenRecord);
            });
    }

    void _deleteRecord(BuildContext context, String recordId) async  {
        await _recordService.delete(recordId);
        if(context.mounted) Navigator.pop(context);
    }

	@override
	Widget build(BuildContext context) {
		double width = MediaQuery.of(context).size.width;
		
		return AlertDialog(
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.050)),
			title: const Text(
					"Registro",
					textAlign: TextAlign.center,
					style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
			),
			content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Text(
              'Nome: ${widget.record.name}', 
              style: const TextStyle( fontSize: 20.0 )
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                const Text(
                  "Tipo: ", 
                  textAlign: TextAlign.left,
                  style: TextStyle( fontSize: 20.0 )
                ),
                InkWell(
                  child: Container(
                    decoration: BoxDecoration( 
                      shape: BoxShape.circle, 
                      color: (widget.record.type == RecordDTO.incomeKey) ? Colors.green : Colors.red,
                    ),
                    child: Icon( 
                      (widget.record.type == RecordDTO.incomeKey) ? Icons.arrow_upward_outlined :  Icons.arrow_downward_outlined,
                      color: const Color.fromARGB(255, 255, 255, 255), 
                      size: 25
                    ),
                  ),
                ),
                Text(
                  (widget.record.type == RecordDTO.incomeKey) ? " Saldo" : " Despesa", 
                  style: const TextStyle( fontSize: 20.0 ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              'Valor: ${widget.record.amount}', 
              style: const TextStyle( fontSize: 20.0 ),
              textAlign: TextAlign.left,

            ),
            const SizedBox(height: 10),
            Text(
              'Data: ${widget.record.date.toString().split('T')[0].replaceAll("-", "/")}', 
              style: const TextStyle( fontSize: 20.0 ),
              textAlign: TextAlign.left,
            ),
            const SizedBox(height: 10),
            const Text(
              'Descrção', 
              style: TextStyle( fontSize: 20.0, fontWeight: FontWeight.bold )
            ),
            Text(
              widget.record.description ?? "Sem descrição", 
              style: const TextStyle( fontSize: 15.0 )
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                    onTap: () => _deleteRecord(context, widget.record.getId()),

                    child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration( 
                            shape: BoxShape.circle, 
                            color: Colors.grey[300],
                        ),
                        child: const Icon( 
                        Icons.delete_outlined,
                            color: Colors.black87, 
                            size: 18
                        ),
                    ),
                ),
                InkWell(
                  onTap: () => _dialogEditRec(context, widget.record),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration( 
                      shape: BoxShape.circle, 
                      color: Colors.grey[300],
                    ),
                    child: const Icon( 
                      Icons.create,
                      color: Colors.black87, 
                      size: 18,
                    ),
                  ),
                )
              ],
            ),
          ],
        )
    );
	}
}


