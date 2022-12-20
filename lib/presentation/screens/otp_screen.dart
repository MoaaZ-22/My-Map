// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/constants/strings.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import '../../constants/my_colors.dart';

// ignore: must_be_immutable
class OTPScreen extends StatelessWidget {
  final dynamic phoneNumber;
  OTPScreen({Key? key,required this.phoneNumber}) : super(key: key);
  late String otpCode;
  Widget _buildUpperText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Verify your phone number',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: RichText(
            text:  TextSpan(
                text: 'Enter the 6-digit number that was sent to ',
                children:
                <TextSpan>
                [
                  TextSpan(text: phoneNumber!, style: const TextStyle(color: MyColors.blue))
                ],
                style: const TextStyle(fontSize: 18, color: Colors.black, height: 1.4,)),
          ),
        )
      ],
    );
  }

  Widget _buildPinCodeFields(BuildContext context)
  {
    return PinCodeTextField(
      autoFocus: true,
      cursorColor: Colors.black,
      keyboardType: TextInputType.number,
      appContext: context,
      length: 6,
      obscureText: false,
      animationType: AnimationType.scale,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(5),
        fieldHeight: 50,
        fieldWidth: 40,
        borderWidth: 1,
        activeColor: MyColors.blue,
        inactiveColor: MyColors.blue,
        inactiveFillColor: Colors.white,
        activeFillColor: MyColors.lightBlue,
        selectedColor: MyColors.blue,
        selectedFillColor: Colors.white
      ),
      animationDuration: const Duration(milliseconds: 300),
      backgroundColor: Colors.white,
      enableActiveFill: true,
      onCompleted: (code) {
        otpCode = code;
      },
      onChanged: (value) {
        print(value);
      },
    );
  }

  void _login(BuildContext context)
  {
    BlocProvider.of<PhoneAuthCubit>(context).submitOTP(otpCode);
  }

  Widget _buildVerifyButton(BuildContext context)
  {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: ElevatedButton(
        onPressed: ()
        {
          showProgressIndicator(context);
          _login(context);
        },
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(110, 50),
            backgroundColor: Colors.black,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6)
            )
        ),
        child: const Text('Verify', style: TextStyle(color: Colors.white, fontSize: 16),),
      ),
    );
  }

  void showProgressIndicator(BuildContext  context)
  {
    const AlertDialog alertDialog = AlertDialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      content: Center(child: CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.black)),),
    );

    showDialog(
        barrierColor: Colors.white.withOpacity(0),
        barrierDismissible: false,
        context: context, builder: (context)
    {
      return alertDialog;
    });
  }

  Widget _buildPhoneVerificationBloc()
  {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
        listenWhen: (previousState, currentState)
        {
          return previousState != currentState;
        },
        listener: (BuildContext context, PhoneAuthState state)
        {
          if(state is Loading)
          {
            showProgressIndicator(context);
          }
          if(state is PhoneOTPVerified)
          {
            Navigator.pop(context);
            Navigator.of(context).pushReplacementNamed(mapScreen);
          }
          if (state is Error)
          {
            Navigator.pop(context);
            String errorMsg = (state).error!;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(errorMsg), backgroundColor: Colors.black, duration: const Duration(seconds: 4),)
            );
          }
        },
      child: Container(),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.white,));
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
        child: Column(
          children: [
            _buildUpperText(),
            const SizedBox(
              height: 88,
            ),
            _buildPinCodeFields(context),
            const SizedBox(
              height: 20,
            ),
            _buildVerifyButton(context),
            _buildPhoneVerificationBloc()
          ],
        ),
      ),
    ));
  }
}
