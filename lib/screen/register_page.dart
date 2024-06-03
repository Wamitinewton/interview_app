import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:app_interview/data/database.dart';
import 'package:bcrypt/bcrypt.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isPasswordObscure = true;
  bool _isTermsChecked = false;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPassword = TextEditingController();
Future<void> _register() async {
  String email = _emailController.text.trim();
  String username = _usernameController.text.trim();
  String password = _passwordController.text.trim();
  String cfmPassword = _confirmPassword.text.trim();

  // Check if the terms and conditions checkbox is checked
  if (!_isTermsChecked) {
    _showErrorDialog("You must agree to the terms and conditions to register.");
    return;
  }

  // Check if any field is empty
  if (email.isEmpty || username.isEmpty || password.isEmpty || cfmPassword.isEmpty) {
    _showErrorDialog("Please fill in all fields.");
    return;
  }

  // Check if the password and confirm password match
  if (password != cfmPassword) {
    _showErrorDialog("Passwords do not match.");
    return;
  }

  // Check if the account already exists
  List<Map<String, dynamic>> accountList = await DatabaseHelper.instance.getAccount(email);

  if (accountList.isNotEmpty) {
    _showErrorDialog("An account with this email already exists.");
  } else {
    // Hash the password
    String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());
    print(hashedPassword);

    // Insert the account into the database
    await DatabaseHelper.instance.insertAccount(email, username, hashedPassword);

    // Navigate back to the previous screen
    Navigator.pop(context);
    print("REGISTER SUCCESS");
  }
}


  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Error"),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text("OK"),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          decoration: const BoxDecoration(
              image: DecorationImage(
            image: AssetImage('assets/login_hero.png'),
            fit: BoxFit.cover,
          )),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(32),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'Sign Up',
                                  style: GoogleFonts.poppins(
                                    textStyle: const TextStyle(
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: _usernameController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Full Name',
                                    labelStyle: GoogleFonts.poppins(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.lightGreen,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    floatingLabelStyle: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: _emailController,
                                  obscureText: false,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Email',
                                    labelStyle: GoogleFonts.poppins(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.lightGreen,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    floatingLabelStyle: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: _passwordController,
                                  obscureText: _isPasswordObscure,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Password',
                                    labelStyle: GoogleFonts.poppins(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.lightGreen,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    floatingLabelStyle: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isPasswordObscure =
                                              !_isPasswordObscure;
                                        });
                                      },
                                      child: Icon(
                                        _isPasswordObscure
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: TextFormField(
                                  controller: _confirmPassword,
                                  obscureText: _isPasswordObscure,
                                  decoration: InputDecoration(
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    labelText: 'Confirm Password',
                                    labelStyle: GoogleFonts.poppins(),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.grey,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: Colors.lightGreen,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    floatingLabelStyle: GoogleFonts.poppins(
                                        textStyle: const TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold)),
                                    suffixIcon: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _isPasswordObscure =
                                              !_isPasswordObscure;
                                        });
                                      },
                                      child: Icon(
                                        _isPasswordObscure
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: Colors.grey,
                                        size: 22,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _isTermsChecked,
                                      onChanged: (value) {
                                        setState(() {
                                          _isTermsChecked = value ?? false;
                                        });
                                      },
                                      activeColor: Colors.lightGreen,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                        text: 'I agree to the applicable\n',
                                        style: GoogleFonts.poppins(
                                          textStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                        children: const [
                                          TextSpan(
                                            text: 'Terms of Service',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                // color: const Color(0xff04b39ef),
                                                color: Colors.lightGreen),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: ElevatedButton(
                                  onPressed: () {
                                    _register();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.lightGreen,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 16, horizontal: 24),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          12), // Radius sudut tombol
                                    ),
                                    elevation: 3,
                                    minimumSize: const Size(370, 44),
                                  ),
                                  child: Text(
                                    'Register',
                                    style: GoogleFonts.poppins(
                                      textStyle: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
