import 'package:flutter/material.dart';
import 'package:app_interview/screen/calci_track_screen.dart';
import 'package:app_interview/screen/cart_screen.dart';
import 'package:app_interview/screen/home_screen.dart';
import 'package:app_interview/screen/profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  // late Account _user;
  // late SharedPreferences _logindata;
  // late String _email = '';

  // @override
  // void initState() {
  //   super.initState();
  //   initial();
  // }

  // void initial() async {
  //   _logindata = await SharedPreferences.getInstance();
  //   setState(() {
  //     _email = _logindata.getString('email')!;
  //   });
  //   await _loadUserData();
  // }

  // Future<void> _loadUserData() async {
  //   Account? user = await DatabaseHelper.instance.getCurrentUser(_email);

  //   if (user != null) {
  //     setState(() {
  //       _user = user;
  //     });
  //   } else {
  //     // Handle case when user is not found
  //     print('User not found');
  //   }
  // }

  final List<Widget> _pages = [ 
    const HomeScreen(),
    const CalciInputScreen(),
    const CartScreenView(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(_user.username),
      //   actions: [
      //     IconButton(
      //         onPressed: () {
      //           _logindata.setBool('login', true);
      //           Navigator.pop(context);
      //         },
      //         icon: Icon(Icons.logout)),
      //   ],
      // ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          const BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.monitor_weight_rounded),
            label: 'CalciTrack',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}

Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
