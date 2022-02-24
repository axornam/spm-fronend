import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:logger/logger.dart';
import 'package:studentprojectmanager/util/router.dart';
import 'package:studentprojectmanager/views/auth/login.dart';
import 'package:studentprojectmanager/views/auth/widgets/custom_shape.dart';
import 'package:studentprojectmanager/views/auth/widgets/responsive_ui.dart';
import 'package:studentprojectmanager/views/auth/widgets/textformfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';

import '../../util/api.dart';
import '../../util/functions.dart';

class AddProjectScreen extends StatefulWidget {
  @override
  _AddProjectScreenState createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  late double _height;
  late double _width;
  late double _pixelRatio;
  late bool _large;
  late bool _medium;

  //
  final ImagePicker imgPicker = ImagePicker();
  File? image;
  late Image img;

  // text field controllers
  TextEditingController projectNameController = TextEditingController();
  TextEditingController authorNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController departmentController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController introController = TextEditingController();
  TextEditingController abstractController = TextEditingController();
  TextEditingController categoryController = TextEditingController();

  // utils
  Api api = Api();
  Logger logger = Logger();

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    _pixelRatio = MediaQuery.of(context).devicePixelRatio;
    _large = ResponsiveWidget.isScreenLarge(_width, _pixelRatio);
    _medium = ResponsiveWidget.isScreenMedium(_width, _pixelRatio);

