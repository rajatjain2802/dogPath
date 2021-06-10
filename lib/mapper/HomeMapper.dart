import 'package:carousel_slider/carousel_controller.dart';
import 'package:dog_path_app/model/dto/HomeDataDto.dart';
import 'package:dog_path_app/model/view/HomeViewModel.dart';
import 'package:dog_path_app/res/Strings.dart';

import 'IMapper.dart';

class HomeMapper extends IMapper<String, HomeDataDto, HomeViewModel> {
  @override
  HomeViewModel toViewModel(String string, int statusCode) {
    HomeViewModel vm = HomeViewModel();
    if (statusCode == 200) {
      vm.status = true;
      HomeDataDto dto = toDTO(string);
      List<HomeDataViewModel> list = new List();
      if (dto.homeDataList != null && dto.homeDataList.length > 0) {
        for (HomeData model in dto.homeDataList) {
          HomeDataViewModel dataViewModel = new HomeDataViewModel();
          dataViewModel.name = model.name;
          dataViewModel.id = model.id;
          dataViewModel.controller = new CarouselController();
          dataViewModel.selectedIndex = 0;
          dataViewModel.subPathCount = model.subPaths != null ? model.subPaths.length : 0;
          dataViewModel.title = model.title;
          dataViewModel.avatar = model.avatar;
          if (model.subPaths != null && model.subPaths.length > 0) {
            dataViewModel.subPathList = new List();
            for (int i = 0; i < model.subPaths.length; i++) {
              SubPathVM subPathVM = new SubPathVM();
              SubPath subPath = model.subPaths.elementAt(i);
              subPathVM.title = subPath.title;
              subPathVM.image = subPath.image;
              if (i == 0)
                subPathVM.isSelected = true;
              else
                subPathVM.isSelected = false;
              dataViewModel.subPathList.add(subPathVM);
            }
          }
          list.add(dataViewModel);
        }
      }
      vm.homeDataList.addAll(list);
    } else {
      vm.status = false;
      vm.error = Strings.tryAgainText;
    }
    return vm;
  }

  @override
  HomeDataDto toDTO(String string) {
    return HomeDataDto.fromJson(string);
  }
}
