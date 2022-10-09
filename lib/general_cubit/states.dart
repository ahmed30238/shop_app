import 'package:flutter_application_1/models/change_favorites.dart';

abstract class GeneralShopStates {}

class ShopInitialState extends GeneralShopStates {}

class ChangeBottomNavBar extends GeneralShopStates {}

class ShopLoadingHomeState extends GeneralShopStates {}

class ShopSuccesHomeState extends GeneralShopStates {}


class ShopChangeThemeState extends GeneralShopStates {}

class ShopErrorHomeState extends GeneralShopStates {
  final String error;
  ShopErrorHomeState(this.error);
}
class ShopCategorySuccessState extends GeneralShopStates {}

class ShopCaegoryErrorState extends GeneralShopStates {}

class ShopChangeFavoritesSuccessState extends GeneralShopStates {
  final ChangeFavoritesModel model;

  ShopChangeFavoritesSuccessState(this.model);
}

class ShopChangeFavoritesState extends GeneralShopStates {}

class ShopChangeFavoritesErrorState extends GeneralShopStates {}


class ShopGetFavoritesSucesssState extends GeneralShopStates {}

class ShopGetFavoritesLoadingState extends GeneralShopStates {}

class ShopGetFavoritesErrorState extends GeneralShopStates {}

class ShopGetProfileSucesssState extends GeneralShopStates {}

class ShopGetProfileLoadingState extends GeneralShopStates {}

class ShopGetProfileErrorState extends GeneralShopStates {}

class ShopUpdateProfileSucesssState extends GeneralShopStates {}

class ShopUpdateProfileLoadingState extends GeneralShopStates {}

class ShopUpdateProfileErrorState extends GeneralShopStates {}

class ShopSearchSucesssState extends GeneralShopStates {}

class ShopSearchLoadingState extends GeneralShopStates {}

class ShopSearchErrorState extends GeneralShopStates {}