    return Material(
      child: Scaffold(
        body: Container(
          height: _height,
          width: _width,
          margin: EdgeInsets.only(bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                // Opacity(
                //     opacity: 0.88,
                //     child: AppBar(backgroundColor: Colors.deepPurpleAccent)),
                clipShape(),
                form(),
                // acceptTermsTextRow(),
                SizedBox(
                  height: _height / 35,
                ),
                button(),
                // infoTextRow(),
                // socialIconsRow(),
                // signInTextRow(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget clipShape() {
  //   return Stack(
  //     children: <Widget>[
  //       Opacity(
  //         opacity: 0.75,
  //         child: ClipPath(
  //           clipper: CustomShapeClipper(),
  //           child: Container(
  //             height: _large
  //                 ? _height / 8
  //                 : (_medium ? _height / 7 : _height / 6.5),
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: [Colors.blue, Colors.pinkAccent],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Opacity(
  //         opacity: 0.5,
  //         child: ClipPath(
  //           clipper: CustomShapeClipper2(),
  //           child: Container(
  //             height: _large
  //                 ? _height / 12
  //                 : (_medium ? _height / 11 : _height / 10),
  //             decoration: BoxDecoration(
  //               gradient: LinearGradient(
  //                 colors: [Colors.blue, Colors.pinkAccent],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ),
  //       Center(
  //           child:
  //               Column(mainAxisAlignment: MainAxisAlignment.center, children: [
  //         ElevatedButton(
  //           style: ElevatedButton.styleFrom(
  //             primary: Colors.red, // background
  //             onPrimary: Colors.yellow, // foreground
  //           ),
  //           onPressed: () {},
  //           child: Text('Upload your document'),
  //         ),
  //       ])),
  //       Positioned(
  //         top: _height / 8,
  //         left: _width / 1.75,
  //         child: Container(
  //           alignment: Alignment.center,
  //           height: _height / 23,
  //           padding: EdgeInsets.all(5),
  //           // decoration: BoxDecorationon(
  //           //   shape: BoxShape.circle,
  //           //   color:  Colors.orange[100],
  //           // ),
  //           child: GestureDetector(
  //               onTap: () {
  //                 print('Adding photo');
  //               },
  //               child: Icon(
  //                 Icons.add_a_photo,
  //                 size: _large ? 22 : (_medium ? 15 : 13),
  //               )),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  Widget clipShape() {
    return Stack(
      children: <Widget>[
        Opacity(
          opacity: 0.75,
          child: ClipPath(
            clipper: CustomShapeClipper(),
            child: Container(
              height: _large
                  ? _height / 8
                  : (_medium ? _height / 7 : _height / 6.5),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Opacity(
          opacity: 0.5,
          child: ClipPath(
            clipper: CustomShapeClipper2(),
            child: Container(
              height: _large
                  ? _height / 12
                  : (_medium ? _height / 11 : _height / 10),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue, Colors.pinkAccent],
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 64.0),
          child: Container(
            height: _height / 5.5,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    spreadRadius: 0.0,
                    color: Colors.black26,
                    offset: Offset(1.0, 10.0),
                    blurRadius: 20.0),
              ],
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: this.image != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100.0),
                    child: Image.file(
                      this.image!,
                      fit: BoxFit.cover,
                    ),
                  )
                : null,
            // child: GestureDetector(
            //     onTap: () async  {
            //       final image = await imgPicker.pickImage(source: ImageSource.gallery);
            //       if(image == null){
            //
            //       }
            //
            //       Functions.showToast("Adding Photo");
            //     },
            //     child: Icon(
            //       Icons.add_a_photo,
            //       size: _large ? 40 : (_medium ? 33 : 31),
            //       color: Colors.orange[200],
            //     )),
          ),
        ),
        Positioned(
          top: _height / 6,
          left: _width / 1.65,
          child: Container(
            alignment: Alignment.center,
            height: _height / 13,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.blue,
            ),
            child: GestureDetector(
                onTap: () async {
                  final imageXfile =
                      await imgPicker.pickImage(source: ImageSource.gallery);
                  if (imageXfile == null) return;

                  final tempImage = File(imageXfile.path);
                  setState(() {
                    this.image = tempImage;
                    // final path = imageXfile.path;
                    // final bytes = await File(path).readAsBytes();
                    // this.img = Image.decodeImage(bytes);
                  });

                  Functions.showToast("Adding Photo");
                  logger.d(this.image);
                },
                child: Icon(
                  Icons.add_a_photo,
                  size: _large ? 52 : (_medium ? 35 : 33),
                )),
          ),
        ),
      ],
    );
  }

  Widget form() {
    return Container(
      margin: EdgeInsets.only(
          left: _width / 12.0, right: _width / 12.0, top: _height / 20.0),
      child: Form(
        child: Column(
          children: <Widget>[
            projectNameTextFormField(),
            SizedBox(height: _height / 130.0),
            authorNameTextFormField(),
            SizedBox(height: _height / 130.0),
            emailTextFormField(),
            SizedBox(height: _height / 130.0),
            departmentTextFormField(),
            SizedBox(height: _height / 130.0),
            descriptionTextFormField(),
            SizedBox(height: _height / 130.0),
            introTextFormField(),
            SizedBox(height: _height / 130.0),
            abstractTextFormField(),
            SizedBox(height: _height / 130.0),
            categoryTextFormField(),
            SizedBox(height: _height / 130.0),
            // file upload field
            SizedBox(height: _height / 130.0),
          ],
        ),
      ),
    );
  }

  Widget projectNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Project Name",
      textEditingController: projectNameController,
    );
  }

