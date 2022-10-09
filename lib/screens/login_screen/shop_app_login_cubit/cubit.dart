import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/shop_login_model.dart';
import 'package:flutter_application_1/screens/login_screen/shop_app_login_cubit/states.dart';
import 'package:flutter_application_1/shared/component/constants/endpoints/end_points.dart';
import 'package:flutter_application_1/shared/network/remote/diohelper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitState());

  static ShopCubit get(context) => BlocProvider.of(context);

  ShopLoginModel? loginModel;

  bool isShown = true;

  IconData suffixicon = Icons.remove_red_eye_outlined;

  void showPass() {
    isShown = !isShown;

    suffixicon =
        isShown ? Icons.remove_red_eye_outlined : Icons.visibility_off_outlined;

    emit(ShowPassState());
  }

  void userData({
    required String email,
    required String password,
  }) {
    emit(ShopLoginScreenLoadingState());
    DioHelper.postData(
      url: Login,
      data: {
        'email': email,
        'password': password,
      },
    ).then((value) {
      loginModel = ShopLoginModel.fromJson(value.data);
      emit(ShopLoginScreenSuccessState(loginModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopLoginScreenErrorState(error.toString()));
    });
  }
}
