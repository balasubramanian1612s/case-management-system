import 'package:court_project/utils/nav_bar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void login() {
    debugPrint("username: ${_usernameController.text}");
    debugPrint("password: ${_passwordController.text}");
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
                        onPressed: () {},
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
