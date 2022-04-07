import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  int _radioValue = 0;

  void _handleRadioValueChange(int value) {
    setState(() {
      _radioValue = value;

      switch (_radioValue) {
        case 0:
          break;
        case 1:
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Card(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 10,
            child: Container(
              decoration: BoxDecoration(
                  color: Color(0xffccffbd),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: 500,
              width: 400,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Login.',
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff1c1427)),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Theme(
                      data: ThemeData(primaryColor: Color(0xff1c1427)),
                      child: TextField(
                        cursorColor: Color(0xff1c1427),
                        // controller: nameController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText:
                              _radioValue == 0 ? 'Doctor Id' : 'Patient Id',
                        ),
                        // onChanged: (text) {
                        //   setState(() {
                        //     fullName = text;
                        //     //you can access nameController in its scope to get
                        //     // the value of text entered as shown below
                        //     //fullName = nameController.text;
                        //   });
                        // },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
                    child: Theme(
                      data: ThemeData(primaryColor: Color(0xff1c1427)),
                      child: TextField(
                        cursorColor: Color(0xff1c1427),
                        // controller: nameController,
                        obscureText: true,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Password',
                        ),
                        // onChanged: (text) {
                        //   setState(() {
                        //     fullName = text;
                        //     //you can access nameController in its scope to get
                        //     // the value of text entered as shown below
                        //     //fullName = nameController.text;
                        //   });
                        // },
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 40,
                    width: 200,
                    child: RaisedButton.icon(
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        onPressed: () {
                          // _radioValue == 1
                          //     ? Navigator.of(context).push(MaterialPageRoute(
                          //         builder: (c) => PatientHomePage()))
                          //     : null;
                        },
                        icon: Icon(
                          Icons.done,
                          color: Colors.white,
                        ),
                        color: Color(0xff1c1427),
                        label: Text(
                          'Submit',
                          style: TextStyle(
                              // fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
