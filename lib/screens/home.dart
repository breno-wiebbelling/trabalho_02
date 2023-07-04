import 'package:flutter/material.dart';
import 'package:flutter_application_1/record/record_dto.dart';

class HomeScreen extends StatefulWidget {
    final bool isCurrent = true;

    const HomeScreen({Key? key}) : super(key: key);

    @override
    _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
    ScrollController? scrollController;
    
    late int currentYear;
    late int currentMonth;
    late int currentIndex;    

    List<RecordDTO> records = [];
    List<RecordDTO> selectedRecords = [];
    late List<String> months;

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

        loadCredentials().then((value) => setState(() { }));
    }

    void scrollToIndex(int index) {

        if(index == 0){
            currentYear = currentYear-1;
            currentMonth = currentIndex = 12;
        }else if(index == 13){
            currentYear = currentYear+1;
            currentMonth = currentIndex = 1;
        }else{
            currentMonth = currentIndex = index;
            currentIndex = index; 
        }

        setState(() { });
    }

    Future<void> loadCredentials() async {
        int val = 4;
        records.addAll([
            RecordDTO(DateTime.now(),"Conta de luz", "expense", val.toDouble(), "description"),
            RecordDTO(DateTime.now(),"Conta de luz", "expense", val.toDouble(), "description"),
            RecordDTO(DateTime.now(),"Conta de luz", "expense", val.toDouble(), "description"),
            RecordDTO(DateTime.now(),"Conta de luz", "expense", val.toDouble(), "description"),
            RecordDTO(DateTime.now(),"Conta de luz", "expense", val.toDouble(), "description"),
            RecordDTO(DateTime.now(),"Conta de luz", "expense", val.toDouble(), "description"),
            RecordDTO(DateTime.now(),"Conta de luz", "expense", val.toDouble(), "description"),
            RecordDTO(DateTime.now(),"Conta de luz", "expense", val.toDouble(), "description"),
            RecordDTO(DateTime.now(),"Conta de luz", "expense", val.toDouble(), "description")
        ]);

        selectedRecords = records;
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Column(
                    children: [
                        Text("Olá", style: TextStyle( color: Color.fromARGB(255, 53, 53, 53), fontSize: 15.0 )),
                    ],
                ),
                backgroundColor: Colors.transparent,
                elevation: 0
            ),
            body: Column(
                children: [
                    Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.width*0.15,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
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
                                        color: index == currentIndex ? Colors.blue : const Color.fromARGB(255, 192, 192, 192),
                                        child: Center(
                                            child: Text(
                                                months[index],
                                                style: const TextStyle( color: Colors.white, fontSize: 20.0, fontWeight: FontWeight.bold ),
                                            ),
                                        ),
                                    ),
                                );
                            },
                        ), 
                    ),
                    const SizedBox(height:10),
                    Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            // color: Repository.accentColor(context),
                        ),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                                InkWell(
                                    // onTap: () => item['route'] == null
                                    //     ? null
                                    //     : Navigator.push(context,
                                    //         MaterialPageRoute(builder: (c) => item['route'])),
                                    child: Container(
                                        padding: const EdgeInsets.all(16),
                                        decoration: const BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.green,
                                        ),
                                        child: const Icon( 
                                            Icons.arrow_downward_outlined,
                                            color: Color.fromARGB(255, 255, 255, 255), 
                                            size: 20
                                        ),
                                    ),
                                )
                            ],
                        ),
                    ),
                    const SizedBox(height:10),
                    Container(
                        width: MediaQuery.of(context).size.width-5,
                        height: MediaQuery.of(context).size.width*1,
                        padding: const EdgeInsets.all(16),
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: records.length,
                            itemBuilder: (BuildContext context, int index) {
                                final rec = selectedRecords[index];
                                return ListTile(
                                isThreeLine: true,
                                minLeadingWidth: 10,
                                minVerticalPadding: 20,
                                contentPadding: const EdgeInsets.all(0),
                                leading: Container(
                                    width: 40,
                                    height: 40,
                                    padding: const EdgeInsets.all(8),
                                    decoration: BoxDecoration(
                                        color: Colors.amber,
                                        boxShadow: [
                                            BoxShadow(
                                                offset: const Offset(0, 1),
                                                color: Colors.white.withOpacity(0.1),
                                                blurRadius: 2,
                                                spreadRadius: 1,
                                            )
                                        ],
                                        shape: BoxShape.circle,
                                    ),
                                    child: index == 0
                                        ? const Icon( Icons.arrow_downward_outlined,
                                            color: Color(0xFFFF736C), size: 20)
                                        : const SizedBox()),
                                title: Text(rec.name ?? ""),
                                subtitle: Text(rec.name ?? ""),
                                trailing: 
                                    Text(
                                        rec.name ?? "",
                                        style: const TextStyle(fontSize: 17, color: Color.fromARGB(255, 53, 52, 52))
                                    ),
                                );
                            }
                            ,
                        ), 
                    ),
                ],
            ),
        );
    }
}
