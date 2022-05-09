import 'package:court_project/utils/nav_bar.dart';
import 'package:court_project/views/case_details/cases_overview.dart';
import 'package:court_project/views/data_feeding/data_feeding.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    height = height * 0.91;

    return Scaffold(
      body: Column(
        children: [
          // Navigation bar of the page.
          NavBar(),
          // Body of the page.
          SizedBox(
            height: height,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  SizedBox(
                      height: height * 0.112, child: const SearchPalette()),
                  SizedBox(height: height * 0.374, child: const Banner()),
                  SizedBox(
                      height: height * 0.514, child: const NoticePalette()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SearchPalette extends StatefulWidget {
  const SearchPalette({Key? key}) : super(key: key);

  @override
  State<SearchPalette> createState() => _SearchPaletteState();
}

class _SearchPaletteState extends State<SearchPalette> {
  void search(String searchString) {
    debugPrint("the searched word is $searchString");
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;

        return Container(
          height: height,
          width: width,
          color: const Color.fromRGBO(251, 246, 246, 1),
          padding: EdgeInsets.symmetric(
              vertical: height * 0.2, horizontal: width * 0.035),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: width * 0.275,
                child: Row(
                  children: [
                    // Container(
                    //   width: width * 0.275 * 0.15,
                    //   height: height * 0.6,
                    //   color: const Color.fromRGBO(218, 223, 231, 1),
                    //   child: const Icon(
                    //     Icons.search,
                    //   ),
                    // ),
                    SizedBox(
                      width: width * 0.275 * 0.75,
                      child: const TextField(
                        cursorColor: Color.fromRGBO(18, 41, 76, 1),
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ),
                          fillColor: Color.fromRGBO(218, 223, 231, 1),
                          filled: true,
                          border: InputBorder.none,
                          hoverColor: Color.fromARGB(255, 201, 204, 209),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: width * 0.275 * 0.25,
                      height: height * 0.6,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            const Color.fromRGBO(18, 41, 76, 1),
                          ),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(0.0),
                            ),
                          ),
                        ),
                        onPressed: () {},
                        child: const Text(
                          "Search",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              SizedBox(
                width: width * 0.1,
                height: height * 0.6,
                child: Center(
                  child: Text(
                    "Most Searched",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: Colors.black,
                      fontSize: height * 0.225,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.075,
                height: height * 0.6,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => CaseOverView())));
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      const Color.fromRGBO(218, 223, 231, 1),
                    ),
                  ),
                  child: Text(
                    "Case Status",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: height * 0.175,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.6,
                child: Center(
                  child: Text(
                    " | ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.175,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.075,
                height: height * 0.6,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: ((context) => DataFeeding())));
                  },
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      const Color.fromRGBO(218, 223, 231, 1),
                    ),
                  ),
                  child: Text(
                    "Data Feeding",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: height * 0.175,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: height * 0.6,
                child: Center(
                  child: Text(
                    "|",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: height * 0.175,
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: width * 0.08,
                height: height * 0.6,
                child: TextButton(
                  onPressed: () {},
                  style: ButtonStyle(
                    overlayColor: MaterialStateProperty.all(
                      const Color.fromRGBO(218, 223, 231, 1),
                    ),
                  ),
                  child: Text(
                    "Case Withdrawal",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      fontSize: height * 0.175,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class Banner extends StatelessWidget {
  const Banner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;

        return Image.asset(
          "carousel.png",
          width: width,
          height: height,
          fit: BoxFit.fitWidth,
        );
      },
    );
  }
}

class NoticePalette extends StatelessWidget {
  const NoticePalette({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double height = constraints.maxHeight;
        double width = constraints.maxWidth;

        return SizedBox(
          height: height,
          child: Row(
            children: [
              Container(
                height: height,
                width: width / 3,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: height * 0.2,
                      color: const Color.fromRGBO(237, 236, 236, 1),
                      child: Center(
                        child: Text(
                          "News",
                          style: TextStyle(
                            fontSize: height * 0.055,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.8,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "• India’s Cumulative COVID-19 Vaccination Coverage exceeds 184.66...",
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "• India’s Cumulative COVID-19 Vaccination Coverage exceeds 184.66...",
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "• India’s Cumulative COVID-19 Vaccination Coverage exceeds 184.66...",
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "• India’s Cumulative COVID-19 Vaccination Coverage exceeds 184.66...",
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: width,
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "More...",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: height,
                width: width / 3,
                color: const Color.fromRGBO(18, 41, 76, 1),
                child: Column(
                  children: [
                    Container(
                      height: height * 0.2,
                      color: const Color.fromRGBO(60, 74, 95, 1),
                      child: Center(
                        child: Text(
                          "Important Notices",
                          style: TextStyle(
                            fontSize: height * 0.055,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.8,
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "• India’s Cumulative COVID-19 Vaccination Coverage exceeds 184.66...",
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "• India’s Cumulative COVID-19 Vaccination Coverage exceeds 184.66...",
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "• India’s Cumulative COVID-19 Vaccination Coverage exceeds 184.66...",
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "• India’s Cumulative COVID-19 Vaccination Coverage exceeds 184.66...",
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            width: width,
                            padding: EdgeInsets.symmetric(
                              vertical: height * 0.03,
                              horizontal: width * 0.03,
                            ),
                            child: Text(
                              "More...",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: height * 0.045,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                height: height,
                width: width / 3,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      height: height * 0.2,
                      color: const Color.fromRGBO(237, 236, 236, 1),
                      child: Center(
                        child: Text(
                          "Gallery",
                          style: TextStyle(
                            fontSize: height * 0.055,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          20.0,
                        ),
                      ),
                      child: Center(
                        // insert image gallery carousel code here.
                        child: Image.asset(
                          "gallery.png",
                          height: height * 0.6,
                          width: width / 3 * 0.7,
                          fit: BoxFit.contain,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
