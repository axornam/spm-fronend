import 'package:flutter/material.dart';
import 'package:studentprojectmanager/util/router.dart';
import 'package:studentprojectmanager/views/auth/signup.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Material(
      child: Container(
        height: height / 10,
        width: width,
        padding: EdgeInsets.only(left: 15, top: 25),
        decoration: BoxDecoration(
          gradient:
              LinearGradient(colors: [Colors.orange[200]!, Colors.pinkAccent]),
        ),
        child: Row(
          children: <Widget>[
            IconButton(
                icon: Icon(
                  Icons.arrow_back,
                ),
                onPressed: () {
                  print("pop");
                  // MyRouter.pushPageReplacement(context, SignUpScreen());
                  MyRouter.popPage(context);
                })
          ],
        ),
      ),
    );
  }
}
