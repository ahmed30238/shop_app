import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop_login_model.dart';
import 'package:flutter_application_1/register_screen/shop_app_register_cubit/states.dart';
import 'package:flutter_application_1/shared/component/constants/endpoints/end_points.dart';
import 'package:flutter_application_1/shared/network/remote/diohelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopRegisterCubit extends Cubit<ShopRegisterStates> {
  ShopRegisterCubit() : super(ShopRegisterInitState());

  static ShopRegisterCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  bool isShown = true;

  IconData suffixicon = Icons.remove_red_eye_outlined;

  void showPass() {
    isShown = !isShown;

    suffixicon =
        isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;

    emit(ShowRegisterPassState());
  }

  void userData({
    required String email,
    required String password,
    required String phone,
    required String name,
  }) {
    emit(ShopRegisterScreenLoadingState());
    DioHelper.postData(
      url: REGISTER,
      data: {
        'email': email,
        'password': password,
        'phone': phone,
        'name': name,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopRegisterScreenSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopRegisterScreenErrorState(error.toString()));
    });
  }
}
