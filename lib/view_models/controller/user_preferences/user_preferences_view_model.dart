import 'package:gym_mate_admin/models/login/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  Future<bool> saveUser(UserModel responseModel) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', responseModel.token ?? '');
    sp.setString('uid', responseModel.uid ?? ''); // Save UID if needed
    return true;
  }

  Future<UserModel> getUser() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? token = sp.getString('token');
    String? uid = sp.getString('uid'); // Retrieve UID if needed
    return UserModel(
      token: token,
      uid: uid,
    );
  }
}
