import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class AppState{
  BehaviorSubject _user = BehaviorSubject<User?>.seeded(null);
  bool get user => _user.value;
  setUser(User user){_user.add(user);}
  nullUser(){_user.add(null);}

  BehaviorSubject _fireAuthStatus = BehaviorSubject<FireAuthStatus>.seeded(FireAuthStatus.sucess);
  Stream get fireAuthStream => _fireAuthStatus.stream;
  HomeStatus get fireAuthStatus => _fireAuthStatus.value;
  setFireAuthStatus(FireAuthStatus status){_fireAuthStatus.add(status);}

  BehaviorSubject _homeStatus = BehaviorSubject<HomeStatus>.seeded(HomeStatus.loading);
  Stream get homeStateStream => _homeStatus.stream;
  HomeStatus get homeStatus => _homeStatus.value;
  setHomeStatus(HomeStatus status){_homeStatus.add(status);}
}

enum HomeStatus {loading, completed, error, retry}
enum FireAuthStatus {weakPassword, sucess, loading, accountExists, wrongPassword, noAccount}