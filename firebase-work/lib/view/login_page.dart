import 'package:firebase_work/form_screen.dart';
import 'package:firebase_work/view/home_page.dart';
import 'package:firebase_work/view/register_page.dart';
import 'package:firebase_work/view_model/motto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Firestore CRUD"),
      ),
      body: Form(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(16), border: Border.all(width: 2, color: Colors.grey)),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Email",
                        hintText: "Email",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => _email = value,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Password",
                        hintText: "Password..",
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) => _password = value,
                    ),
                  ),
                  login(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => RegisterPage()),
                    ),
                    child: Text(
                      "I need to signup",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  login() {
    final viewModel = Provider.of<MottoViewModel>(context, listen: true);

    return Container(
      width: MediaQuery.of(context).size.width / 4,
      child: OutlinedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<OutlinedBorder>(StadiumBorder()),
            side: MaterialStateProperty.resolveWith<BorderSide>((states) => BorderSide(color: Colors.blue)),
            overlayColor: MaterialStateProperty.resolveWith((states) {
              if (states.contains(MaterialState.pressed)) {
                return Colors.red;
              }
            })),
        child: viewModel.state == AppState.LOADING
            ? CircularProgressIndicator()
            : Text(
                "Login",
                style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.black),
              ),
        onPressed: () async {
          bool result = await (viewModel.loginWithMail(_email, _password));
          if (result) {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => HomePage(),
            ));
          }
        },
      ),
    );
  }
}
