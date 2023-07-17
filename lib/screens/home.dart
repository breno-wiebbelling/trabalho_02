import 'package:flutter/material.dart';
import 'package:flutter_application_1/record/record_dto.dart';
import 'package:flutter_application_1/record/record_service.dart';
import 'package:flutter_application_1/screens/records/record_creation_dialog.dart';
import 'package:flutter_application_1/screens/records/record_info_dialog.dart';
import 'package:flutter_application_1/screens/user/profile.dart';
import 'package:flutter_application_1/user/user_service.dart';

class HomeScreen extends StatefulWidget {
    final bool isCurrent = true;
    static const routeName = '/';

    const HomeScreen({Key? key}) : super(key: key);

    @override
    _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
    ScrollController? scrollController;
    UserService userService = UserService();
    RecordService recordService = RecordService();

    String username = "";
    late int currentYear;
    late int currentMonth;
    late int currentIndex;    

    List<RecordDTO> records = [];
    List<RecordDTO> selectedRecords = [];
    late List<String> months;

    String selectedFilter = "all";

    @override
    void initState(){
        super.initState();

        scrollController = ScrollController(initialScrollOffset: 0.0);
        currentMonth = currentIndex = DateTime.now().month;
        currentYear = DateTime.now().year;

        months = [
            (currentYear-1).toString(),
            'Janeiro',
            'Fevereiro',
            'Março',
            'Abril',
            'Maio',
            'Junho',
            'Julho',
            'Agosto',
            'Setembro',
            'Outubro',
            'Novembro',
            'Dezembro',
            (currentYear+1).toString(),
        ];

        loadCredentials(context).then((value) { setState(() { }); });
    }

    void scrollToIndex(int index) {
        if(index == 0){
            currentYear = currentYear-1;
            currentMonth = 12;
            currentIndex = 12;
            months[0] = (currentYear-1).toString();
            months[13] = (currentYear+1).toString();

        }else if(index == 13){
            currentYear = currentYear+1;
            currentMonth = 1;
            currentIndex = 1;
            months[0] = (currentYear-1).toString();
            months[13] = (currentYear+1).toString();

        }else{
            currentMonth = index;
            currentIndex = index; 
        }

        _loadRecords();

        setState(() { });
    }

    Future<void> loadCredentials(BuildContext context) async {
        if(await userService.isLoggedId()){
            username = await userService
                .get()
                .then((value) => value.username ?? "");
                
            return _loadRecords();
        }
    }

    void _loadRecords() async {

      selectedFilter = "all";
      records = await recordService.getRecordsByMonthAndYear(currentMonth, currentYear);
      selectedRecords = records;

      setState(() { });
    }

    void filterRecords(String type){
        selectedFilter = type;

        if(type != "all"){
            selectedRecords = records
                .where((r) => r.type == type)
                .toList();
        }else{
            selectedRecords = records;
        }

        setState(() { });
    }

    void _dialogAddRec(BuildContext context) {
      showDialog(
          context: context,
          builder: (context) {
            return const RecordCreationDialog(edit:false);
          })
          .then((value) => _loadRecords());
    }

