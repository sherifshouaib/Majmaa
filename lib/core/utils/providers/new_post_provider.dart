import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_localization/flutter_localization.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:merhaba/core/locale/app_locale.dart';
import 'package:merhaba/core/utils/controllers/posts_controller.dart';

class NewPostProvider with ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  String _currentPostMode = "friends";
  String get currentPostMode => _currentPostMode;

  List<Map<String, dynamic>> _media = [];

  List<Map<String, dynamic>> get media => _media;

  int _currentPhotoIndex = 0;
  int get currentPhotoIndex => _currentPhotoIndex;

  Map<String, dynamic> _locationData = {};
  Map<String, dynamic> get locationData => _locationData;

  bool _isOccasionSelected = false;
  bool get isOccasionSelected => _isOccasionSelected;

  String _selectedOccasion = "graduation";
  String get selectedOccasion => _selectedOccasion;

  TextEditingController _textController = TextEditingController();
  TextEditingController get textController => _textController;

  Future<void> onAdd(BuildContext context) async {
    if (_textController.text == "") {
      return;
    }

    toggleLoading();
    try {
      var res = await PostsController.addPost({
        "content": jsonEncode({
          "text": _textController.text,
          "media": _media,
          "location": _locationData,
          "occasion": _selectedOccasion,
        }),
      });

      if (res["result"] == true) {
        clearNewPostData();
        Fluttertoast.showToast(msg: AppLocale.postedLabel.getString(context));
      } else {
        Fluttertoast.showToast(
          msg: AppLocale.somethingWentWrongLabel.getString(context),
        );
      }
      GoRouter.of(context).pop();
    } catch (e) {
      debugPrint(e.toString());
      Fluttertoast.showToast(
        msg: AppLocale.somethingWentWrongLabel.getString(context),
      );
    }
    toggleLoading();
  }

  void setIsOccasionSelected(bool value) {
    _isOccasionSelected = value;
    notifyListeners();
  }

  void setSelectedOccasion(String value) {
    toggleLoading();
    try {
      _selectedOccasion = value;
      _isOccasionSelected = true;
      notifyListeners();
    } catch (e) {}

    toggleLoading();
  }

  void setLocationData(Map<String, dynamic> value) {
    _locationData = value;

    notifyListeners();
  }

  void setCurrentPhotoIndex(int value) {
    _currentPhotoIndex = value;
    notifyListeners();
  }

  void addNewMedia(Map<String, dynamic> data) {
    _media.add(data);
    notifyListeners();
  }

  void addNewMedias(List<Map<String, dynamic>> data) {
    _media.addAll(data);
    notifyListeners();
  }

  void clearMedia() {
    _media.clear();
    notifyListeners();
  }

  void setCurrentPostMode(String value) {
    _currentPostMode = value;
    notifyListeners();
  }

  List<Map<String, dynamic>> getVisibilityOptions(BuildContext context) {
    final List<Map<String, dynamic>> list = [
      {
        'value': 'public',
        'label': AppLocale.publicLabel.getString(context),
        "icon": Icon(Icons.public),
      },
      {
        'value': 'friends',
        'label': AppLocale.friendsLabel.getString(context),
        "icon": Icon(Icons.group),
      },
      {
        'value': 'only_me',
        'label': AppLocale.onlyMeLabel.getString(context),
        "icon": Icon(Icons.remove_red_eye),
      },
    ];
    return list;
  }

  List<Map<String, dynamic>> getOccasionsOptions(BuildContext context) {
    final List<Map<String, dynamic>> list = [
      {
        'value': 'graduation',
        'label': AppLocale.graduationLabel.getString(context),
        "icon": Icon(Icons.account_balance),
      },
      {
        'value': 'engagement',
        'label': AppLocale.engagementLabel.getString(context),
        "icon": Icon(Icons.circle_outlined),
      },
      {
        'value': 'marriage',
        'label': AppLocale.marriageLabel.getString(context),
        "icon": Icon(Icons.female),
      },
    ];
    return list;
  }

  void toggleLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void clearNewPostData() {
    _textController.clear();

    _media.clear();

    _locationData = {};

    _isOccasionSelected = false;

    _selectedOccasion = "graduation";

    _currentPhotoIndex = 0;

    _currentPostMode = "friends";

    notifyListeners();
  }

  Future<void> removeMedia(int index) async {
    try {
      final mediaItem = _media[index];

      if (mediaItem["fileName"] != null) {
        await PostsController.deletePostMedia(mediaItem["fileName"]);
      }

      _media.removeAt(index);

      if (_currentPhotoIndex >= _media.length && _media.isNotEmpty) {
        _currentPhotoIndex = _media.length - 1;
      }

      if (_media.isEmpty) {
        _currentPhotoIndex = 0;
      }

      notifyListeners();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void removeLocation() {
    _locationData = {};
    notifyListeners();
  }

  void removeOccasion() {
    _isOccasionSelected = false;
    _selectedOccasion = "graduation";

    notifyListeners();
  }
}
