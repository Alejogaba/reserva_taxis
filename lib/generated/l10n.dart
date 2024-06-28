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

  /// `Login`
  String get loginPageTitle {
    return Intl.message(
      'Login',
      name: 'loginPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `Email`
  String get emailHintText {
    return Intl.message(
      'Email',
      name: 'emailHintText',
      desc: '',
      args: [],
    );
  }

  /// `Password`
  String get passwordHintText {
    return Intl.message(
      'Password',
      name: 'passwordHintText',
      desc: '',
      args: [],
    );
  }

  /// `Please do not leave this field empty`
  String get emptyFieldError {
    return Intl.message(
      'Please do not leave this field empty',
      name: 'emptyFieldError',
      desc: '',
      args: [],
    );
  }

  /// `Please enter a valid email address`
  String get validEmailError {
    return Intl.message(
      'Please enter a valid email address',
      name: 'validEmailError',
      desc: '',
      args: [],
    );
  }

  /// `Password must be at least 6 characters long`
  String get shortPasswordError {
    return Intl.message(
      'Password must be at least 6 characters long',
      name: 'shortPasswordError',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginButtonText {
    return Intl.message(
      'Login',
      name: 'loginButtonText',
      desc: '',
      args: [],
    );
  }

  /// `Taxi`
  String get taxiTitle {
    return Intl.message(
      'Taxi',
      name: 'taxiTitle',
      desc: '',
      args: [],
    );
  }

  /// `Management`
  String get managementTitle {
    return Intl.message(
      'Management',
      name: 'managementTitle',
      desc: '',
      args: [],
    );
  }

  /// `Login`
  String get loginSubtitle {
    return Intl.message(
      'Login',
      name: 'loginSubtitle',
      desc: '',
      args: [],
    );
  }

  /// `Show password`
  String get togglePasswordVisibility {
    return Intl.message(
      'Show password',
      name: 'togglePasswordVisibility',
      desc: '',
      args: [],
    );
  }

  /// `Location not available`
  String get locationNotAvailable {
    return Intl.message(
      'Location not available',
      name: 'locationNotAvailable',
      desc: '',
      args: [],
    );
  }

  /// `Enable Location`
  String get activateLocation {
    return Intl.message(
      'Enable Location',
      name: 'activateLocation',
      desc: '',
      args: [],
    );
  }

  /// `Invalid route, verify the destination`
  String get invalidRouteMessage {
    return Intl.message(
      'Invalid route, verify the destination',
      name: 'invalidRouteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Is this the route you want to take?`
  String get confirmRouteMessage {
    return Intl.message(
      'Is this the route you want to take?',
      name: 'confirmRouteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Now you must select the point you wish to reach`
  String get selectRouteMessage {
    return Intl.message(
      'Now you must select the point you wish to reach',
      name: 'selectRouteMessage',
      desc: '',
      args: [],
    );
  }

  /// `Select Destination`
  String get selectDestination {
    return Intl.message(
      'Select Destination',
      name: 'selectDestination',
      desc: '',
      args: [],
    );
  }

  /// `Continue`
  String get continueButton {
    return Intl.message(
      'Continue',
      name: 'continueButton',
      desc: '',
      args: [],
    );
  }

  /// `Your Location`
  String get yourLocation {
    return Intl.message(
      'Your Location',
      name: 'yourLocation',
      desc: '',
      args: [],
    );
  }

  /// `Search destination`
  String get searchDestinationHint {
    return Intl.message(
      'Search destination',
      name: 'searchDestinationHint',
      desc: '',
      args: [],
    );
  }

  /// `Area not available`
  String get outsidePickAreaText {
    return Intl.message(
      'Area not available',
      name: 'outsidePickAreaText',
      desc: '',
      args: [],
    );
  }

  /// `Searching...`
  String get searchingText {
    return Intl.message(
      'Searching...',
      name: 'searchingText',
      desc: '',
      args: [],
    );
  }

  /// `You must grant location permissions to the app to proceed`
  String get turnOnLocation {
    return Intl.message(
      'You must grant location permissions to the app to proceed',
      name: 'turnOnLocation',
      desc: '',
      args: [],
    );
  }

  /// `Reservation Details`
  String get reservationDetailsTitle {
    return Intl.message(
      'Reservation Details',
      name: 'reservationDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `Origin`
  String get origin {
    return Intl.message(
      'Origin',
      name: 'origin',
      desc: '',
      args: [],
    );
  }

  /// `Destination`
  String get destination {
    return Intl.message(
      'Destination',
      name: 'destination',
      desc: '',
      args: [],
    );
  }

  /// `Distance`
  String get distance {
    return Intl.message(
      'Distance',
      name: 'distance',
      desc: '',
      args: [],
    );
  }

  /// `Estimated Duration`
  String get estimatedDuration {
    return Intl.message(
      'Estimated Duration',
      name: 'estimatedDuration',
      desc: '',
      args: [],
    );
  }

  /// `Hours`
  String get hours {
    return Intl.message(
      'Hours',
      name: 'hours',
      desc: '',
      args: [],
    );
  }

  /// `Completed`
  String get completedTitle {
    return Intl.message(
      'Completed',
      name: 'completedTitle',
      desc: '',
      args: [],
    );
  }

  /// `Reservation created successfully`
  String get reservationSuccess {
    return Intl.message(
      'Reservation created successfully',
      name: 'reservationSuccess',
      desc: '',
      args: [],
    );
  }

  /// `Create Reservation`
  String get createReservation {
    return Intl.message(
      'Create Reservation',
      name: 'createReservation',
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
      Locale.fromSubtags(languageCode: 'es'),
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
