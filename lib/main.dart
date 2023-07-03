import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoneauth_using_bloc/cubits/AuthCubit.dart';
import 'package:phoneauth_using_bloc/screens/HomeScreen.dart';
import 'package:phoneauth_using_bloc/screens/VerifyPhoneNumberScreen.dart';
import 'cubits/AuthState.dart';
import 'firebase_options.dart';
import 'screens/SignInScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  } catch (e) {
    print('Error initializing Firebase: $e');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AuthCubit() ,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (oldState, newState){
            return oldState is AuthInitialState;
          },
            builder: (BuildContext context,state){
          if(state is AuthLoggedInState){
            return HomeScreen();
          }
          else if(state is AuthLoggedOutState){
            return SignInScreen();
          }
          else {
            return Scaffold();
          }
        }),
      ),
    );
  }
}

