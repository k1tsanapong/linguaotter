import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linguaotter/layouts/default.dart';

import '../components/login_text_box.dart';
import '../components/showSnackbar.dart';
import '../components/theme_app.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  User user = FirebaseAuth.instance.currentUser!;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    usernameController = TextEditingController(text: user.displayName);
    // emailController = TextEditingController(text: user.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String? fullNameInside = user.displayName;
    // String? emailInside = user.email;

    return NormalLayout(
      paddingHead: 60,
      head: [
        const Expanded(child: BackToTheFuture()),
        Container(
          width: MediaQuery.of(context).size.width / 1.5,
          alignment: AlignmentDirectional.center,
          child: const Text("Edit Profile",
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w800,
              )),
        ),
        Expanded(child: Container()),
      ],
      body: [
        Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                ProfileRow(
                  titleName: 'Username',
                  value: '${fullNameInside}',
                  textController: usernameController,
                ),
                const SizedBox(height: 20.0),
                // ProfileRow(
                //   titleName: 'Email',
                //   value: '${emailInside}',
                //   textController: emailController,
                // ),

                const SizedBox(height: 40.0),
                BoxButton(
                  textDisplay: 'Update',
                  widthButton: 2.0,
                  run: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text('Update Username'),
                          content: const Text(
                              'Are you sure you want to Update your Username?'),
                          actions: [
                            TextButton(
                              onPressed: () async {
                                print("""Testkim : 
                      
                      usernameController = ${usernameController.text.trim()}
                      emailController = ${emailController.text.trim()}

                      
                      """);

                                await user.updateDisplayName(
                                    usernameController.text.trim());
                                // await user.updateEmail(emailController.text.trim());
                                await user.reload();

                                await db
                                    .collection("users")
                                    .doc(user.uid)
                                    .update({
                                  "fullName": usernameController.text
                                      .trim(), // Full Name I will edit later
                                  // "email": emailController.text.trim(),
                                }).then((value) {
                                  print("Update user successful.");
                                  showSnackBar(
                                      context, "Update user successful.");
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      '/', (Route<dynamic> route) => false);
                                }).catchError((e) {
                                  print("""Error : 
                      
                      usernameController = ${usernameController.text.trim()}
                      emailController = ${emailController.text.trim()}

                      ${e} 
                      
                      """);
                                  showSnackBar(context,
                                      "db error"); // Displaying the usual firebase error message
                                });
                              },
                              child: const Text(
                                'Update',
                                style: TextStyle(
                                  // color: Colors.red,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('Cancel'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
              ],
            )),
      ],
    );
  }
}

class ProfileRow extends StatefulWidget {
  final String titleName;
  TextEditingController textController;

  String value;

  ProfileRow({
    Key? key,
    required this.titleName,
    required this.value,
    required this.textController,
  }) : super(key: key);

  @override
  _ProfileRowState createState() => _ProfileRowState();
}

class _ProfileRowState extends State<ProfileRow> {
  bool isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titleName,
          style: const TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isEditing) ...[
              Expanded(
                  flex: 4,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: ThemeApp.violetTheme,
                          width: 4.0,
                        ),
                      ),
                      child: TextFormField(
                        // obscureText: setobscureText ?? false,
                        controller: widget.textController,
                        style: const TextStyle(
                            color: Colors.black, fontSize: 18.0),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(20),
                        ),
                      ),
                    ),
                  )),
              IconButton(
                onPressed: () {


                  setState(() {
                    print("After Controller = ${widget.textController.text.trim()}");
                    isEditing = false;
                    // Save the updated value
                    widget.value = widget.textController.text.trim();
                  });
                },
                icon: const Icon(Icons.check),
              ),
            ] else ...[
              Expanded(
                flex: 4,
                child: Container(
                  margin: const EdgeInsets.only(
                      right: 20,
                      top: 20.0,
                      bottom: 20.0), // Adjust the margin as needed
                  child: Text(
                    widget.value.trim(),
                    style: const TextStyle(fontSize: 18.0),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  print(
                      "Before Controller = ${widget.textController.text.trim()}");

                  setState(() {
                    isEditing = true;
                  });
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ],
        ),
      ],
    );
  }
}
