import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps/constants/my_colors.dart';
import 'package:maps/constants/strings.dart';

// ignore: must_be_immutable
class LoginScreen extends StatelessWidget {

  // ignore: prefer_const_constructors_in_immutables
  LoginScreen({Key? key}) : super(key: key);
  late final dynamic phoneNumber;
  final GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();

  Widget _buildPhoneFormFiled(BuildContext context) {
    return Row(
      children: [
        Expanded(
            flex: 1,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              alignment: AlignmentDirectional.center,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.lightGrey,
                  ),
                  borderRadius: const BorderRadius.all(Radius.circular(6))),
              child: Text(
                '${generateCountryFlag()} +02',
                style: const TextStyle(fontSize: 18, letterSpacing: 2.0),
              ),
            )),
        const SizedBox(
          width: 16,
        ),
        Expanded(
            flex: 2,
            child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                decoration: BoxDecoration(
                    border: Border.all(
                      color: MyColors.blue,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(6))),
                child: TextFormField(
                  autofocus: true,
                  style: const TextStyle(fontSize: 18, letterSpacing: 2.0),
                  decoration: const InputDecoration(
                      border: InputBorder.none
                  ),
                  cursorColor: Colors.black,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if(value!.isEmpty)
                    {
                      return 'Please enter your phone number!';
                    }
                    else if(value.length < 11)
                    {
                      return 'Too short for phone number !';
                    }
                    return null;
                  },
                  onSaved: (value)
                  {
                    phoneNumber = value;
                  },
                ))),
      ],
    );
  }

  Future<void> _register(BuildContext context) async
  {
    if(!loginFormKey.currentState!.validate())
      {
        Navigator.pop(context);
        return;
      }
    else
      {
        Navigator.pop(context);
        loginFormKey.currentState!.save();
        BlocProvider.of<PhoneAuthCubit>(context).submitPhoneNumber(phoneNumber!);
      }
  }

  Widget _buildNextButton(BuildContext context) {
    return Align(
      alignment: AlignmentDirectional.bottomEnd,
      child: ElevatedButton(
        onPressed: (){
          showProgressIndicator(context);

          _register(context);
        },
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(110, 50),
          backgroundColor: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6)
          )
        ),
        child: const Text('Next', style: TextStyle(color: Colors.white, fontSize: 16),),
      ),
    );
  }

  String generateCountryFlag() {
    String countryCode = 'eg';
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
            (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));
    return flag;
  }

  Widget _buildUpperText() {
    return Column(
      children: [
        const Text(
          'What is your phone number ?',
          style: TextStyle(
              color: Colors.black, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2),
          child: const Text(
            'Please enter your phone number to verify your account.',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
            ),
          ),
        )
      ],
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

  Widget _buildPhoneNumberSubmittedBloc()
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
          else if(state is PhoneNumberSubmitted)
            {
              Navigator.pop(context);
              Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
            }
          else if (state is Error) {
            String errorMsg = (state).error!;
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(errorMsg),
                  backgroundColor: Colors.black,
                  duration: const Duration(seconds: 4),)
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
      body: Form(
        key: loginFormKey,
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 32, horizontal: 20),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildUpperText(),
                const SizedBox(
                  height: 110,
                ),
                _buildPhoneFormFiled(context),
                const SizedBox(height: 20,),
                _buildNextButton(context),
                _buildPhoneNumberSubmittedBloc()
              ],
            ),
          ),
        ),
      ),
    ));
  }

}




