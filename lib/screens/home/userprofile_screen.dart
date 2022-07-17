import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../constants.dart';
import '../../model/user_model.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  //Controllers
  final firstNameEditingController = TextEditingController();
  final secondNameEditingController = TextEditingController();

  // string for displaying the error Message
  String? errorMessage;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // first name field
    final firstNameField = TextFormField(
      autofocus: false,
      controller: firstNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        RegExp regex = RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("Field cannot be empty");
        }
        if (!regex.hasMatch(value)) {
          return ("Enter Valid name(Min. 3 Character)");
        }
        return null;
      },
      onSaved: (value) {
        firstNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: loggedInUser.firstName,
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.0),
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(colorBase),
              backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              if (firstNameEditingController.text == '' ||
                  firstNameEditingController.text == ' ') {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Empty Field',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: const Text(
                      'Field cannot be empty',
                      style: TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: colorAccent,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              } else {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Update First Name',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to change your First Name to ${firstNameEditingController.text}?',
                      style: const TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: colorAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          updateFirstName();
                          Navigator.pop(context, 'Update');
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              }
            },
            child: const Text('Update'),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimary),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimary),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );

    // second name field
    final secondNameField = TextFormField(
      autofocus: false,
      controller: secondNameEditingController,
      keyboardType: TextInputType.name,
      validator: (value) {
        if (value!.isEmpty) {
          return ("Field cannot be empty");
        }
        return null;
      },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.person),
        contentPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: loggedInUser.secondName,
        suffixIcon: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 9.0),
          child: ElevatedButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(colorBase),
              backgroundColor: MaterialStateProperty.all<Color>(colorPrimary),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            onPressed: () {
              if (secondNameEditingController.text == '' ||
                  secondNameEditingController.text == ' ') {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Empty Field',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: const Text(
                      'Field cannot be empty',
                      style: TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Close'),
                        child: const Text(
                          'Close',
                          style: TextStyle(
                            color: colorAccent,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              } else {
                showDialog<String>(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text(
                      'Update Second Name',
                      style: TextStyle(
                        fontSize: 25,
                        color: colorPrimary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    content: Text(
                      'Are you sure you want to change your Second Name to ${secondNameEditingController.text}?',
                      style: const TextStyle(
                        color: colorPrimaryDark,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(
                            color: colorAccent,
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          updateSecondName();
                          Navigator.pop(context, 'Update');
                        },
                        child: const Text(
                          'Update',
                          style: TextStyle(
                            color: colorPrimary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    backgroundColor: colorBase,
                  ),
                );
              }
            },
            child: const Text('Update'),
          ),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimary),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(width: 3, color: colorPrimary),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );

    //sign out button
    final signOutButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorBase,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signOut();
        },
        child: const Text(
          "Sign Out",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: colorAccent, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //delete button
    final deleteButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: colorAccent,
      child: MaterialButton(
        padding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () => showDialog<String>(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) => AlertDialog(
            title: const Text(
              'Delete Item',
              style: TextStyle(
                fontSize: 25,
                color: colorAccent,
                fontWeight: FontWeight.w700,
              ),
            ),
            content: const Text(
              'Are you sure you want to delete account?',
              style: TextStyle(
                color: colorPrimaryDark,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () => Navigator.pop(context, 'Cancel'),
                child: const Text(
                  'Cancel',
                  style: TextStyle(
                    color: colorPrimary,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  deleteAccount();
                },
                child: const Text(
                  'Delete',
                  style: TextStyle(
                    color: colorAccent,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
            backgroundColor: colorBase,
          ),
        ),
        child: const Text(
          "Delete Account",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18, color: colorBase, fontWeight: FontWeight.bold),
        ),
      ),
    );

    //Profile name field
    final profileName = LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Admin') {
        return const Text(
          "Your Admin Profile",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: colorPrimaryDark),
        );
      } else {
        return const Text(
          "Your Profile",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: colorPrimaryDark),
        );
      }
    });

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: colorWhite,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: colorAccent),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
              child: SingleChildScrollView(
            child: Container(
                color: colorWhite,
                child: Padding(
                  padding: const EdgeInsets.all(36.0),
                  child: Form(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                            height: 100,
                            child: Image.asset(
                              "images/Logo/Profile.png",
                              fit: BoxFit.contain,
                            )),
                        profileName,
                        const SizedBox(height: 3),
                        Text(
                          '${loggedInUser.email}',
                          style: const TextStyle(
                              fontSize: 18, color: colorPrimary),
                        ),
                        const SizedBox(height: 20),
                        firstNameField,
                        const SizedBox(height: 20),
                        secondNameField,
                        const SizedBox(height: 15),
                        signOutButton,
                        const SizedBox(height: 15),
                        deleteButton,
                        const SizedBox(height: 45),
                      ],
                    ),
                  ),
                )),
          )),
        ));
  }

  updateFirstName() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore.collection("users").doc(user.uid).update({
      'firstName': firstNameEditingController.text,
    });
    Fluttertoast.showToast(msg: "Profile Updated");
  }

  updateSecondName() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore.collection("users").doc(user.uid).update({
      'secondName': secondNameEditingController.text,
    });
    Fluttertoast.showToast(msg: "Profile Updated");
  }

  deleteAccount() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore.collection("users").doc(user.uid).delete();
    user.delete();
    Fluttertoast.showToast(msg: "Account Deleted");

    FirebaseAuth.instance.signOut();
    Navigator.of(context).pop();
  }

  signOut() {
    FirebaseAuth.instance.signOut();
    Fluttertoast.showToast(msg: "Signed Out");
    Navigator.of(context).pop();
  }
}
