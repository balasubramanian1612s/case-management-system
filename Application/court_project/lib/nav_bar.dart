import 'package:court_project/platform_aware_asset_image.dart';
import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.09;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height,
      color: Color(0xff12294D),
      child: Row(
        children: [
          Container(
            color: Color(0xffA5B1C5),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: PlatformAwareAssetImage(asset: "logo.png"),
                ),
                Text(
                  "DISTRICT COURT TIRUPUR",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 23),
                ),
                Container(
                  width: width * 0.01,
                )
              ],
            ),
          ),
          Expanded(child: Container()),
          Container(
            color: Color(0xff12294D),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextButton(
                      onPressed: () {},
                      child: Text(
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
                      child: Text(
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
                      onPressed: () {},
                      child: Text(
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
