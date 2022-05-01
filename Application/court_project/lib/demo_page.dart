import 'package:court_project/utils/nav_bar.dart';
import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NavBar(),
      // Row(
      //   children: [
      //     ClipPath(
      //       clipper: MyClipper1(),
      //       child: Container(
      //         height: 150,
      //         width: 300,
      //         color: Colors.orange,
      //       ),
      //     ),
      //     ClipPath(
      //       clipper: MyClipper2(),
      //       child: Container(
      //         height: 150,
      //         width: 300,
      //         color: Colors.green,
      //       ),
      //     ),
      //   ],
      // ),
    );
  }
}

class MyClipper1 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.moveTo(size.width, 0);
    path.lineTo(size.width - 50, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

class MyClipper2 extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(-50, size.height);
    path.lineTo(size.height, size.width);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
