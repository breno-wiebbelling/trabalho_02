import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:intl/intl.dart';
import 'package:flutter_application_1/record/record_dto.dart';
import 'package:flutter_application_1/record/record_service.dart';

class RecordCreationDialog extends StatefulWidget {

	final bool edit;
	final RecordDTO? record;

	const RecordCreationDialog({Key? key, required this.edit, this.record}) : super(key: key);
	
	@override
	_RecordCreationDialogState createState() => _RecordCreationDialogState();
}

class _RecordCreationDialogState extends State<RecordCreationDialog> {
  
  final RecordService recordService = RecordService();

	final _formKey = GlobalKey<FormState>();
	final TextEditingController _controllerValor = TextEditingController();
	final TextEditingController _controllerName = TextEditingController();
	final TextEditingController _controllerDescricao = TextEditingController();
  final TextEditingController _controllerDate = TextEditingController(); 
	int _groupValueRadio = 1;

	@override
	void initState() {
    if(widget.edit){
    	_groupValueRadio = (widget.record!.type!.contains(RecordDTO.incomeKey)) ? 1 : 2 ;
      _controllerName.text = widget.record!.name.toString();
      _controllerValor.text = widget.record!.amount.toString();
      _controllerDescricao.text = widget.record!.description.toString();
      _controllerDate.text = widget.record!.date.toString();
    }

		super.initState();
	}

	void _onSubmitCreate(BuildContext context) async {
		if (_formKey.currentState!.validate()) {
			try{
				await recordService.create(
          RecordDTO(
            "1", 
            _controllerName.text, 
            (_groupValueRadio == 1 ? RecordDTO.incomeKey : RecordDTO.expenseKey ), 
            double.parse(_controllerValor.text), 
            _controllerDate.text, 
            _controllerDescricao.text
          )
        );

        if (context.mounted) Navigator.pop(context);
			}catch(e){
				ScaffoldMessenger
					.of(context)
					.showSnackBar(SnackBar( content: Text(e.toString()) ));
			}
		}
	}

  void _onSubmitUpdate(BuildContext context) async {
		if (_formKey.currentState!.validate()) {
			try{
				await recordService.update(
          RecordDTO(
            widget.record!.getId().toString(), 
            _controllerName.text, 
            (_groupValueRadio == 1 ? RecordDTO.incomeKey : RecordDTO.expenseKey ), 
            double.parse(_controllerValor.text), 
            _controllerDate.text, 
            _controllerDescricao.text
          )
        );

        if (context.mounted) {

          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            ModalRoute.withName('/')
          );

        }

			}catch(e){
				ScaffoldMessenger
					.of(context)
					.showSnackBar(SnackBar( content: Text(e.toString()) ));
			}
		}
	}

	@override
	Widget build(BuildContext context) {
		double width = MediaQuery.of(context).size.width;
		
		return AlertDialog(
			shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(width * 0.050)),
			title: Text(
					(widget.edit) ? "Editar Registro" : "Novo Registro",
					textAlign: TextAlign.center,
					style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
			),
			content: Form(
				key: _formKey,
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					crossAxisAlignment: CrossAxisAlignment.center,
					children: [
            TextFormField(
							controller: _controllerName,
							maxLength: 30,
							decoration: InputDecoration( 
								labelText: 'Nome', 
								border: const OutlineInputBorder() ,
								hintText: (widget.edit) ? widget.record?.name.toString() : "",
								hintStyle: const TextStyle(color: Colors.white54),
							),
						),
						const SizedBox(height: 8),
						TextFormField(
							controller: _controllerValor,
							keyboardType: const TextInputType.numberWithOptions(decimal: true),
							maxLength: 7,
							decoration: const InputDecoration( 
								labelText: 'Valor', 
								border: OutlineInputBorder() ,
							),
						),
						const SizedBox(height: 8),
						Row(
							children: <Widget>[
								Radio(
									activeColor: Colors.green[900],
									value: 1,
									groupValue: _groupValueRadio,
									onChanged: (value) {
										setState(() {
											_groupValueRadio = value!;
										});
									},
								),
								Padding(
									padding: EdgeInsets.only(left: width * 0.01),
									child: const Text("Saldo"),
								)
							],
						),
						Row(
							children: <Widget>[
								Radio(
									activeColor: Colors.red[900],
									value: 2,
									groupValue: _groupValueRadio,
									onChanged: (value) {
										setState(() {
											_groupValueRadio = value!;
										});
									},
								),
								Padding(
									padding: EdgeInsets.only(left: width * 0.01),
									child: const Text("Despesa"),
								)
							],
						),
						const SizedBox(height: 8),
						TextFormField(
							controller: _controllerDescricao,
							maxLength: 50,
							decoration: InputDecoration( 
								labelText: 'Descrição', 
								border: const OutlineInputBorder() ,
								hintText: (widget.edit) ? widget.record?.description.toString() : "",
								hintStyle: const TextStyle(color: Colors.white54),
							),
						),
            TextField(
              controller: _controllerDate, 
              decoration: const InputDecoration( 
                icon: Icon(Icons.calendar_today), 
                labelText: "Insira a Data"
              ),
              readOnly: true, 
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context, initialDate: DateTime.now(),
                  firstDate: DateTime(2000), 
                  lastDate: DateTime(2101)
                );
                
                if(pickedDate != null ){
                  String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate); 

                  setState(() {
                      _controllerDate.text = formattedDate; 
                  });
                }
              },
            ),
						ElevatedButton(
							onPressed: () => (widget.edit) ? _onSubmitUpdate(context) : _onSubmitCreate(context),
							style: ElevatedButton.styleFrom(
								backgroundColor: Colors.green[400], 
								foregroundColor: Colors.white, 
							),
							child: Text((widget.edit) ? 'Salvar Edição' : 'Salvar Registro'),
						),
					],
				),
			),
		);
	}
}


