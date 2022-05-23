import 'package:api/api.dart';
import 'package:etra_flutter/app_config.dart';
import 'package:etra_flutter/database/database.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/dashboard/prompt_list_contacts.dart';

class Session extends ChangeNotifier {
  AppUserProfilePojo? _appUserProfilePojo;
  Workspace? _currentWorkspace;
  AppUserAvailableBatchesPojo? _batches;
  SharedPreferences? sharedPreferences;
  Database? database;

  static const CURRENT_WORKSPACE_ID = 'CURRENT_WORKSPACE_ID';

  AppUserProfilePojo? get appUser => _appUserProfilePojo;

  set appUser(AppUserProfilePojo? value) {
    _appUserProfilePojo = value;
    if (value?.workspaces?.isNotEmpty ?? false) {
      _currentWorkspace = value?.workspaces?.firstWhere(
          (p0) =>
              p0.organizationId == sharedPreferences?.get(CURRENT_WORKSPACE_ID),
          orElse: () => value.workspaces![0]);
    } else {
      _currentWorkspace = null;
    }
    headerInterceptor.additionalHeaders['X-ACCOUNT-CODE'] =
        _currentWorkspace?.accountCode;
    notifyListeners();
  }

  Workspace? get currentWorkspace => _currentWorkspace;

  set currentWorkspace(Workspace? value) {
    _currentWorkspace = value;
    notifyListeners();
  }

  AppUserAvailableBatchesPojo? get batches => _batches;

  set batches(AppUserAvailableBatchesPojo? value) {
    _batches = value;
    notifyListeners();
  }

  void logout() {
    _appUserProfilePojo = null;
    _currentWorkspace = null;
    _batches = null;
    headerInterceptor.additionalHeaders.remove('X-ACCOUNT-CODE');
    notifyListeners();
  }
}

// class UserNotifier extends ChangeNotifier {// class added by me for real time showing of what the user entered
// List<UserInput> UserList = [];
//
//   addUser(UserInput userInput){
//     UserList.add(userInput);
//     notifyListeners();
//   }
// }
