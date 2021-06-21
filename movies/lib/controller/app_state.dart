import 'package:rxdart/rxdart.dart';

class AppState{
  BehaviorSubject _loggedIn = BehaviorSubject<bool>.seeded(false);
  Stream get loggedInStream => _loggedIn.stream;
  bool get isLoggedIn => _loggedIn.value;
  setLoggedIn(){_loggedIn.add(true);}
  clearLoggedIn(){_loggedIn.add(false);}

  BehaviorSubject _homeStatus = BehaviorSubject<HomeStatus>.seeded(HomeStatus.loading);
  Stream get homeStateStream => _homeStatus.stream;
  HomeStatus get homeStatus => _homeStatus.value;
  setHomeStatus(HomeStatus status){_homeStatus.add(status);}
}

enum HomeStatus {loading, completed, error, retry}