import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps/business_logic/cubit/maps/maps_cubit.dart';
import 'package:maps/business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import 'package:maps/data/repository/maps_repo.dart';
import 'package:maps/data/webservices/PlacesWebservices.dart';
import 'package:maps/presentation/screens/login_screen.dart';
import 'package:maps/presentation/screens/map_screen.dart';
import 'package:maps/presentation/screens/otp_screen.dart';
import 'constants/strings.dart';

class AppRouter {

  PhoneAuthCubit? phoneAuthCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case mapScreen :
        return MaterialPageRoute(builder: (_) => BlocProvider(
            create: (BuildContext context) => MapsCubit(MapsRepository(PlacesWebServices())),
            child: const MapScreen(),
        )
        );
      case loginScreen :
        return MaterialPageRoute(
            builder: (_) =>
            BlocProvider<PhoneAuthCubit>.value(
              value: phoneAuthCubit!,
              child: LoginScreen(),
            ));
      case otpScreen :
        final dynamic phoneNumber = settings.arguments;
        return MaterialPageRoute(builder: (_) =>
            BlocProvider<PhoneAuthCubit>.value(
              value: phoneAuthCubit!,
              child: OTPScreen(phoneNumber: phoneNumber,),
            ));
    }
    return null;
  }
}