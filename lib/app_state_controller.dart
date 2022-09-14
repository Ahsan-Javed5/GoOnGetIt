import 'dart:developer';

import 'package:get/get_state_manager/get_state_manager.dart';

class AppLifeCycleController extends SuperController{
  @override
  void onDetached() {
    log('App onDetached');
  }

  @override
  void onInactive() {
    log('App onInactive');
  }

  @override
  void onPaused() {
    log('App onPaused');
  }

  @override
  void onResumed() {
    log('App onResume');
  }

}