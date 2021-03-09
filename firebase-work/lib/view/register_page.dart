import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_model/motto_view_model.dart';
import 'home_page.dart';
import 'login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
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
                  register(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => LoginPage()),
                    ),
                    child: Text("I have an account already", style: TextStyle(color: Colors.black)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  register() {
    final viewModel = Provider.of<MottoViewModel>(context, listen: true);

    return ElevatedButton(
      child: viewModel.state == AppState.LOADING
          ? CircularProgressIndicator()
          : Text(
              "Register",
              style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
            ),
      onPressed: () async {
        bool result = await viewModel.registerWithEmail(_email, _password);
        if (result) {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => HomePage(),
          ));
        }
      },
    );
  }
}
