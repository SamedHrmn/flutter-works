import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_client/service.dart';
import 'package:image_picker/image_picker.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with SingleTickerProviderStateMixin {
  dynamic _response = "";
  String _value;
  PickedFile pickedFile;
  ImagePicker imagePicker;
  Uint8List responseImage;

  AnimationController _animationController;
  Animation _colorTweenRgb;
  Animation _colorTweenGrey;

  @override
  void initState() {
    super.initState();

    imagePicker = ImagePicker();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 1999));
    _colorTweenRgb = ColorTween(begin: Colors.red, end: Colors.blue).animate(_animationController);
    _colorTweenGrey = ColorTween(begin: Colors.black, end: Colors.grey).animate(_animationController);
    changeColors();
  }

  Future changeColors() async {
    while (true) {
      await new Future.delayed(const Duration(seconds: 2), () {
        if (_animationController.status == AnimationStatus.completed) {
          _animationController.reverse();
        } else {
          _animationController.forward();
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text("Flask Example"),
      ),
      body: Column(
        children: [
          Spacer(),
          Expanded(
            flex: 3,
            child: Column(
              children: stringRequestPart(),
            ),
          ),
          Spacer(),
          Expanded(
            flex: 6,
            child: Column(
              children: imageRequestPart(),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }

  stringRequestPart() {
    return [
      Expanded(
        child: Padding(padding: EdgeInsets.all(8.0), child: Center(child: Text("Gelen deger:" + _response.toString()))),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: TextField(
            decoration: InputDecoration(border: OutlineInputBorder()),
            onChanged: (value) {
              setState(() {
                _value = value;
              });
            },
          ),
        ),
      ),
      Flexible(
        child: OutlinedButton(
          onPressed: postString,
          child: Text("POST STRING"),
        ),
      ),
    ];
  }

  postString() async {
    if (_value != null) {
      _response = await FlaskService.instance.postString(_value);
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lütfen ilgili alanı doldurunuz.")));
    }
  }

  imageRequestPart() {
    return [
      Expanded(
        flex: 6,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        children: galleryImageSection(),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Column(
                        children: responseImageSection(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      Flexible(
        child: OutlinedButton(
          onPressed: postImage,
          child: Text("POST IMAGE"),
        ),
      ),
      //Spacer(),
    ];
  }

  List<Widget> responseImageSection() {
    return [
      Expanded(
        child: AnimatedBuilder(
          animation: _colorTweenGrey,
          builder: (context, child) => Text("GREY",
              style: TextStyle(
                color: _colorTweenGrey.value,
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                shadows: [
                  BoxShadow(
                    color: _colorTweenGrey.value,
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              )),
        ),
      ),
      Expanded(
        flex: 8,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.6,
          child: responseImage != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(image: MemoryImage(responseImage), fit: BoxFit.cover)),
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.network(
                    "https://picsum.photos/300",
                    fit: BoxFit.cover,
                  ),
                ),
        ),
      ),
    ];
  }

  List<Widget> galleryImageSection() {
    return [
      Expanded(
        child: AnimatedBuilder(
          animation: _colorTweenRgb,
          builder: (context, child) => Text("COLORFUL",
              style: TextStyle(
                color: _colorTweenRgb.value,
                fontWeight: FontWeight.bold,
                fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
                shadows: [
                  BoxShadow(
                    color: _colorTweenRgb.value,
                    spreadRadius: 5,
                    blurRadius: 5,
                    offset: Offset(0, 1), // changes position of shadow
                  ),
                ],
              )),
        ),
      ),
      Expanded(
        flex: 4,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: pickedFile != null
              ? GestureDetector(
                  onTap: () => pickImageFromGallery(),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(image: FileImage(File(pickedFile.path)), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                )
              : GestureDetector(
                  child: CircleAvatar(
                    child: Icon(Icons.add_a_photo),
                  ),
                  onTap: () => pickImageFromGallery(),
                ),
        ),
      ),
    ];
  }

  pickImageFromGallery() async {
    pickedFile = await imagePicker.getImage(source: ImageSource.gallery);
    setState(() {});
  }

  postImage() async {
    if (pickedFile != null) {
      responseImage = await FlaskService.instance.postImage(File(pickedFile.path));
      setState(() {});
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Lütfen bir resim seçiniz")));
    }
  }
}
