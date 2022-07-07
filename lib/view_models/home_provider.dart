import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:studentprojectmanager/util/api.dart';
import 'package:studentprojectmanager/util/enum/api_request_status.dart';
import 'package:studentprojectmanager/util/functions.dart';

class HomeProvider with ChangeNotifier {
  Logger logger = Logger();
  Api api = Api();
  APIRequestStatus apiRequestStatus = APIRequestStatus.loading;
  var projects;
  var categories;

  getFeeds() async {
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      var mProjects = await api.getProjects();
      setProjects(mProjects);

      var mCategories = await api.getCategories();
      setCategories(mCategories);

      setApiRequestStatus(APIRequestStatus.loaded);
    } catch (e) {
      checkError(e);
    }
  }

  void checkError(e) {
    if (Functions.checkConnectionError(e)) {
      setApiRequestStatus(APIRequestStatus.connectionError);
    } else {
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    apiRequestStatus = value;
    notifyListeners();
  }

  void setProjects(value) {
    projects = value;
    notifyListeners();
  }

  getTop() {
    return projects;
  }

  void setCategories(value) {
    categories = value;
    notifyListeners();
  }
}
