import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoneauth_using_bloc/cubits/AuthCubit.dart';
import 'package:phoneauth_using_bloc/cubits/AuthState.dart';
import 'package:phoneauth_using_bloc/screens/SignInScreen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Wanna Log Out?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xee4abe5c)),
              ),
              BlocConsumer<AuthCubit,AuthState>(
                builder: (BuildContext context, state) {
                  return CupertinoButton(
                      child: Text('Log Out'),
                      onPressed: () {
                        BlocProvider.of<AuthCubit>(context).LogOut();
                      });
                },
                listener: (BuildContext context, Object? state) {
                  if (state is AuthLoggedOutState) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignInScreen()));
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
