# flutter-works
##### This repo contains my personal Flutter practices. Projects and contents are as follows: <br>
* ##### firebase-work : This project created for practicing firebase firestore crud operations with Provider state management. I used MVVM architecture simply. File structures as following:
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
* ##### flask-connection : This project occurs of two parts. Part one as flask_api converting a rgb image into black-white format and return as a respone. And part wo as flutter_client show this responses. For example:
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
<img src=https://user-images.githubusercontent.com/60006881/124906606-e8bfe500-dfef-11eb-8edf-72daee16b793.png width=300> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
<img src=https://user-images.githubusercontent.com/60006881/124907805-4143b200-dff1-11eb-9ead-3f40e9f67fcc.png width=300><br>

* ##### food_app_design : This project created for Flutter design practicing. I used *curved_navigation_bar* and *carousel_slider* package.
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://user-images.githubusercontent.com/60006881/117586861-8c416600-b123-11eb-810d-3acba12aa261.png" width="300px"></img> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <img src="https://user-images.githubusercontent.com/60006881/117586873-9b281880-b123-11eb-8e3f-5bb449917dc7.png" width="300px"><br>

* ##### generic_http_model_basic : This project implements generic type model for http responses. For requests I used jsonplaceholder service. File structures as following:
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
##### Generic models handled by IBaseModel and IBaseService class.

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


