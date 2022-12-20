// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {

  PhoneAuthCubit() : super(PhoneAuthInitial());

  late String verificationId;

  Future<void> submitPhoneNumber(dynamic phoneNumber)
  async
  {
    emit(Loading());

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential)
  async
  {
    print("verificationCompleted");
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException exception)
  {
    print('Error ${exception.toString()}');
    emit(Error(error: exception.toString()));
  }

  void codeSent(String verificationId, int? resendToken)
  {
    this.verificationId = verificationId;
    emit(PhoneNumberSubmitted());
  }

  void codeAutoRetrievalTimeout(String verificationId)
  {
    print('CodeAutoRetrievalTimeout');
  }

  Future<void> submitOTP(String otpCode) async
  {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: otpCode);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async
  {
   await FirebaseAuth.instance.signInWithCredential(credential).then((value)
    {
      print(value);
      emit(PhoneOTPVerified());
    }).catchError((error) {print(error.toString());emit(Error(error: error.toString()));});
  }

  Future<void> logOut() async
  {
    await FirebaseAuth.instance.signOut();
  }

  User getCurrentUser()
  {
    User firebaseUser = FirebaseAuth.instance.currentUser!;
    return firebaseUser;
  }

}
