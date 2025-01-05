import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:chain_wallet/word_maker.dart';
import 'chain-work/activity.dart';
import 'CustomizedIcons.dart';
import 'GameInputForm.dart';
import 'SocialMediaIcons.dart';
import 'form.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:chain_wallet/finwallet/home-page.dart';
import 'router.dart';
import 'MainScreen.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final formkey = GlobalKey<FormState>();

  checkFields() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  LoginUser() {
    String username = emailController.text;
    String password = passwordController.text;
    print('username in the signin.dart: $username');
    print('password in the signin.dart: $password');
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          initialArguments: {'username': username, 'password': password},
        ),
      ),
    );
  }

  bool _isSelected = false;

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0.w,
        height: 16.0.h,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Container(
          width: 120.w,
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize:
          Size(750, 1334), // Set the design size of the reference layout
      minTextAdapt: true, // Allow scaling of text sizes
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: true,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(top: 81.0.h),
                  child: Container(
                    height: 250.h,
                    width: 95.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/stellar.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Expanded(child: Container()),
                Container(
                  height: 180.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/dubai-skyline.png"),
                          fit: BoxFit.fitWidth)),
                )
              ],
            ),
            SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.only(left: 28.0.w, right: 28.0.w, top: 80.0.h),
                child: Column(
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text("MAGNATE",
                            style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: 30.sp,
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            )),
                        SizedBox(
                          height: 10.h,
                        ),
                        Text("Navigate to the future of finance",
                            style: TextStyle(
                                fontFamily: "Poppins-Bold",
                                fontSize: 28.sp,
                                letterSpacing: .6,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                    SizedBox(
                      height: 275.h,
                    ),
                    Form(
                        key: formkey,
                        child: FormCard(
                          validation: 'required',
                          emailController: emailController,
                          passwordController: passwordController,
                        )),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            SizedBox(
                              width: 12.0.w,
                            ),
                            GestureDetector(
                              onTap: _radio,
                              child: radioButton(_isSelected),
                            ),
                            SizedBox(
                              width: 8.0.w,
                            ),
                            Text("Remember me",
                                style: TextStyle(
                                    fontSize: 12.sp,
                                    fontFamily: "Poppins-Medium"))
                          ],
                        ),
                        InkWell(
                          onTap: LoginUser,
                          child: Container(
                            width: 330.w,
                            height: 100.h,
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  Color.fromARGB(255, 13, 19, 144),
                                  Color.fromARGB(255, 68, 71, 30)
                                ]),
                                borderRadius: BorderRadius.circular(6.0.r),
                                boxShadow: [
                                  BoxShadow(
                                      color: Color.fromARGB(255, 71, 92, 199)
                                          .withOpacity(.3),
                                      offset: Offset(0.0, 8.0),
                                      blurRadius: 8.0)
                                ]),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: LoginUser,
                                child: Center(
                                  child: Text("SIGNIN",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: "Poppins-Bold",
                                          fontSize: 18.sp,
                                          letterSpacing: 1.0)),
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        horizontalLine(),
                        Text("Social Login",
                            style: TextStyle(
                                fontSize: 16.sp, fontFamily: "Poppins-Medium")),
                        horizontalLine()
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SocialIcon(
                          colors: [
                            Color(0xFF102397),
                            Color(0xFF187adf),
                          ],
                          iconData: FontAwesomeIcons.facebook,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color.fromARGB(255, 128, 58, 175),
                            Color.fromARGB(255, 223, 225, 158),
                          ],
                          iconData: FontAwesomeIcons.instagram,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color.fromARGB(255, 19, 140, 226),
                            Color.fromARGB(255, 19, 140, 226),
                          ],
                          iconData: FontAwesomeIcons.twitter,
                          onPressed: () {},
                        ),
                        SocialIcon(
                          colors: [
                            Color.fromARGB(255, 62, 145, 219),
                            Color.fromARGB(255, 62, 145, 219),
                          ],
                          iconData: FontAwesomeIcons.linkedin,
                          onPressed: () {},
                        )
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "New User? ",
                          style: TextStyle(
                            fontFamily: "Poppins-Medium",
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            //Navigator.push(context, MaterialPageRoute(builder: (context)=> Siginup()));
                          },
                          child: Text("SignUp",
                              style: TextStyle(
                                  fontFamily: "Poppins-Medium",
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18.sp,
                                  color: Color.fromARGB(255, 3, 1, 35))),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
