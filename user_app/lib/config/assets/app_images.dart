// lib/config/assets/app_images.dart
class AppImages {
  static const String _main = "assets/";
  static const String _images = "${_main}images/";
  static const String _products = "${_images}products/";
  static const String _categories = "${_images}categories/";
  static const String _icons = "${_main}icons/";

  // Product Images
  static const String coughCold = '${_products}cough-cold.svg';
  static const String diabetes = '${_products}diabetes.svg';
  static const String eyeCare = '${_products}eye-care.svg';
  static const String firstAid = '${_products}first-aid.svg';
  static const String healthcareDevices = '${_products}healthcare-devices.svg';
  static const String immunity = '${_products}immunity.svg';
  static const String motherBaby = '${_products}mother-baby.svg';
  static const String painRelief = '${_products}pain-relief.svg';
  static const String personalCare = '${_products}personal-care.svg';
  static const String skinCare = '${_products}skin-care.svg';
  static const String stomachDigestion = '${_products}stomach-digestion.svg';
  static const String vitaminsSupplements = '${_products}vitamins-supplements.svg';

  // Category Images
  static const String ayurveda = '${_categories}ayurveda.svg';
  static const String babyMother = '${_categories}baby-mother.svg';
  static const String covidEssentials = '${_categories}covid-essentials.svg';
  static const String devices = '${_categories}devices.svg';
  static const String diabetic = '${_categories}diabetic.svg';
  static const String fitness = '${_categories}fitness.svg';
  static const String lifestyle = '${_categories}lifestyle.svg';
  static const String medicine = '${_categories}medicine.svg';
  static const String surgicals = '${_categories}surgicals.svg';
  static const String treatments = '${_categories}treatments.svg';

  // Icons
  static const String backIcon = '${_icons}back.svg';
  static const String cartIcon = '${_icons}cart.svg';
  static const String categoryIcon = '${_icons}category.svg';
  static const String doctorIcon = '${_icons}doctor.svg';
  static const String homeIcon = '${_icons}home.svg';
  static const String labIcon = '${_icons}lab.svg';
  static const String locationIcon = '${_icons}location.svg';
  static const String medicineIcon = '${_icons}medicine.svg';
  static const String notificationIcon = '${_icons}notification.svg';
  static const String prescriptionIcon = '${_icons}prescription.svg';
  static const String profileIcon = '${_icons}profile.svg';
  static const String searchIcon = '${_icons}search.svg';

  // App Logo & Others
  static const String appLogo = '${_images}app_logo.svg';
  static const String loginBg = '${_images}login_bg.svg';
  static const String otpBg = '${_images}otp_bg.svg';
  static const String medicalBanner = '${_images}medical_banner.svg';
  static const String chyawanprash = '${_images}chyawanprash.svg';

  // Helper method to get loading/placeholder image
  static String getLoadingImage(String imageName) => '${_images}default/$imageName';
}