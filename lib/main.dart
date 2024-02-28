import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/screens/authuser_home_screen.dart';
import 'package:todo_app/screens/onboarding/onboarding_view.dart';
import 'package:todo_app/screens/unauth_user_home_screen.dart';
import 'package:todo_app/shared/cubits/appMode/app_mode_cubit.dart';
import 'package:todo_app/shared/cubits/login/login_cubit.dart';
import 'package:todo_app/shared/cubits/register/register_cubit.dart';
import 'package:todo_app/shared/cubits/unAuth_todo/un_auth_todo_cubit.dart';
import 'package:todo_app/shared/network/cache_helper.dart';
import 'package:todo_app/styles/themes.dart';
import 'bloc_observer.dart';
import 'screens/authentication/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();
  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  Widget widget;
  var isDark = CacheHelper.getData(key: "isDark");
  var onBoarding = CacheHelper.getData(key: "onBoarding");
  var uId = CacheHelper.getData(key: "uId");
  print("isDark : $isDark");
  print("onBoarding :  $onBoarding");
  print("uId :  $uId");
  print("Hi : ${FirebaseAuth.instance.currentUser ?? "null" }" );

  if(isDark == null)
  {
    isDark = false;
  }
  else {
    isDark = isDark;
  }
  /// For Onboarding

  if(onBoarding == false || onBoarding == null) {
    widget = OnBoardingView();
  }
  else if(onBoarding == true && uId == null || onBoarding == true && uId == -1){
    widget = LoginView();
  } else if(onBoarding == true && uId == "UnAuthUser") {
    widget = UnAuthUserHomeScreen();
  } else {
    widget = AuthUserHomeScreen();
  }

  runApp(MyApp(isDark,widget));
}

class MyApp extends StatefulWidget {
  final bool isDark;
  final Widget startWidget;
  MyApp(this.isDark,this.startWidget);

  @override
  State<MyApp> createState() => _MyAppState(startWidget);
}

class _MyAppState extends State<MyApp> {
  final Widget startWidget;

  _MyAppState(this.startWidget);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) =>UnAuthTodoCubit()..createDatabase()),

        BlocProvider(
            create: (context) =>
            AppModeCubit()
              ..changeAppMode(fromShared: widget.isDark)),
        BlocProvider(create: (context) => LoginCubit()),
        BlocProvider(create: (context) => RegisterCubit())
      ],


      child: BlocConsumer<AppModeCubit, AppModeState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return ProviderScope(
            child: MaterialApp(
              theme: lightTheme,
              darkTheme: darkTheme,
              themeMode: AppModeCubit.get(context).isDarkMode!
                  ? ThemeMode.dark
                  : ThemeMode.light,
                debugShowCheckedModeBanner: false,
                home: widget.startWidget,
              ),
          );
        },
      ),
    );
  }
}
