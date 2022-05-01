import 'dart:convert';

import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/views/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() async {
    String _username = _usernameController.text;
    String _password = _passwordController.text;

    try {
      var response = await http.post(
          Uri.parse("http://127.0.0.1/cms/get_user.php"),
          body: {'username': _username, 'password': _password});
      List<dynamic> fetchedData = jsonDecode(response.body) as List<dynamic>;

      if (fetchedData.isNotEmpty) {
        String name = fetchedData[0]["name"];
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Logged in, welcome $name"),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.push(context,
            MaterialPageRoute(builder: ((context) => const HomePage())));
      } else {
        showDialog(
          context: context,
          builder: (_) => const AlertDialog(
            title: Text("Invalid email/password"),
            content: Text("The username/password entered is incorrect"),
          ),
        );
        return;
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (_) => const AlertDialog(
          title: Text("Something went wrong"),
          content: Text("Some problem occured with the server."),
        ),
      );
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    double sf = MediaQuery.of(context).textScaleFactor;

    height = height * 0.91;

    return Scaffold(
      body: Column(
        children: [
          const NavBar(),
          Container(
            height: height * 0.61,
            width: width * 0.35,
            decoration: BoxDecoration(
              color: const Color.fromRGBO(218, 223, 231, 1),
              borderRadius: BorderRadius.circular(20.0),
            ),
            margin: EdgeInsets.symmetric(vertical: height * 0.125),
            padding: EdgeInsets.symmetric(
              vertical: height * 0.56 * 0.075,
              horizontal: width * 0.4 * 0.125,
            ),
            child: SizedBox(
              child: Column(
                children: [
                  Text(
                    "Login",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: sf * 33,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.56 * 0.075,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Username",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: sf * 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.56 * 0.02,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: TextField(
                      controller: _usernameController,
                      cursorColor: Colors.black,
                      decoration: const InputDecoration(
                        hintText: "Username",
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.56 * 0.06,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      "Password",
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        fontSize: sf * 20,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.56 * 0.02,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7.5),
                    child: TextField(
                      controller: _passwordController,
                      cursorColor: Colors.black,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: "Password",
                        fillColor: Colors.white,
                        filled: true,
                        border: InputBorder.none,
                        suffixIcon: Icon(
                          Icons.remove_red_eye,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.56 * 0.075,
                  ),
                  SizedBox(
                    width: width * 0.4 * 0.3,
                    height: height * 0.56 * 0.115,
                    child: ElevatedButton(
                        onPressed: () {
                          login();
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(18, 41, 76, 1),
                          ),
                        ),
                        child: Text(
                          "LOGIN",
                          style: TextStyle(
                            fontSize: sf * 22.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        )),
                  ),
                  SizedBox(
                    height: height * 0.56 * 0.05,
                  ),
                  Text(
                    "New user? Register",
                    style: TextStyle(
                      fontSize: sf * 20,
                      decoration: TextDecoration.underline,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
