// lib/config/assets/app_images.dart
class AppImages {
  static String icons = "assets/icons/";
  static String images = "assets/images/";
  static String products = "${images}products/";
  static String categories = "${images}categories/";

  // Product Images
  static String banner1 = getImageName('banner-1-top');
  static String banner2 = getImageName('banner-2-mid');

  static String coughCold = getImageName('cough-cold');
  static String diabetes = getImageName('diabetes');
  static String eyeCare = '${images}eye-care.svg';
  static String firstAid = '${images}first-aid.svg';
  static String healthcareDevices = '${images}healthcare-devices.svg';
  static String immunity = '${images}immunity.svg';
  static String motherBaby = '${images}mother-baby.svg';
  static String painRelief = '${images}pain-relief.svg';
  static String personalCare = '${images}personal-care.svg';
  static String skinCare = '${images}skin-care.svg';
  static String stomachDigestion = '${images}stomach-digestion.svg';
  static String vitaminsSupplements = '${images}vitamins-supplements.svg';
  //options images
  static String orderMedicine = getImageName('medicine');
  static String requestMedicine = getImageName('request-medicine');
  static String consultDoctor = getImageName('consult-doctor');
  static String labTest = getImageName('lab-testing');

//app icons
  static String bellIcon = getImageName('notibell');
  static String location = getImageName('location');
  static String cart = getIconName('cart');
  static String home = getImageName('home');

  //products big
  static String authImg = getImageName('authimg.png');
  static String vicksVaporub = getImageName('vicks-vaporub');
  // App Logo & Others
  static String appLogo = '${images}app_logo.svg';
  static String loginBg = '${images}login_bg.svg';
  static String otpBg = '${images}otp_bg.svg';
  static String medicalBanner = '${images}medical_banner.svg';
  static String chyawanprash = '${images}chyawanprash.svg';

  // Helper method to get loading/placeholder image
  static String getLoadingImage(String imageName) =>
      '${images}default/$imageName';
  static String getIconName(String prodName) => '$icons$prodName.png';
  static String getImageName(String name) => '$images$name.png';
}
