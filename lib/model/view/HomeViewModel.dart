import 'package:carousel_slider/carousel_controller.dart';
import 'package:dog_path_app/model/view/IViewModel.dart';
import 'package:flutter/foundation.dart';

class HomeViewModel extends IViewModel with ChangeNotifier {
  List<HomeDataViewModel> _homeDataList = new List();

  List<HomeDataViewModel> get homeDataList => _homeDataList;

  void addHomeData(List<HomeDataViewModel> list) {
    _homeDataList.clear();

    _homeDataList.addAll(list);

    notifyListeners();
  }

  void clearHomeData() {
    _homeDataList.clear();

    notifyListeners();
  }
}

class HomeDataViewModel {
  String id;
  String name;
  String title;
  List<SubPathVM> subPathList = new List();
  int subPathCount;
  CarouselController controller;
  int selectedIndex;
  String avatar;

  HomeDataViewModel(
      {@required this.name,
      @required this.title,
      @required this.controller,
      @required this.subPathList,
      @required this.avatar});
}

class SubPathVM {
  SubPathVM({
    this.isSelected = false,
    this.title,
    this.image,
  });

  bool isSelected;
  String title;
  String image;
}
