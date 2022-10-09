import 'package:flutter_application_1/models/shop_login_model.dart';

abstract class ShopRegisterStates {}

class ShopRegisterInitState extends ShopRegisterStates{}

class ShowRegisterPassState extends ShopRegisterStates{}

class ShopRegisterScreenSuccessState extends ShopRegisterStates{

  final ShopLoginModel loginModel;
  ShopRegisterScreenSuccessState(this.loginModel);
}

class ShopRegisterScreenLoadingState extends ShopRegisterStates{}

class ShopRegisterScreenErrorState extends ShopRegisterStates{
  final String error;
  ShopRegisterScreenErrorState(this.error);
}


