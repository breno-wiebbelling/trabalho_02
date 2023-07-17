import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/user/update/update_credentials.dart';
import 'package:flutter_application_1/screens/user/update/update_password.dart';
import 'package:flutter_application_1/user/user_dto.dart';
import 'package:flutter_application_1/user/user_service.dart';

class ProfileScreen extends StatefulWidget {
    final bool isCurrent = true;
    static const routeName = '/profile';

    const ProfileScreen({Key? key}) : super(key: key);

    @override
    _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  
    UserDTO? userDTO;
    UserService userService = UserService();

    @override
    void initState(){
        super.initState();

        loadCredentials().then((value) => setState(() { }));
    }

    Future<void> loadCredentials() async {
        if(await userService.isLoggedId()){
            userDTO = await userService.get();
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: const Column(
                    children: [
                        Text(
                            "Perfil", 
                            style: TextStyle( 
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
                elevation: 0
            ),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 40),
                          child: Text('Nome: ${userDTO?.username}')
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 40),
                          child: Text('Email: ${userDTO?.email}')
                        ),
                        const SizedBox(height: 16),
                        Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[600],
                                    foregroundColor: Colors.white, 
                                ),
                                onPressed: () => Navigator.of(context).pushNamed( UpdateCredentialsScreen.routeName ),
                                child: const Text('Alterar dados'),
                            ),
                        ),
                        const SizedBox(height: 16),
                        Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.green[600],
                                    foregroundColor: Colors.white, 
                                ),
                                onPressed: () => Navigator.of(context).pushNamed( UpdateUserPasswordScreen.routeName ),
                                child: const Text('Alterar senha'),
                           )
                        ),
                        const SizedBox(height: 16),        
                        Center(
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red[600],
                                    foregroundColor: Colors.white, 
                                ),
                                onPressed: () => userService.logout(context),
                                child: const Text('Sair')
                            )
                        ),          
                    ],

                ),
            )
        );
    }
}
