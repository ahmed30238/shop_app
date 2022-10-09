import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/component/components/shared.dart';
import 'package:flutter_application_1/shared/component/constants/theme/theme.dart';
import 'package:flutter_application_1/general_cubit/cubit.dart';
import 'package:flutter_application_1/general_cubit/states.dart';
import 'package:flutter_application_1/screens/layout/home.dart';
import 'package:flutter_application_1/screens/login_screen/loginscreen.dart';
import 'package:flutter_application_1/screens/onboarding_screen/onboardscreen.dart';
import 'package:flutter_application_1/shared/network/remote/diohelper.dart';
import 'package:flutter_application_1/shared/network/local/sharedpref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'observer.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () async {
      DioHelper.init();
      await CachHelper.init();
       bool? onBoarding = CachHelper.getData(
          key: 'onBoarding',
        );
      //  bool? onBoarding = false;
      token = CachHelper.getData(key: 'token');
      print(token);

      Widget startWidget;

      if (onBoarding!) {
        if (token != null) {
          startWidget = const HomeLayout();
        } else {
          startWidget = ShopLoginScreen();
        }
      } else {
        startWidget = OnBoarding();
      }

      bool isDark = CachHelper.getData(key: 'isDark');
      
      // bool isDark = false;

      runApp(
        MyApp(
          widget: startWidget,
          isDark: isDark,
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  MyApp({
    Key? key,
    required this.widget,
    required this.isDark,
  }) : super(key: key);
  final Widget widget;
  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GeneralCubit()
        ..getHomeData()
        ..getCatgoryData()
        ..getFavoritesData()
        ..getProfileData()
        ..changeThemeMode(fromShared: isDark),
      child: BlocConsumer<GeneralCubit, GeneralShopStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = GeneralCubit.get(context);
          var mode = cubit.isDark;
          return MaterialApp(
            theme: theme,
            darkTheme: darkTheme,
            themeMode: mode ? ThemeMode.dark : ThemeMode.light,
            debugShowCheckedModeBanner: false,
            home: widget,
          );
        },
      ),
    );
  }
}
