import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormCard extends StatelessWidget {
  final String validation;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  FormCard({
    required this.emailController,
    required this.passwordController,
    required this.validation,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 495.h, // Using ScreenUtil().setHeight(495) is replaced with 495.h
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
            8.0.r), // BorderRadius.circular() with .r for responsive values
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, 15.0.h), // Height is responsive with .h
            blurRadius:
                15.0.r, // BoxShadow blur radius with .r for responsive values
          ),
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0.0, -10.0.h), // Offset is responsive with .h
            blurRadius:
                10.0.r, // BoxShadow blur radius with .r for responsive values
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
            left: 16.0.w,
            right: 16.0.w,
            top: 16.0.h), // Padding is responsive with .w and .h
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                fontSize: 45.sp, // Font size is responsive with .sp
                fontFamily: "Poppins-Bold",
                letterSpacing: .6,
              ),
            ),
            SizedBox(
              height: 15.h, // Height is responsive with .h
            ),
            Text(
              "Email",
              style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 21.sp, // Font size is responsive with .sp
              ),
            ),
            TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0.sp), // Font size is responsive with .sp
              ),
              obscureText: false,
              validator: (value) => value!.isEmpty ? validation : null,
            ),
            SizedBox(
              height: 20.h, // Height is responsive with .h
            ),
            Text(
              "Password",
              style: TextStyle(
                fontFamily: "Poppins-Medium",
                fontSize: 21.sp, // Font size is responsive with .sp
              ),
            ),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
                hintText: "Password",
                hintStyle: TextStyle(
                    color: Colors.grey,
                    fontSize: 12.0.sp), // Font size is responsive with .sp
              ),
              obscureText: true,
              validator: (value) => value!.isEmpty ? validation : null,
            ),
            SizedBox(
              height: 25.h, // Height is responsive with .h
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color.fromARGB(255, 7, 4, 80),
                    fontFamily: "Poppins-Medium",
                    fontSize: 28.sp, // Font size is responsive with .sp
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
