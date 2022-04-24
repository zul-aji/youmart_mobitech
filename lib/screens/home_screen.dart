import 'package:flutter/material.dart';
import 'package:youmart_mobitech/screens/login_screen.dart';

// class HomeScreen extends StatefulWidget {
//   HomeScreen({Key? key}) : super(key: key);
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("YouMart Catalog"), centerTitle: true),
//       body: Center(
//         child: Padding(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 height: 150,
//                 child: Image.asset("assets/Logo.png", fit: BoxFit.contain),
//               ),
//               Text(
//                 "This will be the Home Screen",
//                 style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//               ),
//               SizedBox(height: 25),
//               ActionChip(label: Text("Logout"), onPressed: () {})
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Signed In as',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 8),
            Text(
              user.email!,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.arrow_back, size: 32),
              label: Text(
                'Sign Out',
                style: TextStyle(fontSize: 24),
              ),
              onPressed: () => FirebaseAuth.instance.signOut(),
            ),
          ],
        ),
      ),
    );
  }
}