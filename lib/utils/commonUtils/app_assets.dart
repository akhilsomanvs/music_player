class AppAssets {
  AppAssets._();

  static final String _imagePath = "assets/images/";

  static String getImagePath(String imageName) {
    return _imagePath + imageName;
  }
}
