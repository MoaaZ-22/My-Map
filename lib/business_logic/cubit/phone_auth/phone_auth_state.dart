part of 'phone_auth_cubit.dart';

abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class Loading extends PhoneAuthState{}

class Error extends PhoneAuthState{
  final String? error;

  Error({required this.error});
}

class PhoneNumberSubmitted extends PhoneAuthState{}

class PhoneOTPVerified extends PhoneAuthState{}