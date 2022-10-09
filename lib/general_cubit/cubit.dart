import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/search_model.dart';
import 'package:flutter_application_1/shared/component/components/shared.dart';
import 'package:flutter_application_1/models/categries_model.dart';
import 'package:flutter_application_1/models/change_favorites.dart';
import 'package:flutter_application_1/models/favorites_model.dart';
import 'package:flutter_application_1/models/home_model.dart';
import 'package:flutter_application_1/shared/component/constants/endpoints/end_points.dart';
import 'package:flutter_application_1/general_cubit/states.dart';
import 'package:flutter_application_1/models/shop_login_model.dart';
import 'package:flutter_application_1/screens/categories/categories_screen.dart';
import 'package:flutter_application_1/screens/favourites/favourites_screen.dart';
import 'package:flutter_application_1/screens/products/products_screen.dart';
import 'package:flutter_application_1/screens/settings/settings_screen.dart';
import 'package:flutter_application_1/shared/network/remote/diohelper.dart';
import 'package:flutter_application_1/shared/network/local/sharedpref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GeneralCubit extends Cubit<GeneralShopStates> {
  GeneralCubit() : super(ShopInitialState());

  static GeneralCubit get(context) => BlocProvider.of(context);

  bool isDark = false;

  void changeThemeMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CachHelper.saveData(key: 'isDark', value: isDark).then((value) {
        emit(ShopChangeThemeState());
      }).catchError((error) {
        print(error.toString());
      });
    }
  }

  int currentIndex = 0;

  List<Widget> bottomNavSceens = [
    const ProductsScreen(),
    const CategorisScreen(),
    const FavouritesScreen(),
    SettingScreen(),
  ];
  List<BottomNavigationBarItem> items = const [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.production_quantity_limits,
      ),
      label: 'Products',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.kitchen_rounded,
      ),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.favorite_outline,
      ),
      label: 'Favourites',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];
  void changeBottom(int index) {
    currentIndex = index;
    emit(ChangeBottomNavBar());
  }

  HomeModel? homeModel;

  Map<int, bool> favorites = {};

  void getHomeData({Map<String, dynamic>? query}) {
    emit(ShopLoadingHomeState());

    DioHelper.getData(
      url: HOME,
      token: token,
      query: query,
    ).then((value) {
      homeModel = HomeModel.fromJson(value.data);

      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({
          element.id!: element.inFavorites!,
        });
      });

      emit(
        ShopSuccesHomeState(),
      );
    }).catchError((error) {
      emit(
        ShopErrorHomeState(error.toString()),
      );
      if (kDebugMode) {
        print(
          error.toString(),
        );
      }
    });
  }

  CategoriesModel? categoryModel;
  void getCatgoryData() {
    DioHelper.getData(
      url: CATEGORY,
      token: token,
    ).then((value) {
      categoryModel = CategoriesModel.fromJson(
        value.data,
      );
      emit(ShopCategorySuccessState());
    }).catchError((error) {
      if (kDebugMode) {
        print(
          error.toString(),
        );
      }

      emit(ShopCaegoryErrorState());
    });
  }

  ChangeFavoritesModel? chageFavorites;

  void changeFavorites(int productsId) {
    favorites[productsId] = !favorites[productsId]!;
    emit(ShopChangeFavoritesState());

    DioHelper.postData(
      url: FAVORITES,
      data: {
        'product_id': productsId,
      },
      token: token,
    ).then(
      (value) {
        chageFavorites = ChangeFavoritesModel.fromJson(value.data);

        if (!chageFavorites!.status) {
          favorites[productsId] = !favorites[productsId]!;
        } else {
          getFavoritesData();
        }

        emit(ShopChangeFavoritesSuccessState(chageFavorites!));

        print(value.data);
      },
    ).catchError(
      (e) {
        favorites[productsId] = !favorites[productsId]!;
        emit(ShopChangeFavoritesErrorState());
        if (kDebugMode) {
          print(e.toString());
        }
      },
    );
  }

  FavoritesModel? favoritesModel;
  void getFavoritesData() {
    emit(ShopGetFavoritesLoadingState());
    DioHelper.getData(
      url: FAVORITES,
      token: token,
    ).then((value) {
      favoritesModel = FavoritesModel.fromJson(
        value.data,
      );
      emit(ShopGetFavoritesSucesssState());
    }).catchError((error) {
      if (kDebugMode) {
        print(
          error.toString(),
        );
      }

      emit(ShopGetFavoritesErrorState());
    });
  }

  ShopLoginModel? userModel;
  void getProfileData() {
    emit(ShopGetProfileLoadingState());
    DioHelper.getData(
      url: PROFILE,
      token: token,
    ).then((value) {
      userModel = ShopLoginModel.fromJson(
        value.data,
      );
      emit(ShopGetProfileSucesssState());
    }).catchError((error) {
      if (kDebugMode) {
        print(
          error.toString(),
        );
      }

      emit(ShopGetProfileErrorState());
    });
  }

  void updateData({
    required String name,
    required String phone,
    required String email,
  }) {
    emit(ShopGetProfileLoadingState());
    DioHelper.putData(
      url: UPDATE_PROFILE,
      token: token,
      data: {
        'name': name,
        'phone': phone,
        'email': email,
      },
    ).then((value) {
      userModel = ShopLoginModel.fromJson(
        value.data,
      );
      emit(ShopGetProfileSucesssState());
    }).catchError((error) {
      if (kDebugMode) {
        print(
          error.toString(),
        );
      }

      emit(ShopGetProfileErrorState());
    });
  }

  SearchModel? searchmodel;

  void searchObject({
    required String text,
  }) {
    emit(ShopSearchLoadingState());
    DioHelper.postData(
      url: SEARCH_PROFILE,
      token: token,
      data: {
        'text': text,
      },
    ).then((value) {
      searchmodel = SearchModel.fromJson(value.data);
      print(searchmodel!.data);
      emit(ShopSearchSucesssState());
    }).catchError((error) {
      if (kDebugMode) {
        print(
          error.toString(),
        );
      }
      emit(ShopSearchErrorState());
    });
  }
}
