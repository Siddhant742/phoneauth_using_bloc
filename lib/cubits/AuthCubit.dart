import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoneauth_using_bloc/cubits/AuthState.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthCubit extends Cubit<AuthState>{
  FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit(): super(AuthInitialState());
    String? _verificationId;
    void SignInWithPhone ( PhoneAuthCredential credential) async{
      try{
        UserCredential userCredential = await _auth.signInWithCredential(credential);
        if(userCredential.user != null){
          emit(AuthLoggedInState(userCredential.user));
        }
      } on FirebaseAuthException catch(e){
        emit(AuthErrorState(e.message.toString()));
      }

    }

    void sendOTP(String PhoneNumber) async{
      emit(AuthLoadingState());
      _auth.verifyPhoneNumber(phoneNumber: PhoneNumber,
        codeSent: (String verificationId, int? forceResendingToken) {
        _verificationId =  verificationId;
        emit(AuthCodeSentState());
        },
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) {
        SignInWithPhone(phoneAuthCredential);
        },
        verificationFailed: (FirebaseAuthException error) {
        emit(AuthErrorState(error.message.toString()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
        },

      );
    }
    void verifyOTP(String otp) async{
      emit(AuthLoadingState());
      PhoneAuthCredential credential  = PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: otp);
      SignInWithPhone(credential);
    }



}