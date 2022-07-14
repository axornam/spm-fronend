import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:studentprojectmanager/util/router.dart';
import 'package:studentprojectmanager/views/auth/login.dart';

import '../util/api.dart';

class DescriptionTextWidget extends StatefulWidget {
  final String text;

  DescriptionTextWidget({required this.text});

  @override
  _DescriptionTextWidgetState createState() => _DescriptionTextWidgetState();
}

class _DescriptionTextWidgetState extends State<DescriptionTextWidget> {
  late String firstHalf;
  late String secondHalf;

  bool flag = true;

  @override
  void initState() {
    super.initState();

    if (widget.text.length > 300) {
      firstHalf = widget.text.substring(0, 300);
      secondHalf = widget.text.substring(300, widget.text.length);
    } else {
      firstHalf = widget.text;
      secondHalf = '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? Text(
              '${flag ? (firstHalf) : (firstHalf + secondHalf)}'
                  .replaceAll(r'\n', '\n')
                  .replaceAll(r'\r', '')
                  .replaceAll(r"\'", "'"),
              style: TextStyle(
                fontSize: 16.0,
                color: Theme.of(context).textTheme.caption!.color,
              ),
            )
          : Column(
              children: <Widget>[
                Text(
                  '${flag ? (firstHalf + '...') : (firstHalf + secondHalf)}'
                      .replaceAll(r'\n', '\n\n')
                      .replaceAll(r'\r', '')
                      .replaceAll(r"\'", "'"),
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Theme.of(context).textTheme.caption!.color,
                  ),
                ),
                InkWell(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text(
                        flag ? 'show more' : 'show less',
                        style: TextStyle(color: Colors.blue),
                      ),
                    ],
                  ),
                  onTap: () async {
                    // TODO add authentication check
                    List? user = await Api().checkLogin();

                    if (user != null) {
                      setState(() {
                        flag = !flag;
                      });
                      return;
                    }

                    showDialog(
                      context: context,
                      builder: (_) {
                        return AlertDialog(
                          title: Text(
                            'Warning',
                          ),
                          content: Text(
                            'You are not Logged In',
                          ),
                          actions: <Widget>[
                            FlatButton(
                              textColor: Theme.of(context).accentColor,
                              onPressed: () =>
                                  MyRouter.pushPage(context, SignInPage()),
                              child: Text(
                                'Login',
                              ),
                            ),
                          ],
                        );
                      },
                    );

                    //
                  },
                ),
              ],
            ),
    );
  }
}
