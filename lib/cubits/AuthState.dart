import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}

class AuthInitialState extends AuthState{}
class AuthVerificationState extends AuthState{}
class AuthCodeSentState extends AuthState{}
class AuthLoadingState extends AuthState{}
class AuthLoggedInState extends AuthState{
  final User? firebaseUser ;
  AuthLoggedInState(this.firebaseUser);
}
class AuthErrorState extends AuthState{
  final String errorMessage;
  AuthErrorState(this.errorMessage);
}
class AuthLoggedOutState extends AuthState{}