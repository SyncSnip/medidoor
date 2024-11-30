// lib/config/assets/app_images.dart
class AppImages {
  static String main = "assets/svg/";
  static String images = "assets/svg/";
  static String _products = "${images}products/";
  static String _categories = "${images}categories/";
  static String _icons = "${main}icons/";

  // Product Images
  static String coughCold = getName('cough-cold');
  static String diabetes = getName('diabetes');
  static String eyeCare = '${_products}eye-care.svg';
  static String firstAid = '${_products}first-aid.svg';
  static String healthcareDevices = '${_products}healthcare-devices.svg';
  static String immunity = '${_products}immunity.svg';
  static String motherBaby = '${_products}mother-baby.svg';
  static String painRelief = '${_products}pain-relief.svg';
  static String personalCare = '${_products}personal-care.svg';
  static String skinCare = '${_products}skin-care.svg';
  static String stomachDigestion = '${_products}stomach-digestion.svg';
  static String vitaminsSupplements = '${_products}vitamins-supplements.svg';

  // Category Images
  static String ayurveda = '${_categories}ayurveda.svg';
  static String babyMother = '${_categories}baby-mother.svg';
  static String covidEssentials = '${_categories}covid-essentials.svg';
  static String devices = '${_categories}devices.svg';
  static String diabetic = '${_categories}diabetic.svg';
  static String fitness = '${_categories}fitness.svg';
  static String lifestyle = '${_categories}lifestyle.svg';
  static String medicine = '${_categories}medicine.svg';
  static String surgicals = '${_categories}surgicals.svg';
  static String treatments = '${_categories}treatments.svg';

  // Icons
  static String backIcon = '${_icons}back.svg';
  static String cartIcon = '${_icons}cart.svg';
  static String categoryIcon = '${_icons}category.svg';
  static String doctorIcon = '${_icons}doctor.svg';
  static String homeIcon = '${_icons}home.svg';
  static String labIcon = '${_icons}lab.svg';
  static String locationIcon = '${_icons}location.svg';
  static String medicineIcon = '${_icons}medicine.svg';
  static String notificationIcon = '${_icons}notification.svg';
  static String prescriptionIcon = '${_icons}prescription.svg';
  static String profileIcon = '${_icons}profile.svg';
  static String searchIcon = '${_icons}search.svg';

  // App Logo & Others
  static String appLogo = '${images}app_logo.svg';
  static String loginBg = '${images}login_bg.svg';
  static String otpBg = '${images}otp_bg.svg';
  static String medicalBanner = '${images}medical_banner.svg';
  static String chyawanprash = '${images}chyawanprash.svg';

  // Helper method to get loading/placeholder image
  static String getLoadingImage(String imageName) =>
      '${images}default/$imageName';

  static String getName(String name) => '$main$name.svg';
}
