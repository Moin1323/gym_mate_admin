import 'package:gym_mate_admin/data/network/network_api_services.dart';
import 'package:gym_mate_admin/res/app_url/app_url.dart';

class LoginRepository {
  final _apiServices = NetworkApiServices();

  Future<dynamic> loginApi(var data) async {
    //print(AppUrl.loginApi);
    dynamic response = await _apiServices.postApi(data, AppUrl.loginApi);
    return response;
  }
}
