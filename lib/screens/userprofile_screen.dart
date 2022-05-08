import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/user_model.dart';

class UserProfile extends StatefulWidget {
  UserProfile({Key? key}) : super(key: key);

  @override
  State<UserProfile> createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _formKey = GlobalKey<FormState>();

  //Controllers
  final firstNameEditingController = new TextEditingController();
  final secondNameEditingController = new TextEditingController();

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
      this.loggedInUser = UserModel.fromMap(value.data());
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
        RegExp regex = new RegExp(r'^.{3,}$');
        if (value!.isEmpty) {
          return ("First Name cannot be Empty");
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
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: loggedInUser.firstName,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.cyan.shade800),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.cyan.shade800),
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
          return ("Second Name cannot be Empty");
        }
        return null;
      },
      onSaved: (value) {
        secondNameEditingController.text = value!;
      },
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.person),
        contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        hintText: loggedInUser.secondName,
        border: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.cyan.shade800),
          borderRadius: BorderRadius.circular(15),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.cyan.shade800),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
    );

    //update button
    final updateButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Colors.cyan.shade800,
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: updateProfile,
        child: Text(
          "Update Profile",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Color(0xFFF6E8EA),
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    //sign out button
    final signOutButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFFF6E8EA),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          signOut();
        },
        child: Text(
          "Sign Out",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Color(0xFFCC444B),
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    //delete button
    final deleteButton = Material(
      elevation: 5,
      borderRadius: BorderRadius.circular(30),
      color: Color(0xFFCC444B),
      child: MaterialButton(
        padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
        minWidth: MediaQuery.of(context).size.width,
        onPressed: () {
          deleteAccount();
        },
        child: Text(
          "Delete Account",
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 18,
              color: Colors.cyan.shade50,
              fontWeight: FontWeight.bold),
        ),
      ),
    );

    final profileName =
        Container(child: LayoutBuilder(builder: (context, constraints) {
      if (loggedInUser.role == 'Admin') {
        return Text(
          "Admin ${loggedInUser.firstName}'s Profile",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800),
        );
      } else {
        return Text(
          "${loggedInUser.firstName}'s Profile",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.cyan.shade800),
        );
      }
    }));

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(fontFamily: 'Poppins'),
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFFFFFFFF),
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.cyan.shade800),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ),
          body: Center(
              child: SingleChildScrollView(
            child: Container(
                color: Color(0xFFFFFFFF),
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
                              "images/Profile.png",
                              fit: BoxFit.contain,
                            )),
                        profileName,
                        SizedBox(height: 3),
                        Text(
                          '${loggedInUser.email}',
                          style: TextStyle(
                              fontSize: 18, color: Colors.cyan.shade800),
                        ),
                        SizedBox(height: 20),
                        firstNameField,
                        SizedBox(height: 20),
                        secondNameField,
                        SizedBox(height: 15),
                        updateButton,
                        SizedBox(height: 15),
                        signOutButton,
                        SizedBox(height: 15),
                        deleteButton,
                        SizedBox(height: 45),
                      ],
                    ),
                  ),
                )),
          )),
        ));
  }

  updateProfile() async {
    // calling our firestore
    // calling our user model
    // sending these values

    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    UserModel userModel = UserModel();

    // writing all the values
    userModel.email = user!.email;
    userModel.uid = user.uid;

    await firebaseFirestore.collection("users").doc(user.uid).update({
      'firstName': firstNameEditingController.text,
      'secondName': secondNameEditingController.text,
    });
    Fluttertoast.showToast(msg: "Profile Updated");
  }

  deleteAccount() async {
    // calling our firestore
    // calling our user model
    // sending these values

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
