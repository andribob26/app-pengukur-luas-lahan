import 'package:flutter/material.dart';
import 'package:flutter_application_1/ui/widget/buttonCostumWidget.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue.shade600,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          centerTitle: true,
        ),
        body: Container(
          padding: EdgeInsets.fromLTRB(35, 0, 35, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Selamat Datang Kembali',
                      style:
                          TextStyle(fontSize: 35, fontWeight: FontWeight.w600, color: Colors.white,)
                    ),
                    Text(
                      'Masuk akun anda untuk melanjutkan',
                      style: TextStyle(fontSize: 25, color: Colors.white),
                    ),
                  ],
                ),
              ),
              // SizedBox(
              //   height: 45,
              //   child: Text(
              //     "Login",
              //     style: TextStyle(
              //         fontSize: 25, fontWeight: FontWeight.w600),
              //   ),
              // ),
              // TextFieldCostum(
              //   obscureText: false,
              //   hintText: "Email",
              // ),
              // SizedBox(height: 25),
              // TextFieldCostum(
              //   obscureText: true,
              //   hintText: "Password",
              // ),
              // SizedBox(
              //   height: 35,
              // ),
              Column(
                children: [
                  ButtonCostum(
                    // icon: Icons.facebook,
                    text: "Facebook",
                    color: Colors.blue.shade800,
                    textColor: Colors.white,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  ButtonCostum(
                    // icon: Icons.facebook,
                    text: "Google",
                    color: Colors.white,
                    textColor: Colors.black,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}
