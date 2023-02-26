// import 'dart:io';
//
// import 'package:e_auction/src/core/session/pref_manager.dart';
//
//
// class SessionManager {
//
//
//   final PrefManager _prefManager;
//
//   SessionManager(this._prefManager);
//
//
//   String? get userAuth =>
//       _prefManager.getStringValue(Constants.SESSION_KEY_USER_AUTH);
//
//   String? get firebaseID =>
//       _prefManager.getStringValue(Constants.SESSION_KEY_SECRET_CODE);
//
//   set setFirebaseID(String? value) => _prefManager.saveString(Constants.SESSION_KEY_COMUSRACC, value ?? "");
//
//
//   clearSession() async {
//
//   }
//
//   Future<bool> logout() async {
//     bool response = false;
//    await _prefManager.logOut().whenComplete(() {
//      response = true;
//    });
//    return response;
//   }
//
//
// }