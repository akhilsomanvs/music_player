import 'package:get/get.dart';

class PlayerController extends GetxController {
  RxBool isPlaying = false.obs;

  setIsPlaying(bool value) {
    isPlaying.value = value;
    update();
  }
}
