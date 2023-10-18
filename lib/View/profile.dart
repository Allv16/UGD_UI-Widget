import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/home.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  int _selectedIndex = 2;

  void _onItemTapped(int index) {
    if (index == 0) { 
      _selectedIndex = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
    } else if (index == 1) {
      _selectedIndex = 2;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(),
        ),
      );
    } else if (index == 2) {
      _selectedIndex = 2;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profile(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = 2;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('P R O F I L E'),
        ),
        body: Column(
            children: [
              const TabBar(
                labelColor: Colors.black,
                tabs: [
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Alvian',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Andreas',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Stella',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Kristin',
                  ),
                  Tab(
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    text: 'Sebastian',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(children: [
                  //tab 1
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/Alvian.jpg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text(
                            '\nYohanes Alvian' '\nNPM : 210711047',
                            style: TextStyle(fontSize: 25),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),

                  //tab 2
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/profile-Ayas.JPG',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text('\nAndreas Margono' '\nNPM : 210711135',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  //tab 3
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/stel.jpg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text('\nRhema Stella' '\nNPM : 210711071',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  //tab 4
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/kristin.jpg',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text('\nKristina Adine' '\nNPM : 210711102',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  //tab 5
                  Container(
                    color: Colors.lightBlue.shade100,
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ClipOval(
                            child: Image.asset(
                              'images/yiyi.JPG',
                              width: 200,
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const Text('\nSebastian Gautama' '\nNPM : 210711172',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                ]),
              )
            ],
          ),
        bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Booking',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        onTap: _onItemTapped,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan[600],
      ),
      ),
    );
  }
}
