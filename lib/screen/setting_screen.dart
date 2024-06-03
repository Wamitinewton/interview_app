import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'editprofil_page.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  late SharedPreferences _logindata;

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    _logindata = await SharedPreferences.getInstance();
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Profile Page",
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => EditProfile(),
              //   ),
              // );
            },
          ),
        ],
        backgroundColor: Colors.lightGreen,
        elevation: 0,
      ),
      backgroundColor: const Color(0xffF8FBFA),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Container(
              height: height / 4,
              decoration: const BoxDecoration(
                  color: Colors.lightGreen,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(15),
                    bottomRight: Radius.circular(15),
                  )),
            ),
            Stack(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    top: 10,
                    left: width / 20,
                    right: width / 20,
                  ),
                  child: Column(
                    children: <Widget>[
                      Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Align(
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: height / 15, bottom: height / 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage:
                                      const AssetImage('assets/ezra.jpg'),
                                  radius: height / 10,
                                ),
                                SizedBox(
                                  height: height / 25,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Asfara Rikza',
                                      style: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                          fontSize: 18.0,
                                          color: Color(0xFF102945),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/svg/premium-badge.svg',
                                      color: const Color(0xffFFB000),
                                      width: 24,
                                      height: 24,
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text('124210036@student.upnyk.ac.id',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        fontSize: 15.0,
                                        color: Color(0xFF102945),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Column(
                          children: <Widget>[
                            Align(
                              alignment:
                                  Alignment.centerLeft, // Atur perataan ke kiri
                              child: Text(
                                'GENERAL',
                                style: GoogleFonts.poppins(
                                  textStyle: const TextStyle(
                                      color: Color(0xff858DA0),
                                      fontWeight: FontWeight.bold),
                                ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            const SizedBox(height: 10),
                            InkWell(
                              onTap: () {
                                print(1);
                              },
                              child: infoChild(
                                  Icons.account_box,
                                  'Profile Settings',
                                  'Update and modify your profile'),
                            ),
                            InkWell(
                              onTap: () {
                                print(2);
                              },
                              child: infoChild(
                                  Icons.workspace_premium_outlined,
                                  'Get Premium',
                                  'Subcribe to get more features'),
                            ),
                            InkWell(
                              onTap: () {},
                              child: infoChild(
                                  Icons.history_edu_outlined,
                                  'Payment Hisotry',
                                  'Check your payment history'),
                            ),
                            Padding(
                                padding: EdgeInsets.only(
                                    top: height / 30, bottom: height / 30),
                                child: InkWell(
                                  onTap: () {
                                    _logindata.setBool('login', true);
                                    Navigator.pop(context);
                                  },
                                  child: Container(
                                    width: width / 3,
                                    height: height / 20,
                                    decoration: const BoxDecoration(
                                      color: Colors.deepOrange,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(50),
                                      ),
                                    ),
                                    child: const Center(
                                      child: Text(
                                        'Log Out',
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget infoChild(IconData icon, String judul, String subjudul) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          leading: Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
                color: const Color(0XFFE0E7F2),
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              icon,
              size: 35,
              color: Colors.lightGreen,
            ),
          ),
          title: Text(
            judul,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 18.0,
                color: Color(0xFF102945),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          subtitle: Text(
            subjudul,
            style: GoogleFonts.poppins(
              textStyle: const TextStyle(
                fontSize: 15.0,
                color: Color(0xFF102945),
              ),
            ),
          ),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      );
}
