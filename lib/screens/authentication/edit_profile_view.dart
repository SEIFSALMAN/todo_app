import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../shared/components/navigator.dart';
import 'login_view.dart';

class EditProfileView extends StatelessWidget {
  var formKey = GlobalKey<FormState>();

  TextEditingController userController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(elevation: 0, actions: [
        TextButton(
            onPressed: () {
              // if (formKey.currentState!.validate()) {
              //   AppNavigator.customNavigator(
              //       context: context, screen: HomeLayout(), finish: true);
              // }
            },
            child: TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Done",
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                      fontFamily: 'PlaypenSans'),
                )))
      ]),
      body: Padding(
        padding: EdgeInsets.fromLTRB(40,40, 40, 10),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Lottie.network(
                    'https://lottie.host/748d3ea4-27bb-4f04-bfb6-ee5745769fb7/cCB4BvWSps.json',
                    height: 120),
                SizedBox(
                  height: 30,
                ),
                Text("Edit Profile", style: TextStyle(fontSize: 26)),
                SizedBox(
                  height: 20,
                ),

                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Enter your username";
                    } else {
                      return null;
                    }
                  },
                  controller: userController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        height: 1, fontSize: 15, fontFamily: 'PlaypenSans'),
                    hintText: "Username",
                    prefixIcon: Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 13),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return  "Enter your email";
                    } else {
                      return null;
                    }
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        height: 1, fontSize: 15, fontFamily: 'PlaypenSans'),
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 13),
                TextFormField(
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return  "Enter your password";
                    } else {
                      return null;
                    }
                  },
                  controller: passwordController,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintStyle: TextStyle(
                        height: 1, fontSize: 15, fontFamily: 'PlaypenSans'),
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                ),
                SizedBox(height: 15,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