    void _dialogShowRec(BuildContext context, RecordDTO givenRecord) {
      showDialog(
          context: context,
          builder: (context) {
            return RecordInfoDialog(record:givenRecord);
          })
          .then((value) => _loadRecords());
    }
 
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Column(
                    children: [
                        Text(
                            'Olá, $username', 
                            style: const TextStyle( 
                                color: Color.fromARGB(255, 255, 255, 255), 
                                fontSize: 15.0 
                            )
                        ),
                    ],
                ),
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(25),
                        bottomLeft:  Radius.circular(25)
                    ),
                ),
                backgroundColor: const Color(0xFF242424),
                actions: [
                    InkWell(
                        onTap: () => { Navigator.of(context).pushNamed( ProfileScreen.routeName ) },
                        child: Container(
                            padding: const EdgeInsets.all(5),
                            margin: const EdgeInsets.fromLTRB(0, 0, 20, 0),
                            decoration: const BoxDecoration( 
                                shape: BoxShape.circle, 
                                color: Color.fromARGB(255, 228, 228, 228),
                            ),
                            child: const Icon( 
                                Icons.person,
                                color: Color(0xFF242424), 
                                size: 20
                            ),
                        ),
                    ),
                ],
                elevation: 0
            ),
            body: Column(
                children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width*0.15,
                        margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            controller: scrollController,
                            itemCount: months.length,
                            itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                    onTap: () => scrollToIndex(index),
                                    child: Container(
                                        width: 120.0,
                                        margin: const EdgeInsets.all(8.0),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(15),
                                            color: index == currentIndex ? const Color(0xFF242424) : const Color.fromARGB(207, 150, 150, 150),
                                        ),
                                        child: Center(
                                            child: Text( months[index], style: const TextStyle( color: Colors.white, fontSize: 20.0 )),
                                        ),
                                    ),
                                );
                            },
                        ), 
                    ),
                    const SizedBox(height:10),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        width: MediaQuery.of(context).size.width-25,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: const Color(0xFF242424),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                InkWell(
                                    onTap: () => { filterRecords(RecordDTO.expenseKey) },
                                    child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration( 
                                            shape: BoxShape.circle, 
                                            color: Colors.red,
                                            border: Border.all(color: (selectedFilter == RecordDTO.expenseKey)?Colors.white:Colors.transparent)
                                        ),
                                        child: const Icon( 
                                            Icons.arrow_downward_outlined,
                                            color: Color.fromARGB(255, 255, 255, 255), 
                                            size: 18
                                        ),
                                    ),
                                ),
								                InkWell(
                                    onTap: () => { filterRecords(RecordDTO.incomeKey) },
                                    child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration( 
                                            shape: BoxShape.circle, 
                                            color: Colors.green,
                                            border: Border.all(color: (selectedFilter == RecordDTO.incomeKey)?Colors.white:Colors.transparent)
                                        ),
                                        child: const Icon( 
                                            Icons.arrow_upward_outlined,
                                            color: Color.fromARGB(255, 255, 255, 255), 
                                            size: 18
                                        ),
                                    ),
                                ),
								                InkWell(
                                    onTap: () => { filterRecords("all") },
                                    child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: BoxDecoration( 
                                            shape: BoxShape.circle, 
                                            color: Colors.blue,
                                            border: Border.all(color: (selectedFilter == "all")?Colors.white:Colors.transparent)
                                        ),
                                        child: const Icon( 
                                            Icons.filter_list_off,
                                            color: Color.fromARGB(255, 255, 255, 255), 
                                            size: 18
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                    const SizedBox(height:10),
                    Container(
                        width: MediaQuery.of(context).size.width-5,
                        height: MediaQuery.of(context).size.width-10,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: selectedRecords.length,
                            itemBuilder: (BuildContext context, int index) {
                                RecordDTO rec = selectedRecords[index];
                                return ListTile(
                                    title: Text(rec.name ?? ""),
                                    subtitle: Text(rec.date.toString().split('T')[0].replaceAll("-", "/")),
                                    trailing: Text(rec.amount.toString(), style: const TextStyle(fontSize: 14, color: Color.fromARGB(255, 56, 56, 56) ) ),
                                    isThreeLine: true,
                                    minLeadingWidth: 10,
                                    minVerticalPadding: 20,
                                    contentPadding: const EdgeInsets.all(0),
                                    onTap: () => _dialogShowRec(context, selectedRecords[index]),
                                    leading: Container(
                                        width: 40,
                                        height: 40,
                                        padding: const EdgeInsets.all(8),
                                        decoration: BoxDecoration(
                                            color: (rec.type == RecordDTO.expenseKey) ? Colors.red : Colors.green,
                                            shape: BoxShape.circle,
                                        ),
                                        child: Icon( 
                                            (rec.type == RecordDTO.expenseKey) 
                                                ? Icons.arrow_downward_outlined 
                                                : Icons.arrow_upward_outlined, 
                                            color: const Color.fromARGB(255, 255, 255, 255), 
                                            size: 20
                                        )
                                    ),
                                );
                            }
                        ),
                    ),
                ],
            ),
            bottomNavigationBar: BottomAppBar(
                shape:  const CircularNotchedRectangle(),
                color: const Color(0xFF242424),
                child: Container(height: 50),
            ),
            floatingActionButton: FloatingActionButton(
                onPressed: () => { _dialogAddRec(context) },
                child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        );
    }
}
