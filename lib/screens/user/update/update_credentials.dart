import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home.dart';
import 'package:flutter_application_1/screens/user/update/user_update_dto.dart';
import 'package:flutter_application_1/user/user_service.dart';

class UpdateCredentialsScreen extends StatefulWidget {
    static const routeName = '/update/credentials';

    const UpdateCredentialsScreen({super.key});

    @override
    State<UpdateCredentialsScreen> createState() => UpdateCredentialsScreenState();
}

class UpdateCredentialsScreenState extends State<UpdateCredentialsScreen> {
    final _formKey = GlobalKey<FormState>();

    final TextEditingController _usernameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();

    final UserService _userService = UserService();

    @override
    void initState() {
        super.initState();

        _userService
            .get()
            .then((value) {
              _usernameController.text = value.username ?? "";
              _emailController.text    = value.email ?? "";
            })
            .then((value) => setState(() { }));
    }

    Future<void> _onSubmit(BuildContext context) async {
        if (_formKey.currentState!.validate()) {
            try{
                await _userService
                    .updateUserCredentials( UserUpdateDTO(_usernameController.text, _emailController.text, _passwordController.text, ""))
                    .then((value) {
                        if( context.mounted ) {
                            Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.routeName,
                                ModalRoute.withName('/')
                            );
                        }  
                    });
            }catch(e){
                ScaffoldMessenger
                    .of(context)
                    .showSnackBar(SnackBar( content: Text(e.toString()) ));
            }
           
        }
    }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
            title: const Column(
                children: [
                    Text(
                        "Cadastro", 
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
        body: Form(
            key: _formKey,
            child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
                const Text(
                    'Cadastro',
                    style: TextStyle( fontSize: 24, fontWeight: FontWeight.bold ),
                ),
                const SizedBox(height: 16),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20), 
                    child:  TextFormField(
                        controller: _usernameController,
                        decoration: const InputDecoration( labelText: 'Username', border: OutlineInputBorder() ),
                    ),
                ),
                const SizedBox(height: 16),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20), 
                    child:  TextFormField(
                        controller: _emailController,
                        decoration: const InputDecoration( labelText: 'Email', border: OutlineInputBorder() ),
                    ),
                ),
                const SizedBox(height: 16),
                Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20), 
                    child:  TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration( labelText: 'Password', border: OutlineInputBorder() ),
                        validator: (value) => (value!.isEmpty) ? "Insira a sua senha atual": null,
                    ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                    onPressed: () => _onSubmit(context),
                    child: const Text('Enviar'),
                ),
            ],
            ),
        ),
        );
    }
}
