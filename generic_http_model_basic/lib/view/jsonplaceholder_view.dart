import 'package:flutter/material.dart';

import '../viewmodel/jsonplaceholder_viewmodel.dart';

class JsonPlaceHolderView extends StatefulWidget {
  @override
  _JsonPlaceHolderViewState createState() => _JsonPlaceHolderViewState();
}

class _JsonPlaceHolderViewState extends JsonPlaceHolderViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("GENERIC MODEL POSTS - USERS"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => getAllPosts(),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            return isLoading == false && posts.isNotEmpty
                ? Card(
                    child: ListTile(
                      title: Text(posts[index].title),
                      subtitle: Text(posts[index].body),
                    ),
                  )
                : Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
