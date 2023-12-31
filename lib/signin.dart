import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_map_flutter_works/word_maker.dart';
import 'chain-work/activity.dart';
import 'CustomizedIcons.dart';
import 'GameInputForm.dart';
import 'SocialMediaIcons.dart';
import 'form.dart';
import 'map.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_map_flutter_works/finwallet/home-page.dart';
import 'router.dart';
import 'MainScreen.dart';

class Signin extends StatefulWidget {
  @override
  _SigninState createState() => new _SigninState();
}

class _SigninState extends State<Signin> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  //google sign
  /// GoogleSignIn googleauth = new GoogleSignIn();
  final formkey = new GlobalKey<FormState>();
  checkFields() {
    final form = formkey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  LoginUser() {
    /*if (checkFields()){
      FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)
          .then((user){
        print("signed in as ${user.uid}");
        Navigator.push(context, MaterialPageRoute(builder: (context)=>home()));
      }).catchError((e){
        print(e);
      });
    }*/

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => MainScreen(
          initialArguments: {'username': '', 'password': ''},
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
        width: 16.0,
        height: 16.0,
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
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    ScreenUtil.instance =
        ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 81.0),
                child: Container(
                  //height: 280, child: Image.asset("assets/super-girl-1.png")),
                  height: 250,
                  width: 95,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: AssetImage("assets/stellar.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Container(
                height: 180,
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
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 80.0),
              child: Column(
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text("MAGNATE",
                          style: TextStyle(
                            fontFamily: "Poppins-Bold",
                            fontSize: ScreenUtil.getInstance().setSp(30),
                            letterSpacing: .6,
                            fontWeight: FontWeight.bold,
                            decoration: TextDecoration.underline,
                          )),
                      SizedBox(
                        height: ScreenUtil.getInstance().setHeight(10),
                      ),
                      Text("Navigate to the future of finance",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(28),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(275),
                  ),
                  Form(
                      key: formkey,
                      child: FormCard(
                        validation: 'required',
                        emailController: emailController,
                        passwordController: passwordController,
                      )),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(20)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("Remember me",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: "Poppins-Medium"))
                        ],
                      ),
                      InkWell(
                        onTap: LoginUser,
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color.fromARGB(255, 13, 19, 144),
                                Color.fromARGB(255, 68, 71, 30)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
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
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Social Login",
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: "Poppins-Medium")),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      /*
                      Icon(
                        FontAwesomeIcons.instagram,
                        size: 40,
                        color: Color.fromARGB(255, 197, 86, 152),
                      ),
                      
                      FloatingActionButton(
                        onPressed: () {
                          setState(() {
                            //Also add logic to play
                          });
                        },
                        child: Icon(
                          FontAwesomeIcons.facebook,
                          size: 40,
                          color: Color.fromARGB(255, 7, 66, 202),
                        ),
                      ),
                      Icon(
                        FontAwesomeIcons.facebook,
                        size: 40,
                        color: Color.fromARGB(255, 7, 66, 202),
                      ),
                      Icon(FontAwesomeIcons.whatsapp,
                          size: 40, color: Color.fromARGB(255, 18, 232, 121)),
                      */
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
                    height: ScreenUtil.getInstance().setHeight(30),
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
                                fontSize: 18,
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
    );
  }
}
