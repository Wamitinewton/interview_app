import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_interview/data/database.dart';
import 'package:app_interview/models/user_model.dart';
import 'package:app_interview/screen/profile_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:app_interview/screen/welcome_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  bool showPassword = false;

  File? imageFile;

  late Account _user;
  late SharedPreferences _logindata;
  late String _email = '';
  TextEditingController _usernameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initial();
  }

  void initial() async {
    _logindata = await SharedPreferences.getInstance();
    setState(() {
      _email = _logindata.getString('email')!;
    });
    await _loadUserData();
  }

  Future<void> _loadUserData() async {
    Account? user = await DatabaseHelper.instance.getCurrentUser(_email);

    if (user != null) {
      setState(() {
        _user = user;
      });
    } else {
      // Handle case when user is not found
      print('User not found');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    Widget buildTextField(
      String labelText,
      String placeholder,
      bool isPasswordTextField,
      bool isEnable,
    ) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              labelText,
              style: GoogleFonts.poppins(
                textStyle: const TextStyle(
                  fontSize: 16.0,
                  color: Color(0xFF102945),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: _usernameController,
              enabled: isEnable,
              obscureText: isPasswordTextField ? showPassword : false,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                suffixIcon: isPasswordTextField
                    ? IconButton(
                        onPressed: () {
                          setState(() {
                            showPassword = !showPassword;
                          });
                        },
                        icon: Icon(
                          showPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                          color: Colors.grey,
                          size: 22,
                        ),
                      )
                    : null,
                hintText: placeholder,
                hintStyle: GoogleFonts.poppins(
                  textStyle: const TextStyle(
                    fontSize: 15.0,
                    color: Color(0xFF102945),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Edit Profile',
          style: GoogleFonts.poppins(
            textStyle: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
        backgroundColor: Colors.lightGreen,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(
              MaterialPageRoute(
                builder: (context) => const ProfilePage(),
              ),
            );
          },
        ),
      ),
      backgroundColor: const Color(0xffF8FBFA),
      body: Container(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: Stack(
                    children: [
                      _buildImage(imageFile),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.lightGreen,
                          ),
                          child: InkWell(
                            onTap: () async {
                              XFile? imagePicked = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                              if (imagePicked != null) {
                                setState(() {
                                  imageFile = File(imagePicked.path);
                                });
                              }
                            },
                            child: const Icon(
                              Icons.camera_alt_rounded,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 35,
                ),
                buildTextField("Full Name", _user.username, false, true),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "E-mail",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF102945),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 400,
                      height: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.lightGreen[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          )),
                      child: Text(_user.email),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Subscription",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF102945),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 400,
                      height: 60,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.lightGreen[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          )),
                      child: Text(_user.isPremium == 1 ? 'Premium' : 'FREE'),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Password",
                      style: GoogleFonts.poppins(
                        textStyle: const TextStyle(
                          fontSize: 16.0,
                          color: Color(0xFF102945),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: 400,
                      height: 50,
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          color: Colors.lightGreen[100],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2,
                          )),
                      child: Text(_user.password),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height / 30, bottom: height / 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            DatabaseHelper.instance.deleteAccount(_email);
                            _logindata.setBool('login', true);
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const WelcomePage()));
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey[200],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Delete Account',
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Colors.red,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 150,
                        height: 40,
                        child: ElevatedButton(
                          onPressed: () {
                            DatabaseHelper.instance.updateUsername(
                                _email, _usernameController.text);
                            Navigator.of(context).pop(
                              MaterialPageRoute(
                                builder: (context) => const ProfilePage(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightGreen,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'Update',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.white,
                                // fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImage(File? imageFile) {
    if (imageFile != null) {
      return Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          border: Border.all(
            width: 4,
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          shape: BoxShape.circle,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: FileImage(imageFile),
          ),
        ),
      );
    } else {
      return Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(100),
        ),
        child: Center(
          child: Icon(
            Icons.account_circle, // You can choose any avatar icon here
            size: 150,
            color: Colors.grey[400],
          ),
        ),
      );
    }
  }
}
