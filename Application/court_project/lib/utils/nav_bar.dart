import 'package:court_project/utils/platform_aware_asset_image.dart';
import 'package:court_project/views/home/home_page.dart';
import 'package:court_project/views/login_page/login_page.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.09;
    double width = MediaQuery.of(context).size.width;
    double sf = MediaQuery.of(context).textScaleFactor;
    return Container(
      height: height,
      color: const Color(0xff12294D),
      child: Row(
        children: [
          ClipPath(
            clipper: MyClipper(),
            child: Container(
              color: const Color.fromRGBO(218, 223, 231, 1),
              width: width * 0.3,
              child: Row(
                children: [
                  SizedBox(
                    width: width * 0.015,
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: PlatformAwareAssetImage(asset: "logo.png"),
                  ),
                  SizedBox(
                    width: width * 0.015,
                  ),
                  Text(
                    "DISTRICT COURT TIRUPUR",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: sf * 22,
                    ),
                  ),
                  Container(
                    width: width * 0.01,
                  )
                ],
              ),
            ),
          ),
          Expanded(child: Container()),
          Container(
            color: const Color(0xff12294D),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: ((context) => const HomePage())),
                            (route) => false);
                      },
                      child: const Text(
                        "Home",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                      onPressed: () {},
                      child: const Text(
                        "Contact",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => const LoginPage())));
                      },
                      child: const Text(
                        "Register/Login",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width - (size.width * 0.075), size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
