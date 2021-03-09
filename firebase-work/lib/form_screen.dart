import 'package:firebase_work/model/motto_model.dart';
import 'package:firebase_work/view/home_page.dart';
import 'package:firebase_work/view_model/motto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormScreen extends StatefulWidget {
  final name;
  final motto;
  final id;

  const FormScreen({Key? key, this.name, this.motto, this.id}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  String? _mottoValue;
  String? _nameValue;
  var isEdit;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    isEdit = ModalRoute.of(context)!.settings.arguments as bool;
    _mottoValue = widget.motto;
    _nameValue = widget.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(isEdit == true ? "Edit Your Motto" : "Save Your Motto"),
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
                      initialValue: isEdit == true ? widget.name : null,
                      onChanged: (value) => _nameValue = value,
                      decoration: InputDecoration(
                        labelText: "Name",
                        hintText: "Name",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextFormField(
                      initialValue: isEdit == true ? widget.motto : null,
                      onChanged: (value) => _mottoValue = value,
                      maxLines: 3,
                      decoration: InputDecoration(
                        labelText: "Motto",
                        hintText: "Your motto..",
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      child: Text(
                        isEdit == true ? "Update Motto" : "Save Motto",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(color: Colors.white),
                      ),
                      onPressed: () => isEdit == true ? _updateMotto(context, widget.id, _nameValue!, _mottoValue!) : _sendMotto(context))
                ],
              )),
        ))));
  }

  _sendMotto(BuildContext context) async {
    final _viewModel = Provider.of<MottoViewModel>(context, listen: false);
    await _viewModel.addMotto(motto: _mottoValue, name: _nameValue);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Motto was added succesfully"),
      duration: Duration(seconds: 1),
    ));
    await Future.delayed(Duration(seconds: 1)).whenComplete(() => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        )));
  }

  _updateMotto(BuildContext context, String mottoId, String nameValue, String mottoValue) async {
    final _viewModel = Provider.of<MottoViewModel>(context, listen: false);
    await _viewModel.updateMotto(mottoId, nameValue, mottoValue);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text("Motto was updated succesfully"),
      duration: Duration(seconds: 1),
    ));
    await Future.delayed(Duration(seconds: 1)).whenComplete(() => Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(),
        )));
  }
}
