// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Languages`
  String get language {
    return Intl.message(
      'Languages',
      name: 'language',
      desc: '',
      args: [],
    );
  }

  /// `PERFECT BODY`
  String get pageView_first_text1 {
    return Intl.message(
      'PERFECT BODY',
      name: 'pageView_first_text1',
      desc: '',
      args: [],
    );
  }

  /// `DOING CROSSFIT`
  String get pageView_first_text2 {
    return Intl.message(
      'DOING CROSSFIT',
      name: 'pageView_first_text2',
      desc: '',
      args: [],
    );
  }

  /// `EXERCISES`
  String get pageView_first_text3 {
    return Intl.message(
      'EXERCISES',
      name: 'pageView_first_text3',
      desc: '',
      args: [],
    );
  }

  /// `Next`
  String get next {
    return Intl.message(
      'Next',
      name: 'next',
      desc: '',
      args: [],
    );
  }

  /// `Skip`
  String get skip {
    return Intl.message(
      'Skip',
      name: 'skip',
      desc: '',
      args: [],
    );
  }

  /// `SHOT STRONG`
  String get pageView_second_text1 {
    return Intl.message(
      'SHOT STRONG',
      name: 'pageView_second_text1',
      desc: '',
      args: [],
    );
  }

  /// `TIMELESS`
  String get pageView_second_text2 {
    return Intl.message(
      'TIMELESS',
      name: 'pageView_second_text2',
      desc: '',
      args: [],
    );
  }

  /// `WOMAN TRAINING`
  String get pageView_second_text3 {
    return Intl.message(
      'WOMAN TRAINING',
      name: 'pageView_second_text3',
      desc: '',
      args: [],
    );
  }

  /// `HEALTHY MUSCULAR`
  String get pageView_third_text1 {
    return Intl.message(
      'HEALTHY MUSCULAR',
      name: 'pageView_third_text1',
      desc: '',
      args: [],
    );
  }

  /// `SPORTSWOMAN`
  String get pageView_third_text2 {
    return Intl.message(
      'SPORTSWOMAN',
      name: 'pageView_third_text2',
      desc: '',
      args: [],
    );
  }

  /// `STANDING`
  String get pageView_third_text3 {
    return Intl.message(
      'STANDING',
      name: 'pageView_third_text3',
      desc: '',
      args: [],
    );
  }

  /// `Welcome to Pro Fitness!`
  String get loginPage_welcome {
    return Intl.message(
      'Welcome to Pro Fitness!',
      name: 'loginPage_welcome',
      desc: '',
      args: [],
    );
  }

  /// `Hello there, sign in to continue!`
  String get hello_sign {
    return Intl.message(
      'Hello there, sign in to continue!',
      name: 'hello_sign',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get email_address {
    return Intl.message(
      'Email address',
      name: 'email_address',
      desc: '',
      args: [],
    );
  }

  /// `johnwelles@gmail.com`
  String get hint_title {
    return Intl.message(
      'johnwelles@gmail.com',
      name: 'hint_title',
      desc: '',
      args: [],
    );
  }

  /// `Email Is Required !!`
  String get email_Required {
    return Intl.message(
      'Email Is Required !!',
      name: 'email_Required',
      desc: '',
      args: [],
    );
  }

  /// `Email Is Invalid !!`
  String get email_Invalid {
    return Intl.message(
      'Email Is Invalid !!',
      name: 'email_Invalid',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get email_password {
    return Intl.message(
      'Password',
      name: 'email_password',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password?`
  String get forgot_password {
    return Intl.message(
      'Forgot Password?',
      name: 'forgot_password',
      desc: '',
      args: [],
    );
  }

  /// `Password Is Required !!`
  String get password_Required {
    return Intl.message(
      'Password Is Required !!',
      name: 'password_Required',
      desc: '',
      args: [],
    );
  }

  /// `Password Should Be At Least 6 Digits !!`
  String get password_six_Digits {
    return Intl.message(
      'Password Should Be At Least 6 Digits !!',
      name: 'password_six_Digits',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get login {
    return Intl.message(
      'Login',
      name: 'login',
      desc: '',
      args: [],
    );
  }

  /// `Or Login with`
  String get login_with {
    return Intl.message(
      'Or Login with',
      name: 'login_with',
      desc: '',
      args: [],
    );
  }

  /// `Sign in with Google`
  String get connect_with_google {
    return Intl.message(
      'Sign in with Google',
      name: 'connect_with_google',
      desc: '',
      args: [],
    );
  }

  /// `Sign in With Facebook`
  String get connect_with_facebook {
    return Intl.message(
      'Sign in With Facebook',
      name: 'connect_with_facebook',
      desc: '',
      args: [],
    );
  }

  /// `Sign in With Apple`
  String get connect_with_apple {
    return Intl.message(
      'Sign in With Apple',
      name: 'connect_with_apple',
      desc: '',
      args: [],
    );
  }

  /// `Don’t have an account?`
  String get do_not_have_an_account {
    return Intl.message(
      'Don’t have an account?',
      name: 'do_not_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Register!`
  String get register {
    return Intl.message(
      'Register!',
      name: 'register',
      desc: '',
      args: [],
    );
  }

  /// `Create Accounts`
  String get create_account {
    return Intl.message(
      'Create Accounts',
      name: 'create_account',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your credentials to proceed`
  String get please_enter {
    return Intl.message(
      'Please enter your credentials to proceed',
      name: 'please_enter',
      desc: '',
      args: [],
    );
  }

  /// `Full Name`
  String get full_name {
    return Intl.message(
      'Full Name',
      name: 'full_name',
      desc: '',
      args: [],
    );
  }

  /// `John welles`
  String get name_hint_title_text {
    return Intl.message(
      'John welles',
      name: 'name_hint_title_text',
      desc: '',
      args: [],
    );
  }

  /// `Phone`
  String get phone {
    return Intl.message(
      'Phone',
      name: 'phone',
      desc: '',
      args: [],
    );
  }

  /// `9876543210`
  String get phone_hint_title_text {
    return Intl.message(
      '9876543210',
      name: 'phone_hint_title_text',
      desc: '',
      args: [],
    );
  }

  /// `Phone Number Is Required !!`
  String get phone_number_Required {
    return Intl.message(
      'Phone Number Is Required !!',
      name: 'phone_number_Required',
      desc: '',
      args: [],
    );
  }

  /// `Number Is Invalid !!`
  String get number_is_Invalid {
    return Intl.message(
      'Number Is Invalid !!',
      name: 'number_is_Invalid',
      desc: '',
      args: [],
    );
  }

  /// `Email address`
  String get email {
    return Intl.message(
      'Email address',
      name: 'email',
      desc: '',
      args: [],
    );
  }

  /// `johnwelles@gmail.com`
  String get email_hint_title {
    return Intl.message(
      'johnwelles@gmail.com',
      name: 'email_hint_title',
      desc: '',
      args: [],
    );
  }

  /// `Create Account`
  String get createAccount {
    return Intl.message(
      'Create Account',
      name: 'createAccount',
      desc: '',
      args: [],
    );
  }

  /// `Already have an account?`
  String get already_have_an_account {
    return Intl.message(
      'Already have an account?',
      name: 'already_have_an_account',
      desc: '',
      args: [],
    );
  }

  /// `Forgot Password`
  String get forgot_password_screen {
    return Intl.message(
      'Forgot Password',
      name: 'forgot_password_screen',
      desc: '',
      args: [],
    );
  }

  /// `Please enter your email below to receive your password reset code.`
  String get forgot_password_text_line1 {
    return Intl.message(
      'Please enter your email below to receive your password reset code.',
      name: 'forgot_password_text_line1',
      desc: '',
      args: [],
    );
  }

  /// `johnwelles@gmail.com`
  String get forgot_password_hint_text {
    return Intl.message(
      'johnwelles@gmail.com',
      name: 'forgot_password_hint_text',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get reset_password {
    return Intl.message(
      'Reset Password',
      name: 'reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Verify Account`
  String get verify_account {
    return Intl.message(
      'Verify Account',
      name: 'verify_account',
      desc: '',
      args: [],
    );
  }

  /// `Verify your account by entering verification`
  String get verify_your_account {
    return Intl.message(
      'Verify your account by entering verification',
      name: 'verify_your_account',
      desc: '',
      args: [],
    );
  }

  /// `johnwelles@gmail.com`
  String get verify_account_email {
    return Intl.message(
      'johnwelles@gmail.com',
      name: 'verify_account_email',
      desc: '',
      args: [],
    );
  }

  /// `Reset Password`
  String get verify_account_reset_password {
    return Intl.message(
      'Reset Password',
      name: 'verify_account_reset_password',
      desc: '',
      args: [],
    );
  }

  /// `Step 1 of 7`
  String get step_one_of_seven {
    return Intl.message(
      'Step 1 of 7',
      name: 'step_one_of_seven',
      desc: '',
      args: [],
    );
  }

  /// `Select Your Favorite`
  String get select_your_favorite {
    return Intl.message(
      'Select Your Favorite',
      name: 'select_your_favorite',
      desc: '',
      args: [],
    );
  }

  /// `Next Steps`
  String get next_step {
    return Intl.message(
      'Next Steps',
      name: 'next_step',
      desc: '',
      args: [],
    );
  }

  /// `Step 2 of 7`
  String get step_two_of_seven {
    return Intl.message(
      'Step 2 of 7',
      name: 'step_two_of_seven',
      desc: '',
      args: [],
    );
  }

  /// `How old are you?`
  String get how_old_are_you {
    return Intl.message(
      'How old are you?',
      name: 'how_old_are_you',
      desc: '',
      args: [],
    );
  }

  /// `Step 3 of 7`
  String get step_three_of_seven {
    return Intl.message(
      'Step 3 of 7',
      name: 'step_three_of_seven',
      desc: '',
      args: [],
    );
  }

  /// `How much do you weight?`
  String get how_much_do_you_weight {
    return Intl.message(
      'How much do you weight?',
      name: 'how_much_do_you_weight',
      desc: '',
      args: [],
    );
  }

  /// `LBS`
  String get lbs {
    return Intl.message(
      'LBS',
      name: 'lbs',
      desc: '',
      args: [],
    );
  }

  /// `KG`
  String get kg {
    return Intl.message(
      'KG',
      name: 'kg',
      desc: '',
      args: [],
    );
  }

  /// `Step 4 of 7`
  String get step_four_of_seven {
    return Intl.message(
      'Step 4 of 7',
      name: 'step_four_of_seven',
      desc: '',
      args: [],
    );
  }

  /// `What's your goal weight?`
  String get what_your_goal_weight {
    return Intl.message(
      'What\'s your goal weight?',
      name: 'what_your_goal_weight',
      desc: '',
      args: [],
    );
  }

  /// `Step 5 of 7`
  String get step_five_of_seven {
    return Intl.message(
      'Step 5 of 7',
      name: 'step_five_of_seven',
      desc: '',
      args: [],
    );
  }

  /// `How much do you Height?`
  String get how_much_do_you_height {
    return Intl.message(
      'How much do you Height?',
      name: 'how_much_do_you_height',
      desc: '',
      args: [],
    );
  }

  /// `FEET`
  String get feet {
    return Intl.message(
      'FEET',
      name: 'feet',
      desc: '',
      args: [],
    );
  }

  /// `CM`
  String get cm {
    return Intl.message(
      'CM',
      name: 'cm',
      desc: '',
      args: [],
    );
  }

  /// `Step 6 of 7`
  String get step_six_of_seven {
    return Intl.message(
      'Step 6 of 7',
      name: 'step_six_of_seven',
      desc: '',
      args: [],
    );
  }

  /// `What's your fitness level?`
  String get what_is_fitness_level {
    return Intl.message(
      'What\'s your fitness level?',
      name: 'what_is_fitness_level',
      desc: '',
      args: [],
    );
  }

  /// `Beginner`
  String get beginner {
    return Intl.message(
      'Beginner',
      name: 'beginner',
      desc: '',
      args: [],
    );
  }

  /// `Intermediate`
  String get intermediate {
    return Intl.message(
      'Intermediate',
      name: 'intermediate',
      desc: '',
      args: [],
    );
  }

  /// `Advanced`
  String get advanced {
    return Intl.message(
      'Advanced',
      name: 'advanced',
      desc: '',
      args: [],
    );
  }

  /// `Step 7 of 7`
  String get step_seven_of_seven {
    return Intl.message(
      'Step 7 of 7',
      name: 'step_seven_of_seven',
      desc: '',
      args: [],
    );
  }

  /// `What's your goal`
  String get what_is_your_goal {
    return Intl.message(
      'What\'s your goal',
      name: 'what_is_your_goal',
      desc: '',
      args: [],
    );
  }

  /// `Weight loss`
  String get weight_loss {
    return Intl.message(
      'Weight loss',
      name: 'weight_loss',
      desc: '',
      args: [],
    );
  }

  /// `Gain muscle`
  String get gain_muscle {
    return Intl.message(
      'Gain muscle',
      name: 'gain_muscle',
      desc: '',
      args: [],
    );
  }

  /// `Improve fitness`
  String get improve_fitness {
    return Intl.message(
      'Improve fitness',
      name: 'improve_fitness',
      desc: '',
      args: [],
    );
  }

  /// `Finish Steps`
  String get finish_step {
    return Intl.message(
      'Finish Steps',
      name: 'finish_step',
      desc: '',
      args: [],
    );
  }

  /// `Let's get started`
  String get let_get_started {
    return Intl.message(
      'Let\'s get started',
      name: 'let_get_started',
      desc: '',
      args: [],
    );
  }

  /// `The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.`
  String get The_standard_chunk_of_Lorem_Ipsum {
    return Intl.message(
      'The standard chunk of Lorem Ipsum used since the 1500s is reproduced below for those interested.',
      name: 'The_standard_chunk_of_Lorem_Ipsum',
      desc: '',
      args: [],
    );
  }

  /// `Sculpt your ideal body, free your true self, transform your life.`
  String get Sculpt_your_ideal_body_free_your {
    return Intl.message(
      'Sculpt your ideal body, free your true self, transform your life.',
      name: 'Sculpt_your_ideal_body_free_your',
      desc: '',
      args: [],
    );
  }

  /// `Get Started`
  String get get_started {
    return Intl.message(
      'Get Started',
      name: 'get_started',
      desc: '',
      args: [],
    );
  }

  /// `Search`
  String get search {
    return Intl.message(
      'Search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `No search found`
  String get no_search {
    return Intl.message(
      'No search found',
      name: 'no_search',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get category {
    return Intl.message(
      'Category',
      name: 'category',
      desc: '',
      args: [],
    );
  }

  /// `See all`
  String get see_all {
    return Intl.message(
      'See all',
      name: 'see_all',
      desc: '',
      args: [],
    );
  }

  /// `Popular Exercise`
  String get popular_exercise {
    return Intl.message(
      'Popular Exercise',
      name: 'popular_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Categories`
  String get categories_screen {
    return Intl.message(
      'Categories',
      name: 'categories_screen',
      desc: '',
      args: [],
    );
  }

  /// `Favorites`
  String get my_favorites {
    return Intl.message(
      'Favorites',
      name: 'my_favorites',
      desc: '',
      args: [],
    );
  }

  /// `Subscription`
  String get my_subscription {
    return Intl.message(
      'Subscription',
      name: 'my_subscription',
      desc: '',
      args: [],
    );
  }

  /// `Popular Training`
  String get popular_training {
    return Intl.message(
      'Popular Training',
      name: 'popular_training',
      desc: '',
      args: [],
    );
  }

  /// `Workout`
  String get workout {
    return Intl.message(
      'Workout',
      name: 'workout',
      desc: '',
      args: [],
    );
  }

  /// `Profile`
  String get Profile {
    return Intl.message(
      'Profile',
      name: 'Profile',
      desc: '',
      args: [],
    );
  }

  /// `Weight`
  String get Weight {
    return Intl.message(
      'Weight',
      name: 'Weight',
      desc: '',
      args: [],
    );
  }

  /// `Height`
  String get Height {
    return Intl.message(
      'Height',
      name: 'Height',
      desc: '',
      args: [],
    );
  }

  /// `Age`
  String get Age {
    return Intl.message(
      'Age',
      name: 'Age',
      desc: '',
      args: [],
    );
  }

  /// `Goal`
  String get Goal {
    return Intl.message(
      'Goal',
      name: 'Goal',
      desc: '',
      args: [],
    );
  }

  /// `Your Goals`
  String get your_goal {
    return Intl.message(
      'Your Goals',
      name: 'your_goal',
      desc: '',
      args: [],
    );
  }

  /// `Edit Profile`
  String get Edit_Profile {
    return Intl.message(
      'Edit Profile',
      name: 'Edit_Profile',
      desc: '',
      args: [],
    );
  }

  /// `Save`
  String get Save {
    return Intl.message(
      'Save',
      name: 'Save',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get Change_Password {
    return Intl.message(
      'Change Password',
      name: 'Change_Password',
      desc: '',
      args: [],
    );
  }

  /// `Theme`
  String get theme {
    return Intl.message(
      'Theme',
      name: 'theme',
      desc: '',
      args: [],
    );
  }

  /// `Light`
  String get light {
    return Intl.message(
      'Light',
      name: 'light',
      desc: '',
      args: [],
    );
  }

  /// `Dark`
  String get dark {
    return Intl.message(
      'Dark',
      name: 'dark',
      desc: '',
      args: [],
    );
  }

  /// `Device`
  String get device {
    return Intl.message(
      'Device',
      name: 'device',
      desc: '',
      args: [],
    );
  }

  /// `When enabled, it automatically follows the Dark and Light appearance selection located in your device settings.`
  String get device_text {
    return Intl.message(
      'When enabled, it automatically follows the Dark and Light appearance selection located in your device settings.',
      name: 'device_text',
      desc: '',
      args: [],
    );
  }

  /// `Upgrade premium`
  String get Upgrade_premium {
    return Intl.message(
      'Upgrade premium',
      name: 'Upgrade_premium',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get Date {
    return Intl.message(
      'Date',
      name: 'Date',
      desc: '',
      args: [],
    );
  }

  /// `Time`
  String get time {
    return Intl.message(
      'Time',
      name: 'time',
      desc: '',
      args: [],
    );
  }

  /// `Set Reminder`
  String get Set_Reminder {
    return Intl.message(
      'Set Reminder',
      name: 'Set_Reminder',
      desc: '',
      args: [],
    );
  }

  /// `Reminder on`
  String get Reminder_on {
    return Intl.message(
      'Reminder on',
      name: 'Reminder_on',
      desc: '',
      args: [],
    );
  }

  /// `Done`
  String get done {
    return Intl.message(
      'Done',
      name: 'done',
      desc: '',
      args: [],
    );
  }

  /// `Current Password`
  String get Current_Password {
    return Intl.message(
      'Current Password',
      name: 'Current_Password',
      desc: '',
      args: [],
    );
  }

  /// `New Password`
  String get New_Password {
    return Intl.message(
      'New Password',
      name: 'New_Password',
      desc: '',
      args: [],
    );
  }

  /// `Change Password`
  String get change_password {
    return Intl.message(
      'Change Password',
      name: 'change_password',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password`
  String get confirm_password {
    return Intl.message(
      'Confirm Password',
      name: 'confirm_password',
      desc: '',
      args: [],
    );
  }

  /// `Subscribe to premium`
  String get Subscribe_to_premium {
    return Intl.message(
      'Subscribe to premium',
      name: 'Subscribe_to_premium',
      desc: '',
      args: [],
    );
  }

  /// `Enjoy unlimited access to our`
  String get Enjoy_unlimited_access_to_our {
    return Intl.message(
      'Enjoy unlimited access to our',
      name: 'Enjoy_unlimited_access_to_our',
      desc: '',
      args: [],
    );
  }

  /// `premium content`
  String get premium_content {
    return Intl.message(
      'premium content',
      name: 'premium_content',
      desc: '',
      args: [],
    );
  }

  /// `Unlock Premium`
  String get Unlock_Premium {
    return Intl.message(
      'Unlock Premium',
      name: 'Unlock_Premium',
      desc: '',
      args: [],
    );
  }

  /// `The Fitness app offers several benefits to subscribers.`
  String get subscription_subtitle {
    return Intl.message(
      'The Fitness app offers several benefits to subscribers.',
      name: 'subscription_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Go Premium`
  String get Go_Premium {
    return Intl.message(
      'Go Premium',
      name: 'Go_Premium',
      desc: '',
      args: [],
    );
  }

  /// `Full Exercise`
  String get Full_Exercise {
    return Intl.message(
      'Full Exercise',
      name: 'Full_Exercise',
      desc: '',
      args: [],
    );
  }

  /// `Level`
  String get level {
    return Intl.message(
      'Level',
      name: 'level',
      desc: '',
      args: [],
    );
  }

  /// `Category`
  String get Category {
    return Intl.message(
      'Category',
      name: 'Category',
      desc: '',
      args: [],
    );
  }

  /// `Schedule Exercise`
  String get Schedule_Exercise {
    return Intl.message(
      'Schedule Exercise',
      name: 'Schedule_Exercise',
      desc: '',
      args: [],
    );
  }

  /// `Schedule`
  String get Schedule {
    return Intl.message(
      'Schedule',
      name: 'Schedule',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Program`
  String get Exercise_Program {
    return Intl.message(
      'Exercise Program',
      name: 'Exercise_Program',
      desc: '',
      args: [],
    );
  }

  /// `Start now`
  String get Start_now {
    return Intl.message(
      'Start now',
      name: 'Start_now',
      desc: '',
      args: [],
    );
  }

  /// `Stop`
  String get Stop {
    return Intl.message(
      'Stop',
      name: 'Stop',
      desc: '',
      args: [],
    );
  }

  /// `Start`
  String get start {
    return Intl.message(
      'Start',
      name: 'start',
      desc: '',
      args: [],
    );
  }

  /// `Workout Section`
  String get workout_section {
    return Intl.message(
      'Workout Section',
      name: 'workout_section',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get privacy_policy {
    return Intl.message(
      'Privacy Policy',
      name: 'privacy_policy',
      desc: '',
      args: [],
    );
  }

  /// `Terms & condition`
  String get terms {
    return Intl.message(
      'Terms & condition',
      name: 'terms',
      desc: '',
      args: [],
    );
  }

  /// `Rate Us`
  String get rate_us {
    return Intl.message(
      'Rate Us',
      name: 'rate_us',
      desc: '',
      args: [],
    );
  }

  /// `Share App`
  String get share_app {
    return Intl.message(
      'Share App',
      name: 'share_app',
      desc: '',
      args: [],
    );
  }

  /// `Delete Account`
  String get delete_Account {
    return Intl.message(
      'Delete Account',
      name: 'delete_Account',
      desc: '',
      args: [],
    );
  }

  /// `This account is deleted!`
  String get delete_Account_status {
    return Intl.message(
      'This account is deleted!',
      name: 'delete_Account_status',
      desc: '',
      args: [],
    );
  }

  /// `Your new password must be different from previous used passwords.`
  String get change_password_text {
    return Intl.message(
      'Your new password must be different from previous used passwords.',
      name: 'change_password_text',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Password does not match !!`
  String get confirm_pass_not_match {
    return Intl.message(
      'Confirm Password does not match !!',
      name: 'confirm_pass_not_match',
      desc: '',
      args: [],
    );
  }

  /// `No Meal`
  String get no_meal {
    return Intl.message(
      'No Meal',
      name: 'no_meal',
      desc: '',
      args: [],
    );
  }

  /// `No Workout`
  String get no_workout {
    return Intl.message(
      'No Workout',
      name: 'no_workout',
      desc: '',
      args: [],
    );
  }

  /// `No Exercise`
  String get no_exercise {
    return Intl.message(
      'No Exercise',
      name: 'no_exercise',
      desc: '',
      args: [],
    );
  }

  /// `Kcal`
  String get kcal {
    return Intl.message(
      'Kcal',
      name: 'kcal',
      desc: '',
      args: [],
    );
  }

  /// `Min`
  String get min {
    return Intl.message(
      'Min',
      name: 'min',
      desc: '',
      args: [],
    );
  }

  /// `Read more`
  String get read_more {
    return Intl.message(
      'Read more',
      name: 'read_more',
      desc: '',
      args: [],
    );
  }

  /// `Read less`
  String get read_less {
    return Intl.message(
      'Read less',
      name: 'read_less',
      desc: '',
      args: [],
    );
  }

  /// `Logout`
  String get logout {
    return Intl.message(
      'Logout',
      name: 'logout',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to logout this account?`
  String get logout_text {
    return Intl.message(
      'Do you want to logout this account?',
      name: 'logout_text',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this account? this action cannot be undone`
  String get delete_text {
    return Intl.message(
      'Do you want to delete this account? this action cannot be undone',
      name: 'delete_text',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Meals`
  String get meals {
    return Intl.message(
      'Meals',
      name: 'meals',
      desc: '',
      args: [],
    );
  }

  /// `Rate`
  String get rate {
    return Intl.message(
      'Rate',
      name: 'rate',
      desc: '',
      args: [],
    );
  }

  /// `Fat`
  String get fat {
    return Intl.message(
      'Fat',
      name: 'fat',
      desc: '',
      args: [],
    );
  }

  /// `Protein`
  String get protein {
    return Intl.message(
      'Protein',
      name: 'protein',
      desc: '',
      args: [],
    );
  }

  /// `Carbs`
  String get carbs {
    return Intl.message(
      'Carbs',
      name: 'carbs',
      desc: '',
      args: [],
    );
  }

  /// `Good Morning`
  String get good_morning {
    return Intl.message(
      'Good Morning',
      name: 'good_morning',
      desc: '',
      args: [],
    );
  }

  /// `Good Afternoon`
  String get good_afternoon {
    return Intl.message(
      'Good Afternoon',
      name: 'good_afternoon',
      desc: '',
      args: [],
    );
  }

  /// `Good Evening`
  String get good_evening {
    return Intl.message(
      'Good Evening',
      name: 'good_evening',
      desc: '',
      args: [],
    );
  }

  /// `Exercise Time`
  String get exercise_Time {
    return Intl.message(
      'Exercise Time',
      name: 'exercise_Time',
      desc: '',
      args: [],
    );
  }

  /// `Home`
  String get home {
    return Intl.message(
      'Home',
      name: 'home',
      desc: '',
      args: [],
    );
  }

  /// `Exercise`
  String get exercise {
    return Intl.message(
      'Exercise',
      name: 'exercise',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings {
    return Intl.message(
      'Settings',
      name: 'settings',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get Continue {
    return Intl.message(
      'Continue',
      name: 'Continue',
      desc: '',
      args: [],
    );
  }

  /// `App Tracking permission needed`
  String get track_needed {
    return Intl.message(
      'App Tracking permission needed',
      name: 'track_needed',
      desc: '',
      args: [],
    );
  }

  /// `This app needs access to your app tracking, to better user experience, Your data is used solely for advertising purposes and is not shared with third parties for any other purposes. If you don't feel comfortable with this permission, you can go to Settings > Permissions and modify it at any time.`
  String get track_text {
    return Intl.message(
      'This app needs access to your app tracking, to better user experience, Your data is used solely for advertising purposes and is not shared with third parties for any other purposes. If you don\'t feel comfortable with this permission, you can go to Settings > Permissions and modify it at any time.',
      name: 'track_text',
      desc: '',
      args: [],
    );
  }

  /// `Permission`
  String get permission {
    return Intl.message(
      'Permission',
      name: 'permission',
      desc: '',
      args: [],
    );
  }

  /// `Allow access to your app tracking. Tap Settings > Permissions, and turn the Allow Tracking on.`
  String get permission_text {
    return Intl.message(
      'Allow access to your app tracking. Tap Settings > Permissions, and turn the Allow Tracking on.',
      name: 'permission_text',
      desc: '',
      args: [],
    );
  }

  /// `Explore the app as guest`
  String get guest {
    return Intl.message(
      'Explore the app as guest',
      name: 'guest',
      desc: '',
      args: [],
    );
  }

  /// `Login to get more features`
  String get login_Required {
    return Intl.message(
      'Login to get more features',
      name: 'login_Required',
      desc: '',
      args: [],
    );
  }

  /// `(Optional) you can edit it later.`
  String get optional {
    return Intl.message(
      '(Optional) you can edit it later.',
      name: 'optional',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'de'),
      Locale.fromSubtags(languageCode: 'es'),
      Locale.fromSubtags(languageCode: 'fr'),
      Locale.fromSubtags(languageCode: 'it'),
      Locale.fromSubtags(languageCode: 'pt'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
