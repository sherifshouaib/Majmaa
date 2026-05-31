import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:merhaba/core/utils/controllers/auth_controller.dart';

class ProfileTabProvider with ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _photoUrl = "";
  String get photoUrl => _photoUrl;

  String _email = "sherifshouaib22@gmail.com";
  String get email => _email;

  String _username = "sherif shouaib";
  String get username => _username;

  String _phone = "01011804716";
  String get phone => _phone;

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  Future<void> updateUserProfilePicture(String url) async {
    toggleLoading();
    try {
      var res = await AuthController.updateCurrentUserData({"picUrl": url});
      if (res["result"] == true) {
        _photoUrl = url;
        notifyListeners();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    toggleLoading();
  }

  Future<void> getUserData() async {
    try {
      var res = await AuthController.getCurrentUserData();
      if (res["result"] == true) {
        var userData = res["data"]["user_metadata"];

        _email = userData["email"].toString();
        _username = userData["fullName"];
        _phone = userData["phone"].toString();
        _photoUrl = userData["picUrl"] == null
            ? ""
            : userData["picUrl"].toString();

        // 🔥 preload image to cache
        if (_photoUrl.isNotEmpty) {
          await CachedNetworkImageProvider(
            _photoUrl,
          ).resolve(const ImageConfiguration());
        }

        notifyListeners();
        // debugPrint(res['data']);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> getData() async {
    _isLoading = true;
    notifyListeners();
    try {
      await getUserData();
    } catch (e) {
      debugPrint(e.toString());
    }
    _isLoading = false;
    notifyListeners();
  }
}
