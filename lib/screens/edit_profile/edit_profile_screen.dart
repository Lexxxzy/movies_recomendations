import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:movies_recomendations/components/button.dart';
import 'package:movies_recomendations/screens/authentication/components/my_snack_bar.dart';
import 'package:provider/provider.dart';
import '../../components/backButton.dart';
import '../../constants.dart';
import '../../providers/user.dart';
import 'package:image_picker/image_picker.dart';

import '../authentication/components/form_error.dart';
import '../authentication/components/rounded_input_field.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  static const routeName = '/edit_profile';

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  File? selectedImage;

  List<String?> errors = [];
  String? nickname;
  String? realname;
  final bool _isloading = false;

  GlobalKey formkey = GlobalKey<FormState>();

  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final User userData = Provider.of<User>(context).user!;

    return Scaffold(
        backgroundColor: kBackgroundColor,
        body: Center(
          child: SafeArea(
            child: SingleChildScrollView(
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: buildEditProfileBody(context, userData),
              ),
            ),
          ),
        ));
  }

  Column buildEditProfileBody(BuildContext context, User userData) {
    return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(kDefaultPadding),
                    child: Row(
                      children: [
                        backButton(
                          buttonForm: buttonForms.square,
                          iconSize: 15,
                          size: 30,
                        ),
                        SizedBox(
                          width: kDefaultPadding / 2,
                        ),
                        const Text(
                          'Edit profile',
                          style: TextStyle(
                            color: kTextColor,
                            fontFamily: 'SFProDisplay',
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      ],
                    ),
                  ),
                  buildProfileBody(context, userData),
                ],
              );
  }

  Container buildProfileBody(BuildContext context, User userData) {
    return Container(
      width: MediaQuery.of(context).size.width,
      margin: const EdgeInsets.symmetric(horizontal: kDefaultPadding * 2),
      //color: Colors.white10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              getImage();
            },
            child: CircleAvatar(
              backgroundImage: selectedImage == null
                  ? NetworkImage(userData.avatar!)
                  : AssetImage(selectedImage!.path) as ImageProvider,
              foregroundColor: Colors.black38,
              child: Stack(children: [
                Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.black54,
                  ),
                ),
                const Center(
                  child: Icon(
                    CupertinoIcons.photo_camera_solid,
                    size: 50,
                    color: Colors.white,
                  ),
                ),
              ]),
              radius: 80,
              backgroundColor: Colors.transparent,
            ),
          ),
          const SizedBox(height: kDefaultPadding),
          Form(
            key: formkey,
            child: Column(
              children: [
                RoundedInputField(
                  color: Colors.black12,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kEmailNullError);
                    } else if (emailValidatorRegExp.hasMatch(value)) {
                      removeError(error: kInvalidEmailError);
                    }
                    realname = value;
                  },
                  validFunc: (value) {
                    if (value.isEmpty) {
                      addError(error: kEmailNullError);
                      return "";
                    } else if (!emailValidatorRegExp.hasMatch(value)) {
                      addError(error: kInvalidEmailError);
                      return "";
                    }
                    return null;
                  },
                  hintText: userData.name!,
                  icon: CupertinoIcons.person,
                  ctx: context,
                ),
                RoundedInputField(
                  color: Colors.black12,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      removeError(error: kEmailNullError);
                    } else if (emailValidatorRegExp.hasMatch(value)) {
                      removeError(error: kInvalidEmailError);
                    }
                    nickname = value;
                  },
                  validFunc: (value) {
                    if (value.isEmpty) {
                      addError(error: kEmailNullError);
                      return "";
                    } else if (!emailValidatorRegExp.hasMatch(value)) {
                      addError(error: kInvalidEmailError);
                      return "";
                    }
                    return null;
                  },
                  hintText: userData.nickName!,
                  icon: CupertinoIcons.person_circle_fill,
                  ctx: context,
                ),
                buildButtonsAndErrors(context, userData),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Column buildButtonsAndErrors(BuildContext context, userData) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: kDefaultPadding),
          child: Row(
            children: [
              myCustomButton(
                content: 'Cancel',
                onPress: () {
                  Navigator.of(context).maybePop();
                },
                width: MediaQuery.of(context).size.width / 13,
                height: 15,
                fontSize: 14,
              ),
              SizedBox(
                width: kDefaultPadding,
              ),
              _isloading == false
                  ? myCustomButton(
                      content: 'Update',
                      onPress: () {
                        try {
                          userData.updateNameAndNick(
                              realname, nickname, context);
                          if (selectedImage != null) {
                            userData.uploadImage(selectedImage, context);
                          }

                        
                        } on Exception catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const mySnackBar(
                                    message: 'Some Error Occured',
                                    isError: true)
                                .build(context),
                          );
                        }
                      },
                      mainColor: kMainColor,
                      width: MediaQuery.of(context).size.width / 14,
                      height: 15,
                      fontSize: 14,
                    )
                  : const CupertinoActivityIndicator(
                      radius: 12,
                      color: kMainColor,
                    ),
            ],
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        FormError(errors: errors),
      ],
    );
  }

  Future getImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      setState(() {
        selectedImage = File(pickedImage!.path);
      });
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          const mySnackBar(message: 'Something went wrong', isError: true)
              .build(context));
    }
  }
}
