import 'package:carousel_slider/carousel_slider.dart';
import 'package:dog_path_app/base/BaseResponseListener.dart';
import 'package:dog_path_app/base/BaseState.dart';
import 'package:dog_path_app/data/network/api/BaseApi.dart';
import 'package:dog_path_app/model/view/HomeViewModel.dart';
import 'package:dog_path_app/repository/Repository.dart';
import 'package:dog_path_app/res/AppColor.dart';
import 'package:dog_path_app/res/Dimensions.dart';
import 'package:dog_path_app/res/Strings.dart';
import 'package:dog_path_app/widget/ImageViewAssets.dart';
import 'package:dog_path_app/widget/NetworkImageView.dart';
import 'package:dog_path_app/widget/TextView.dart';
import 'package:dog_path_app/widget/Toolbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/*
* Created by Rajat Jain 09/06/2021
 */
class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends BaseState<HomeScreen> {
  HomeViewModel vm = new HomeViewModel();

  @override
  Widget getBuildWidget(BuildContext context) {
    return ChangeNotifierProvider<HomeViewModel>.value(
      value: vm, // listen new Value
      child: Container(
          color: AppColor.primary,
          child: Consumer<HomeViewModel>(
            // consumer
            builder: (context, model, child) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  HomeDataViewModel dataViewModel = model.homeDataList.elementAt(index);
                  print(dataViewModel.subPathCount);
                  return dataViewModel.subPathCount > 0
                      ? Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          textView(
                                            title: dataViewModel.title,
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: Dimensions.txtSize18px,
                                            fontColor: AppColor.white,
                                          ),
                                          textView(
                                              title: dataViewModel.subPathCount.toString() +
                                                  Strings.subPath,
                                              margin: EdgeInsets.only(top: 8)),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(right: 10),
                                    color: AppColor.primaryDark,
                                    child: textView(
                                        title: Strings.openPath,
                                        fontColor: AppColor.blue,
                                        padding: EdgeInsets.all(5),
                                        textAlign: TextAlign.center),
                                  )
                                ],
                              ),
                            ),
                            CarouselSlider(
                              items: List.generate(dataViewModel.subPathCount, (index) {
                                SubPathVM subPathVM = dataViewModel.subPathList.elementAt(index);
                                try {
                                  return networkImageView(
                                      placeHolder: 'asset/images/no_image_available_icon.png',
                                      height: 200,
                                      imagePath: subPathVM.image,
                                      width: MediaQuery.of(context).size.width,
                                      boxFit: BoxFit.fitWidth,
                                      margin: EdgeInsets.only(top: 10));
                                } catch (e) {
                                  return imageViewAsset(
                                      imagePath: 'asset/images/no_image_available_icon.png');
                                }
                              }),
                              options: CarouselOptions(
                                  enlargeCenterPage: true,
                                  height: 200,
                                  reverse: false,
                                  viewportFraction: 1,
                                  onPageChanged: (page, _) {
                                    dataViewModel.subPathList
                                        .elementAt(dataViewModel.selectedIndex)
                                        .isSelected = false;
                                    dataViewModel.selectedIndex = page;
                                    dataViewModel.subPathList
                                        .elementAt(dataViewModel.selectedIndex)
                                        .isSelected = true;
                                    setState(() {});
                                  }),
                              carouselController: dataViewModel.controller,
                            ),
                            Container(
                              height: 50,
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          ...Iterable<int>.generate(dataViewModel.subPathCount).map(
                                            (int pageIndex) => InkWell(
                                              onTap: () {
                                                dataViewModel.subPathList
                                                    .elementAt(dataViewModel.selectedIndex)
                                                    .isSelected = false;
                                                dataViewModel.selectedIndex = pageIndex;
                                                dataViewModel.subPathList
                                                    .elementAt(dataViewModel.selectedIndex)
                                                    .isSelected = true;
                                                dataViewModel.controller.animateToPage(pageIndex,
                                                    duration: Duration(milliseconds: 500),
                                                    curve: Curves.easeInOut);
                                                print(dataViewModel.controller.ready);
                                                setState(() {});
                                              },
                                              child: textView(
                                                  fontSize: Dimensions.txtSize16px,
                                                  fontColor: dataViewModel.subPathList
                                                          .elementAt(pageIndex)
                                                          .isSelected
                                                      ? AppColor.blue
                                                      : AppColor.txtColorGray,
                                                  margin: EdgeInsets.only(left: 5, right: 5),
                                                  title: dataViewModel.subPathList
                                                          .elementAt(pageIndex)
                                                          .title +
                                                      "${pageIndex != dataViewModel.subPathCount - 1 ? "->" : ""}"),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      : Container();
                },
                itemCount: model.homeDataList.length,
              );
            },
          )),
    );
  }

  @override
  AppBar getToolBar(BuildContext context) {
    return toolBar(toolBarTitle: Strings.dogPathTxt, onClick: null, elevation: 0);
  }

  @override
  void onScreenReady(BuildContext context) {
    Repository(BaseApis.dogPathApi).getData<HomeViewModel>(BaseResponseListener(
        onSuccess: (data) {
          // to add data into provider
          context.read<HomeViewModel>().addHomeData(data.homeDataList);
          vm = Provider.of<HomeViewModel>(context, listen: false);
          setState(() {});
        },
        onError: (err) {
          showSnackBar(err);
        },
        isLive: mounted,
        showProgress: (b) {
          showProgress(b);
        }));
  }
}
