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
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                  value: 'JohnDoe',
                ),
              ],
            )),
      ],
    );
  }
}

class ProfileRow extends StatefulWidget {
  final String titleName;
  String value;

  ProfileRow({
    Key? key,
    required this.titleName,
    required this.value,
  }) : super(key: key);

  @override
  _ProfileRowState createState() => _ProfileRowState();
}

class _ProfileRowState extends State<ProfileRow> {
  bool isEditing = false;
  late TextEditingController textEditingController;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController(text: widget.value);
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(
              widget.titleName,
              style: const TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          children: [
            if (isEditing) ...[
              Expanded(
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
                    // obscureText: widget.setobscureText ?? false,
                    controller: textEditingController,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(20),
                      prefixIcon: Icon(
                        Icons.cabin_outlined,
                        color: Colors.black,
                      ),
                      hintText: 'Enter your text',
                      hintStyle: TextStyle(color: Colors.black45),
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isEditing = false;
                    // Save the updated value
                    widget.value = textEditingController.text;
                  });
                },
                icon: const Icon(Icons.check),
              ),
            ] else ...[
              Text(
                widget.value,
                style: const TextStyle(fontSize: 18.0),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    isEditing = true;
                  });
                },
                icon: const Icon(Icons.edit),
              ),
            ],
          ],
        )
      ],
    );
  }
}
