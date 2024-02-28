import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:todo_app/screens/authentication/signup_view.dart';
import 'package:todo_app/screens/authuser_home_screen.dart';
import 'package:todo_app/screens/unauth_user_home_screen.dart';
import '../../shared/components/navigator.dart';
import '../../shared/components/toast_messages.dart';
import '../../shared/cubits/login/login_cubit.dart';
import '../../shared/network/cache_helper.dart';
import 'forget_pass_view.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccessState) {
          CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
            if(state.uId != "UnAuthUser"){
              print("aUth");
              AppNavigator.customNavigator(
                  context: context, screen: AuthUserHomeScreen(), finish: true);
            }
            else {
              print("UnaUth");
              AppNavigator.customNavigator(context: context, screen: UnAuthUserHomeScreen(), finish: true);
            }



            showToast(
                message: "Welcome Back",
                state: ToastStates.SUCCESS,
                duartion: 1);
          }).catchError((error) {
            showToast(
                message: "Error", state: ToastStates.SUCCESS, duartion: 1);
          });
        }
        if (state is LoginGoogleSuccessState) {
          CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
            AppNavigator.customNavigator(
                context: context, screen: const AuthUserHomeScreen(), finish: true);
            showToast(
                message: "Welcome back Using Google!",
                state: ToastStates.SUCCESS,
                duartion: 1);
          }).catchError((error) {
            showToast(
                message: "Error", state: ToastStates.SUCCESS, duartion: 1);
          });
        }
        if (state is LoginFacebookSuccessState) {
          CacheHelper.saveData(key: "uId", value: state.uId).then((value) {
            AppNavigator.customNavigator(
                context: context, screen: const AuthUserHomeScreen(), finish: true);
            showToast(
                message: "Welcome back Using Facebook!",
                state: ToastStates.SUCCESS,
                duartion: 1);
          }).catchError((error) {
            showToast(
                message: "Error", state: ToastStates.SUCCESS, duartion: 1);
          });
        }
        if (state is LoginErrorState) {
          showToast(
              message: state.error.substring(35).toUpperCase(),
              state: ToastStates.ERROR,
              duartion: 1);
        }
      },
      builder: (context, state) {
        var loginCubit = LoginCubit.get(context);
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(elevation: 0, actions: [
              TextButton(
                  onPressed: () {
                    CacheHelper.saveData(key: "uId", value: "UnAuthUser");
                    AppNavigator.customNavigator(
                        context: context,
                        screen: UnAuthUserHomeScreen(),
                        finish: true);
                  },
                  child: Text(
                    "Continue as Guest!",
                    style: TextStyle(
                        fontFamily: 'PlaypenSans', color: Colors.deepOrange),
                  ))
            ]),
            body: Padding(
              padding: const EdgeInsets.fromLTRB(40, 0, 40, 8),
              child: Center(
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        Lottie.network(
                            'https://lottie.host/b5ff933e-565c-4e21-b615-52d0c521bd32/TOYLQ0FlKF.json',
                            height: 160),
                        Align(
                            alignment: Alignment.centerLeft,
                            child: Text("Login",
                                style: const TextStyle(fontSize: 28))),
                        const SizedBox(
                          height: 8,
                        ),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter your email";
                            } else {
                              return null;
                            }
                          },
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintStyle: const TextStyle(
                                height: 1,
                                fontSize: 16,
                                fontFamily: 'PlaypenSans'),
                            hintText: "Email",
                            prefixIcon: const Icon(Icons.person),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextFormField(
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return "Please enter your password";
                            } else {
                              return null;
                            }
                          },
                          controller: passwordController,
                          keyboardType: TextInputType.text,
                          obscureText: loginCubit.isPassword,
                          decoration: InputDecoration(
                              hintText: "Password",
                              hintStyle: const TextStyle(
                                height: 1,
                                fontSize: 16,
                                fontFamily: 'PlaypenSans',
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 20,
                              ),
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    loginCubit.changePasswordVisibility();
                                  },
                                  icon: Icon(loginCubit.suffix)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15))),
                        ),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: TextButton(
                                onPressed: () {
                                  AppNavigator.customNavigator(
                                      context: context,
                                      screen: ForgetPasswordView(),
                                      finish: false);
                                },
                                child: Text(
                                  "Forget password!",
                                  style: const TextStyle(
                                      fontFamily: 'PlaypenSans',
                                      color: Colors.deepOrange),
                                ))),
                        ConditionalBuilder(
                            condition: state is! LoginLoadingState,
                            builder: (context) => ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                    shadowColor: Colors.transparent,
                                    elevation: 0,
                                  ),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      loginCubit.userLogin(
                                          email: emailController.text,
                                          password: passwordController.text);
                                    }
                                  },
                                  child: Container(
                                    height: 45,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.blue[400],
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Login",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontFamily: 'PlaypenSans'),
                                      ),
                                    ),
                                  ),
                                ),
                            fallback: (context) => const Padding(
                                  padding: EdgeInsets.only(top: 8.0),
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  )),
                                )),
                        const SizedBox(height: 10),
                        const Row(children: [
                          Expanded(
                              child: Divider(
                            thickness: 2,
                          )),
                          Text("OR", style: TextStyle(fontSize: 12)),
                          Expanded(
                              child: Divider(
                            thickness: 2,
                          )),
                        ]),
                        const SizedBox(height: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 3),
                            MaterialButton(
                              elevation: 0,
                              minWidth: double.maxFinite,
                              height: 50,
                              onPressed: () {
                                loginCubit.signInWithGoogle();
                              },
                              color: Colors.teal.shade500,
                              textColor: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.google),
                                  SizedBox(width: 10),
                                  Text("Sign in with Google",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                            MaterialButton(
                              elevation: 0,
                              minWidth: double.maxFinite,
                              height: 50,
                              onPressed: () {
                                loginCubit.signInWithGoogle();
                              },
                              color: Colors.blue.shade500,
                              textColor: Colors.white,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(FontAwesomeIcons.facebook),
                                  SizedBox(width: 10),
                                  Text("Sign in with Facebook",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 17)),
                                ],
                              ),
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?",
                                style: const TextStyle(fontSize: 15)),
                            TextButton(
                              onPressed: () {
                                AppNavigator.customNavigator(
                                    context: context,
                                    screen: RegisterView(),
                                    finish: false);
                              },
                              child: Text(
                                "Register",
                                style: const TextStyle(
                                    fontFamily: 'PlaypenSans',
                                    fontSize: 15,
                                    color: Colors.deepOrange),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