  Widget authorNameTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.person,
      hint: "Authors",
      textEditingController: authorNameController,
    );
  }

  Widget emailTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.emailAddress,
      icon: Icons.email,
      hint: "Email",
      textEditingController: emailController,
    );
  }

  Widget departmentTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.text,
      icon: Icons.house,
      hint: "Department",
      textEditingController: departmentController,
    );
  }

  Widget phoneTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Mobile Number",
      textEditingController: phoneController,
    );
  }

  Widget descriptionTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Description",
      textEditingController: descriptionController,
    );
  }

  Widget introTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Introduction",
      textEditingController: introController,
    );
  }

  Widget abstractTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Abstract",
      textEditingController: abstractController,
    );
  }

  Widget categoryTextFormField() {
    return CustomTextField(
      keyboardType: TextInputType.number,
      icon: Icons.phone,
      hint: "Category",
      textEditingController: categoryController,
    );
  }

  // Widget acceptTermsTextRow() {
  //   return Container(
  //     margin: EdgeInsets.only(top: _height / 100.0),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.center,
  //       children: <Widget>[
  //         Checkbox(
  //             activeColor: Colors.blue[200],
  //             value: checkBoxValue,
  //             onChanged: (bool? newValue) {
  //               setState(() {
  //                 checkBoxValue = newValue!;
  //               });
  //             }),
  //         Text(
  //           "I accept all terms and conditions",
  //           style: TextStyle(
  //               fontWeight: FontWeight.w400,
  //               fontSize: _large ? 12 : (_medium ? 11 : 10)),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget button() {
    return RaisedButton(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      onPressed: () async {
        Functions.showToast("submitting projects`");

        Map<String, String> form = {
          "name": projectNameController.text + " " + authorNameController.text,
          "author": emailController.text,
          "department": departmentController.text,
          "description": descriptionController.text,
          'introduction': introController.text,
          'abstract': abstractController.text,
          'category': categoryController.text,
        };

        // logger.i(form);
        var res =
            await api.uploadProject(form, this.image?.path, this.image?.path);
        // logger.i(res);
        //
        // switch to home page on success
        // if (res?['message'] == 'success') {
        //   // store user data to shared_preferences / local storage
        //   // on local storage true - redirect to homepage
        //   Functions.showToast('Registration Successful');
        //   MyRouter.pushPageReplacement(context, SignInPage());
        // } else if (res?['message'] == 'failed') {
        //   Functions.showToast('Error, Registration Failed');
        // } else if (res?['message'] == 'error') {
        //   //
        //   Functions.showToast('Server Error');
        // }
      },
      textColor: Colors.white,
      padding: EdgeInsets.all(0.0),
      child: Container(
        alignment: Alignment.center,
//        height: _height / 20,
        width: _large ? _width / 4 : (_medium ? _width / 3.75 : _width / 3.5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20.0)),
          gradient: LinearGradient(
            colors: <Color>[Colors.blue, Colors.pinkAccent],
          ),
        ),
        padding: const EdgeInsets.all(12.0),
        child: Text(
          'ADD PROJECT+',
          style: TextStyle(fontSize: _large ? 14 : (_medium ? 12 : 10)),
        ),
      ),
    );
  }
//
//   Widget infoTextRow() {
//     return Container(
//       margin: EdgeInsets.only(top: _height / 40.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             "Or create using social media",
//             style: TextStyle(
//                 fontWeight: FontWeight.w400,
//                 fontSize: _large ? 12 : (_medium ? 11 : 10)),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget socialIconsRow() {
//     return Container(
//       margin: EdgeInsets.only(top: _height / 80.0),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           CircleAvatar(
//             radius: 15,
//             backgroundImage: AssetImage("assets/images/googlelogo.png"),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           CircleAvatar(
//             radius: 15,
//             backgroundImage: AssetImage("assets/images/fblogo.jpg"),
//           ),
//           SizedBox(
//             width: 20,
//           ),
//           CircleAvatar(
//             radius: 15,
//             backgroundImage: AssetImage("assets/images/twitterlogo.jpg"),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget signInTextRow() {
//     return Container(
//       margin: EdgeInsets.only(top: _height / 20.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           Text(
//             "Already have an account?",
//             style: TextStyle(fontWeight: FontWeight.w400),
//           ),
//           SizedBox(
//             width: 5,
//           ),
//           GestureDetector(
//             onTap: () {
//               // Navigator.of(context).pop(SIGN_IN);
//               MyRouter.pushPageReplacement(context, AddProjectScreen());
//               print("Routing to Sign up screen");
//             },
//             child: Text(
//               "Sign in",
//               style: TextStyle(
//                   fontWeight: FontWeight.w800,
//                   color: Colors.orange[200],
//                   fontSize: 19),
//             ),
//           )
//         ],
//       ),
//     );
//   }
}
