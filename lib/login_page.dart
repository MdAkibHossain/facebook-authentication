import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var usermane = "__";
  var user_email = "__";
  facebookLogin() async {
    print("FaceBook");
    try {
      final result =
          await FacebookAuth.i.login(permissions: ['public_profile', 'email']);
      if (result.status == LoginStatus.success) {
        final userData = await FacebookAuth.i.getUserData();

        setState(() {
          print(userData);
          print(userData["name"]);

          usermane = userData["name"];
          user_email = userData["email"];
        });
      }
    } catch (error) {
      print(error);
    }
  }

  facebookLogOut() async {
    await FacebookAuth.i.logOut().then((value) => setState(() {
          usermane = "__";
          user_email = "__";
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Facebook Login"),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Name: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  usermane,
                  style: TextStyle(fontSize: 22),
                ),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Email: ",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                Text(
                  user_email,
                  style: TextStyle(fontSize: 18),
                ),
              ],
            ),
            SizedBox(
              height: 300,
            ),
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () async {
                    await facebookLogin();
                  },
                  icon: Icon(Icons.facebook),
                  label: Text("Login With FaceBook"),
                ),
                SizedBox(
                  height: 30,
                ),
                ElevatedButton.icon(
                    onPressed: () async {
                      await facebookLogOut();
                    },
                    icon: Icon(Icons.logout),
                    label: Text("LogOut"))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
