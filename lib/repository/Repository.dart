import 'package:dog_path_app/base/BaseResponseListener.dart';
import 'package:dog_path_app/data/network/api/ApiEnum.dart';
import 'package:dog_path_app/data/network/api/ApiUtils.dart';
import 'package:dog_path_app/data/network/rest/RestClient.dart';
import 'package:dog_path_app/mapper/HomeMapper.dart';
import 'package:dog_path_app/mapper/IMapper.dart';
import 'package:dog_path_app/model/view/IViewModel.dart';
import 'package:dog_path_app/res/Strings.dart';
import 'package:dog_path_app/util/Utils.dart';
import 'package:flutter/foundation.dart';

class Repository extends ApiService {
  Repository(String baseUrl) : super(baseUrl, kDebugMode);

  getData<T extends IViewModel>(BaseResponseListener<T> listener) {
    _hitApi<T>(
        type: ApiType.GET, endPoint: HOME_API_ENDPOINT, listener: listener, mapper: HomeMapper());
  }

  _hitApi<T extends IViewModel>({
    ApiType type,
    String endPoint,
    BaseResponseListener<T> listener,
    IMapper mapper,
    String query,
  }) async {
    listener.showProgress(true);
    isConnected().then(
      (b) {
        if (b != null && b) {
          apiRequest<T>(
            apiType: type,
            endPoint: endPoint,
            mapper: mapper,
            queryParams: query,
          ).listen((dataModel) {
            if (dataModel != null) {
              if (dataModel.status) {
                listener.showProgress(false);
                listener.updateIfLive(dataModel);
              } else {
                listener.showProgress(false);
                listener.onError(dataModel.error);
              }
            } else {
              listener.showProgress(false);
              listener.onError('null data model');
            }
          }, onError: (ee) {
            print(ee.toString());
            listener.showProgress(false);
            listener.onError(Strings.tryAgainText);
          });
        } else {
          listener.showProgress(false);
          listener.onError(Strings.noInternet);
        }
      },
      onError: (ee) {
        listener.showProgress(false);
        listener.onError(Strings.internetError);
      },
    );
  }
}
