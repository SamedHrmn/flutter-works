# flutter-works
##### This repo contains my personal Flutter practices. Projects and contents are as follows: <br>
* <h3> firebase-work</h3> This project created for practicing firebase firestore crud operations with Provider state management. I used MVVM architecture simply. File structures as following:
<pre>
     lib--                                        App Features:
         |                                            - Sign In,Sign Up Firebase
         |__model                                     - CRUD operations for mottos.
                |__motto_model.dart
         |__repository                            
                |__my_respository.dart
         |__service
                |__firebase_auth.service.dart
                |__firestore_service.dart
         |__utils
                |__locator.dart
         |__view
                |__home_page.dart
                |__login_page.dart
                |__register_page.dart
                |__router_page.dart
         |__view_model
                |__motto_view_model.dart
         form_screen.dart
         main.dart
</pre><br>
* <h3> flask-connection</h3> This project occurs of two parts. Part one as flask_api converting a rgb image into black-white format and return as a respone. And part wo as flutter_client show this responses. For example:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src=https://user-images.githubusercontent.com/60006881/124906606-e8bfe500-dfef-11eb-8edf-72daee16b793.png width=300> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src=https://user-images.githubusercontent.com/60006881/124907805-4143b200-dff1-11eb-9ead-3f40e9f67fcc.png width=300><br>

* <h3>food_app_design</h3> This project created for Flutter design practicing. I used *curved_navigation_bar* and *carousel_slider* package.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://user-images.githubusercontent.com/60006881/117586861-8c416600-b123-11eb-810d-3acba12aa261.png" width="300px"></img> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://user-images.githubusercontent.com/60006881/117586873-9b281880-b123-11eb-8e3f-5bb449917dc7.png" width="300px"><br>

* <h3>generic_http_model_basic</h3> This project implements generic type model for http responses. For requests I used jsonplaceholder service. File structures as following:
<pre>
     lib--                                        
         |                                            
         |__model                                  
                |__base_model.dart
                |__post_model.dart
                |__user_model.dart
         |__service
                |__base_service.dart
                |__jsonplaceholder_service.dart
         |__view
                |__jsonplaceholder_view.dart
         |__view_model
                |__jsonplaceholder_viewmodel.dart
         main.dart
</pre>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Generic models handled by IBaseModel and IBaseService class.

```dart
abstract class IBaseService {
    Future<dynamic> get<T extends IBaseModel>({String path, IBaseModel model});
}

abstract class IBaseModel<T> {
    Map<String, Object> toJson();
    T fromJson(Map<String, Object> json);
}
```
<br>

* <h3>method_channel_notification</h3> This project use method channel and access native kotlin code for show in app notification. Flutter method channel requests handled by this code below side of Kotlin,
 ```kotlin
private val CHANNEL = "notification"
MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
        if (call.method == "showNotification") {
            showNotification()
            result.success("Service is started !")
        }
        if(call.method == "removeNotification"){
            removeNotification()
            result.success("Notification removed !")
        }
    }
}
 ```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;In Flutter side we created MethodChannel instance and invoke methods that must be written.showNotification and &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;removeNotification must be implemented in native side.
 ```dart
 showNotification() async {
  var response =
      await MyHome.platformChannel.invokeMethod('showNotification');
  setState(() {
    _response = response;
  });
}

removeNotification() async {
  var response =
      await MyHome.platformChannel.invokeMethod('removeNotification');
  setState(() {
    _response = response;
  });
}
```
<br>

* <h3>pose_detection</h3> This project detect some body parts and apply a bunny filter for head via use PoseNet model. *tflite* and *camera* plugin was used for this. Model loading code section is like this below,
```dart
loadModel() async {
    String model = await Tflite.loadModel(model: AssetConstants.POSE_MODEL_TFLITE);
    setState(() {
      _model = model;
    });
  }
```
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=https://user-images.githubusercontent.com/60006881/124915178-eb273c80-dff9-11eb-8308-ec2bc4a4a1d0.png width=300><br>

* <h3>vokal_baglama_detection_tflite</h3> This project detect my vocal sound and my baglama instrument sound. A custom .tflite model created via Google Teachable Machine was used for this project.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<img src=https://user-images.githubusercontent.com/60006881/124917778-e87a1680-dffc-11eb-80fc-b0320e7ef38a.png width=70%><br>

* <h3>weather_bloc</h3> This project was created from https://bloclibrary.dev/#/flutterweathertutorial tutorial. Weather app , it was used https://www.metaweather.com for weather data. File structures as following:
<pre>
     lib--                                        App Features:
         |                                            - BloC state management
         |__models                                    - Refresh view and fetch api data
                |__weather_model.dart                 - Dynamic theme
         |__repositories                           
                |_weather_api_client.dart
                |_weather_repository.dart
         |__view
                |__city_selection_screen.dart
                |__weather_screen.dart
         |__viewmodels\blocs
                |__theme_bloc
                        |__theme_bloc.dart
                        |__theme_event.dart
                        |__theme_state.dart
                |__weather_bloc
                        |__weather_bloc.dart
                        |__weather_state.dart
                        |__weather_event.dart
         |__widgets
                |__combined_weather_temperature.dart
                |__gradient_container_widget.dart
                |__last_updated_widget.dart
                |__location_widget.dart.dart
                |__temperature_widget.dart
                |__weather_condition_widget.dart
         main.dart
</pre><br>
