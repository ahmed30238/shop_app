import 'package:flutter/material.dart';
import 'package:flutter_application_1/shared/component/constants/theme/theme.dart';
import 'package:flutter_application_1/screens/login_screen/loginscreen.dart';
import 'package:flutter_application_1/shared/network/local/sharedpref.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class ItemModel {
  String? image;
  String? title;
  String? body;

  ItemModel(
    this.image,
    this.title,
    this.body,
  );
}

class OnBoarding extends StatefulWidget {
  OnBoarding({Key? key}) : super(key: key);

  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  List<ItemModel> Data = [
    ItemModel(
      'assets/svg-images/illustration.svg',
      'on Board title1',
      'on board body1',
    ),
    ItemModel(
      'assets/svg-images/illustration1.svg',
      'title2',
      'body2',
    ),
    ItemModel(
      'assets/svg-images/illustration2.svg',
      'title3',
      'body3',
    ),
  ];

  bool isLast = false;

  var indController = PageController();
/*
 bool isDark = false;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CachHelper.setBoolean(key: 'isDark', value: isDark).then((value) {
        emit(ChangeThemeMode());
      }).catchError((error) {
        print(error.toString());
      });
*/
  void onSubmit() {
    CachHelper.saveData(
      key: 'onBoarding',
      value: true,
    ).then((value) {
      if (value) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ShopLoginScreen(),
          ),
        );
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ShopLoginScreen(),
        //   ),
        // );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: onSubmit,
            child: Text(
              'SKIP',
              style: Theme.of(context).textTheme.bodyText1!,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
                child: PageView.builder(
              onPageChanged: (index) {
                if (index == Data.length - 1) {
                  setState(() {
                    isLast = true;
                  });
                } else {
                  isLast = false;
                }
              },
              controller: indController,
              itemBuilder: (context, index) => buildBoardingItem(Data[index]),
              itemCount: Data.length,
            )),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: indController,
                  count: Data.length,
                  effect: const ExpandingDotsEffect(
                    spacing: 3,
                    expansionFactor: 2,
                    activeDotColor: Colors.purple,
                    dotHeight: 10,
                    dotWidth: 10,
                  ),
                ),
                const Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    indController.nextPage(
                      duration: const Duration(seconds: 1),
                      curve: Curves.easeIn,
                    );
                    if (isLast) {
                      onSubmit();
                    }
                  },
                  child: const Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(ItemModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          SvgPicture.asset('${model.image}',height: 500,),
          Text(
            '${model.title}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
          Text(
            '${model.body}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      );
}
