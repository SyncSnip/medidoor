// lib/config/assets/app_images.dart
class AppImages {
  static String iconss = "assets/icons/";
  static String images = "assets/images/";
  static String products = "${images}products/";
  static String categories = "${images}categories/";

  // Product Images
  static String banner1 = getName('banner-1-top');
  static String banner2 = getName('banner-2-mid');

  static String coughCold = getName('cough-cold');
  static String diabetes = getName('diabetes');
  static String eyeCare = '${products}eye-care.svg';
  static String firstAid = '${products}first-aid.svg';
  static String healthcareDevices = '${products}healthcare-devices.svg';
  static String immunity = '${products}immunity.svg';
  static String motherBaby = '${products}mother-baby.svg';
  static String painRelief = '${products}pain-relief.svg';
  static String personalCare = '${products}personal-care.svg';
  static String skinCare = '${products}skin-care.svg';
  static String stomachDigestion = '${products}stomach-digestion.svg';
  static String vitaminsSupplements = '${products}vitamins-supplements.svg';
  //options images
  static String orderMedicine = getName('medicine');
  static String requestMedicine = getName('request-medicine');
  static String consultDoctor = getName('consult-doctor');
  static String labTest = getName('lab-testing');

//app icons
  static String bellIcon = getName('notibell');
  static String location = getName('location');
  static String cart = getName('cart');
  static String home = getName('home');

  //products big
  static String authImg = getName('authimg');
  static String vicksVaporub = getProd('vicks-vaporub');
  // App Logo & Others
  static String appLogo = '${images}app_logo.svg';
  static String loginBg = '${images}login_bg.svg';
  static String otpBg = '${images}otp_bg.svg';
  static String medicalBanner = '${images}medical_banner.svg';
  static String chyawanprash = '${images}chyawanprash.svg';

  // Helper method to get loading/placeholder image
  static String getLoadingImage(String imageName) =>
      '${images}default/$imageName';
  static String getProd(String prodName) => '$iconss$prodName.png';
  static String getName(String name) => '$images$name.png';
}
