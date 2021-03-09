import '../form_screen.dart';
import '../view_model/motto_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    loadMottos();
  }

  loadMottos() {
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      context.read<MottoViewModel>().readMotto();
      context.read<MottoViewModel>().getUserUid();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mottos"),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FormScreen(),
          settings: RouteSettings(arguments: false),
        )),
      ),
      body: SafeArea(
        child: Consumer<MottoViewModel>(
          builder: (context, viewModel, child) {
            if (viewModel.state == AppState.LOADING) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: viewModel.mottos.length,
              itemBuilder: (context, index) {
                return Slidable(
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: 150,
                    child: Card(
                      elevation: 5,
                      shape: Border.all(color: viewModel.userUid == viewModel.mottos[index].userID ? Colors.green : Colors.blue, width: 2),
                      margin: const EdgeInsets.all(16),
                      child: ListTile(
                        title: Text(
                          viewModel.mottos[index].name!,
                          style: TextStyle(color: Colors.black, fontSize: 12),
                        ),
                        subtitle: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child:
                              Text(viewModel.mottos[index].motto!, style: TextStyle(color: Colors.black, fontSize: 15, fontStyle: FontStyle.italic)),
                        ),
                      ),
                    ),
                  ),
                  actionPane: SlidableBehindActionPane(),
                  secondaryActions: [
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => removeMotto(viewModel, viewModel.mottos[index].mottoID!),
                    ),
                    IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => FormScreen(
                                id: viewModel.mottos[index].mottoID,
                                name: viewModel.mottos[index].name,
                                motto: viewModel.mottos[index].motto,
                              ),
                          settings: RouteSettings(arguments: true))),
                    ),
                  ],
                  enabled: viewModel.userUid == viewModel.mottos[index].userID ? true : false,
                );
              },
            );
          },
        ),
      ),
    );
  }

  removeMotto(MottoViewModel viewModel, String mottoId) async {
    await viewModel.removeMotto(mottoId);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        "Motto remove successfully",
      ),
      duration: Duration(seconds: 1),
    ));
  }
}
