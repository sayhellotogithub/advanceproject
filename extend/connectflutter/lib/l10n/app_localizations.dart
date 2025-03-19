import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('ja')
  ];

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get helloWorld;

  /// No description provided for @filling_material.
  ///
  /// In en, this message translates to:
  /// **'Material filling in progress'**
  String get filling_material;

  /// No description provided for @home_title.
  ///
  /// In en, this message translates to:
  /// **'Fast account opening, simple operation!'**
  String get home_title;

  /// No description provided for @home_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Ensure the security of your account information'**
  String get home_subtitle;

  /// No description provided for @open_account_title.
  ///
  /// In en, this message translates to:
  /// **'Overseas account opening'**
  String get open_account_title;

  /// No description provided for @open_account_tip.
  ///
  /// In en, this message translates to:
  /// **'After completing the above steps, submit the application for review. Once the review is passed, the account information will be sent to your email (the review time is expected to be 2-3 business days)'**
  String get open_account_tip;

  /// No description provided for @register_account.
  ///
  /// In en, this message translates to:
  /// **'Register Account'**
  String get register_account;

  /// No description provided for @fill_material.
  ///
  /// In en, this message translates to:
  /// **'Fill Material'**
  String get fill_material;

  /// No description provided for @electronic_signature.
  ///
  /// In en, this message translates to:
  /// **'Electronic Signature'**
  String get electronic_signature;

  /// No description provided for @advance_auth.
  ///
  /// In en, this message translates to:
  /// **'Advanced Authentication'**
  String get advance_auth;

  /// No description provided for @set.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get set;

  /// No description provided for @help_center.
  ///
  /// In en, this message translates to:
  /// **'Help Center'**
  String get help_center;

  /// No description provided for @about_us.
  ///
  /// In en, this message translates to:
  /// **'About Us'**
  String get about_us;

  /// No description provided for @security_set.
  ///
  /// In en, this message translates to:
  /// **'Security Settings'**
  String get security_set;

  /// No description provided for @login_password.
  ///
  /// In en, this message translates to:
  /// **'Login Password'**
  String get login_password;

  /// No description provided for @fund_password.
  ///
  /// In en, this message translates to:
  /// **'Fund Password'**
  String get fund_password;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @google_authenticator.
  ///
  /// In en, this message translates to:
  /// **'Google Authenticator'**
  String get google_authenticator;

  /// No description provided for @general_set.
  ///
  /// In en, this message translates to:
  /// **'General Settings'**
  String get general_set;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @simple_china.
  ///
  /// In en, this message translates to:
  /// **'Simplified Chinese'**
  String get simple_china;

  /// No description provided for @unbound.
  ///
  /// In en, this message translates to:
  /// **'Unbound'**
  String get unbound;

  /// No description provided for @opened.
  ///
  /// In en, this message translates to:
  /// **'Opened'**
  String get opened;

  /// No description provided for @modify.
  ///
  /// In en, this message translates to:
  /// **'Modify'**
  String get modify;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @english.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get english;

  /// No description provided for @please_fill_email_or_phone.
  ///
  /// In en, this message translates to:
  /// **'Please enter email or phone number'**
  String get please_fill_email_or_phone;

  /// No description provided for @please_choose_phone_area.
  ///
  /// In en, this message translates to:
  /// **'Please select phone area code'**
  String get please_choose_phone_area;

  /// No description provided for @please_fill_keyword.
  ///
  /// In en, this message translates to:
  /// **'Please enter keyword'**
  String get please_fill_keyword;

  /// No description provided for @common_area_code.
  ///
  /// In en, this message translates to:
  /// **'Common Area Codes'**
  String get common_area_code;

  /// No description provided for @register_or_login.
  ///
  /// In en, this message translates to:
  /// **'Register/Login'**
  String get register_or_login;

  /// No description provided for @auth_code_login.
  ///
  /// In en, this message translates to:
  /// **'Login with verification code'**
  String get auth_code_login;

  /// No description provided for @fill_auth_code.
  ///
  /// In en, this message translates to:
  /// **'Enter verification code'**
  String get fill_auth_code;

  /// No description provided for @resend.
  ///
  /// In en, this message translates to:
  /// **'Resend'**
  String get resend;

  /// No description provided for @password_login.
  ///
  /// In en, this message translates to:
  /// **'Password Login'**
  String get password_login;

  /// No description provided for @please_fill_password.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get please_fill_password;

  /// No description provided for @forget_password.
  ///
  /// In en, this message translates to:
  /// **'Forgot password'**
  String get forget_password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @find_password.
  ///
  /// In en, this message translates to:
  /// **'Retrieve password'**
  String get find_password;

  /// No description provided for @get_auth_code.
  ///
  /// In en, this message translates to:
  /// **'Get verification code'**
  String get get_auth_code;

  /// No description provided for @reset_password.
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get reset_password;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @password_rule_hint.
  ///
  /// In en, this message translates to:
  /// **'Please enter 6-20 characters, including letters, numbers, and two types of symbols'**
  String get password_rule_hint;

  /// No description provided for @please_fill_password_again.
  ///
  /// In en, this message translates to:
  /// **'Please enter the password again'**
  String get please_fill_password_again;

  /// No description provided for @warm_tip.
  ///
  /// In en, this message translates to:
  /// **'Warm tip'**
  String get warm_tip;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @fill_material_exit_tip.
  ///
  /// In en, this message translates to:
  /// **'If you exit now, the information you have filled will be saved automatically. Are you sure you want to exit?'**
  String get fill_material_exit_tip;

  /// No description provided for @click_upload_bank_card.
  ///
  /// In en, this message translates to:
  /// **'Click to upload bank card account number'**
  String get click_upload_bank_card;

  /// No description provided for @upload_bank_card_warm_tip.
  ///
  /// In en, this message translates to:
  /// **'Warm tip:\n1. Please provide a bank card that you frequently use under your name (preferably from major national banks, avoid using local banks)\n2. Ensure that the bank card is within the valid period of your ID\n3. Please upload the original proportion of the bank card number, do not block or modify, and ensure the card information is clearly displayed'**
  String get upload_bank_card_warm_tip;

  /// No description provided for @bank_card_auth.
  ///
  /// In en, this message translates to:
  /// **'Bank Card Authentication'**
  String get bank_card_auth;

  /// No description provided for @take_photo.
  ///
  /// In en, this message translates to:
  /// **'Take a photo'**
  String get take_photo;

  /// No description provided for @picker_from_gallery.
  ///
  /// In en, this message translates to:
  /// **'Pick from gallery'**
  String get picker_from_gallery;

  /// No description provided for @next_step_person_info_auth.
  ///
  /// In en, this message translates to:
  /// **'Next step, personal information authentication'**
  String get next_step_person_info_auth;

  /// No description provided for @click_signature.
  ///
  /// In en, this message translates to:
  /// **'Click area to sign'**
  String get click_signature;

  /// No description provided for @electronic_signature_warm_tip.
  ///
  /// In en, this message translates to:
  /// **'Warm tip:\n1. Please ensure that the signature is from Zhang San, and use standard calligraphy with no connecting strokes between characters\n2. Electronic signature has the same legal effect as handwritten signatures or stamps. Please ensure the electronic signature matches the name on your ID or passport'**
  String get electronic_signature_warm_tip;

  /// No description provided for @next_step_face_recognize.
  ///
  /// In en, this message translates to:
  /// **'Next step, face recognition'**
  String get next_step_face_recognize;

  /// No description provided for @re_enter.
  ///
  /// In en, this message translates to:
  /// **'Re-enter'**
  String get re_enter;

  /// No description provided for @please_sign_in_area.
  ///
  /// In en, this message translates to:
  /// **'Please sign within the area'**
  String get please_sign_in_area;

  /// No description provided for @open_account_introduction.
  ///
  /// In en, this message translates to:
  /// **'Account Opening Introduction'**
  String get open_account_introduction;

  /// No description provided for @account_introduction.
  ///
  /// In en, this message translates to:
  /// **'Account Introduction'**
  String get account_introduction;

  /// No description provided for @account_introduction_desc.
  ///
  /// In en, this message translates to:
  /// **'An overseas account designed for the general public, helping you achieve various life and investment goals such as overseas investment, payments, travel, real estate, and children’s education, while managing your diverse overseas wealth through multiple bank channels anytime, anywhere.'**
  String get account_introduction_desc;

  /// No description provided for @account_rights.
  ///
  /// In en, this message translates to:
  /// **'Account Rights'**
  String get account_rights;

  /// No description provided for @account_rights_desc.
  ///
  /// In en, this message translates to:
  /// **'Transfer limit \$100,000/day, \$200,000/30 days;\nSupports global transfers;\nFast account opening, review time 2-3 business days;'**
  String get account_rights_desc;

  /// No description provided for @charging_standard.
  ///
  /// In en, this message translates to:
  /// **'Charging Standard'**
  String get charging_standard;

  /// No description provided for @charging_standard_desc.
  ///
  /// In en, this message translates to:
  /// **'Account opening fee \$50, monthly management fee \$8/month; (Note: If your account\'s average daily balance exceeds \$500 for the year, the monthly management fee charged in the previous year will be refunded after one year.)'**
  String get charging_standard_desc;

  /// No description provided for @application_materials.
  ///
  /// In en, this message translates to:
  /// **'Application Materials'**
  String get application_materials;

  /// No description provided for @application_materials_desc.
  ///
  /// In en, this message translates to:
  /// **'Mobile number & email, valid ID, valid bank card, personal passport (for non-mainland residents);\nElectronic signature, online face-to-face real person authentication;'**
  String get application_materials_desc;

  /// No description provided for @i_knows.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get i_knows;

  /// No description provided for @authentication_phone.
  ///
  /// In en, this message translates to:
  /// **'Phone number authentication'**
  String get authentication_phone;

  /// No description provided for @authentication_phone_warm_tip.
  ///
  /// In en, this message translates to:
  /// **'Warm tip:\n1. Please fill in your commonly used phone number\n2. Ensure that the phone number is in normal use'**
  String get authentication_phone_warm_tip;

  /// No description provided for @next_step_authentication_email.
  ///
  /// In en, this message translates to:
  /// **'Next step, email authentication'**
  String get next_step_authentication_email;

  /// No description provided for @sms_code.
  ///
  /// In en, this message translates to:
  /// **'SMS verification code'**
  String get sms_code;

  /// No description provided for @please_fill_phone.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number'**
  String get please_fill_phone;

  /// No description provided for @authen_email.
  ///
  /// In en, this message translates to:
  /// **'Email authentication'**
  String get authen_email;

  /// No description provided for @bottom_btn_home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get bottom_btn_home;

  /// No description provided for @bottom_btn_widgets.
  ///
  /// In en, this message translates to:
  /// **'Widgets'**
  String get bottom_btn_widgets;

  /// No description provided for @bottom_btn_my_page.
  ///
  /// In en, this message translates to:
  /// **'MyPage'**
  String get bottom_btn_my_page;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'ja'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'ja': return AppLocalizationsJa();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
