import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:phoneauth_using_bloc/cubits/AuthCubit.dart';
import 'package:phoneauth_using_bloc/cubits/AuthState.dart';
import 'package:phoneauth_using_bloc/screens/VerifyPhoneNumberScreen.dart';


class SignInScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    return Scaffold(
        appBar: AppBar(
          title: Text('SignIn Screen'),
        ),
        body: SafeArea(
          child: ListView(
            padding: EdgeInsets.only(left: 15, right: 15),
            children: [
              TextField(
                // textInputAction: TextInputAction.newline ,
               textDirection: TextDirection.ltr ,
                controller: phoneController,
                onChanged: (value) {
                  phoneController.text = value;
                  phoneController.selection =
                      TextSelection.collapsed(offset: phoneController.text.length);
                },
                decoration: InputDecoration(
                  hintText: 'Phone Number',
                  //
                ),
              ),
              SizedBox(
                height: 10,
              ),
              BlocConsumer<AuthCubit, AuthState>(

                builder: (BuildContext context, state) {
                  if (state is AuthLoadingState){
                    return Center(child: CircularProgressIndicator(),);
                  }
                  return SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: CupertinoButton(
                      onPressed: () {
                        String PhoneNumber;
                        PhoneNumber = "+977"+phoneController.text;
                        BlocProvider.of<AuthCubit>(context).sendOTP(PhoneNumber);
                      },
                      child: Text('Sign In'),
                      color: Colors.orange,
                    ),
                  );
                },
                listener: (BuildContext context, Object? state) {
                  if(state is AuthCodeSentState){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>VerifyPhoneNumberScreen()));
                  }
                },
              )
            ],
          ),
        ));
  }
}
