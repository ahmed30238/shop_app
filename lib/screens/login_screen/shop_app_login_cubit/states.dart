import 'package:flutter_application_1/models/shop_login_model.dart';

abstract class ShopStates {}

class ShopInitState extends ShopStates{}

class ShowPassState extends ShopStates{}

class ShopLoginScreenSuccessState extends ShopStates{
 final ShopLoginModel loginModel;
  ShopLoginScreenSuccessState(this.loginModel);
  
}

class ShopLoginScreenLoadingState extends ShopStates{}

class ShopLoginScreenErrorState extends ShopStates{
  final String error;
  ShopLoginScreenErrorState(this.error);
}


