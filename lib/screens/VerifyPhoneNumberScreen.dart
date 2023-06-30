import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoneauth_using_bloc/cubits/AuthCubit.dart';
import 'package:phoneauth_using_bloc/cubits/AuthState.dart';
import 'package:phoneauth_using_bloc/screens/HomeScreen.dart';

class VerifyPhoneNumberScreen extends StatelessWidget {
  TextEditingController otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Verify Phone Number'),
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.only(left: 15, right: 15),
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                hintText: '6-digit OTP',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            BlocConsumer<AuthCubit,AuthState>(
              builder: (BuildContext context, state) {
                return SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: CupertinoButton(
                    onPressed: () {
                      BlocProvider.of<AuthCubit>(context)
                          .verifyOTP(otpController.text);
                    },
                    child: Text('Verify'),
                    color: Colors.orange,
                  ),
                );
              },
              listener: (BuildContext context, Object? state) {
                if (state is AuthLoggedInState) {
                  Navigator.popUntil(context, (route) => route.isFirst);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                } else if (state is AuthErrorState) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(state.errorMessage.toString()),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ));
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
