import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/pdf_view.dart';
import 'package:ugd_ui_widget/View/reservation_form.dart';
import 'package:ugd_ui_widget/View/qrcode_reservation.dart';
import 'package:ugd_ui_widget/database/sql_helper_reservation.dart';
import 'home.dart';
import 'profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

final List<String> doctor = ['Aji', 'Caily', 'Alina', 'Bonita', 'Daisy'];

class MyReservation extends StatefulWidget {
  const MyReservation({super.key});

  @override
  State<MyReservation> createState() => _MyReservationState();
}

class _MyReservationState extends State<MyReservation> {
  //for bottom nav
  int _selectedIndex = 1;
  String _userEmail = '';
  void _onItemTapped(int index) {
    if (index == 0) {
      _selectedIndex = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomeView(),
        ),
      );
    } else if (index == 2) {
      _selectedIndex = 2;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileView(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  List<Map<String, dynamic>> reservation = [];
  void refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await SQLHelperReservation.getUser(prefs.getString('email')!);
    setState(() {
      reservation = data;
      _userEmail = prefs.getString('email')!;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reservation'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReservationForm(
                  date: null,
                  id: null,
                  time: null,
                ),
              )).then((_) => refresh())
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: ResponsiveSizer(
        builder: (context, orientation, deviceType) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w, 
              vertical: 5.h,   
            ),
            child: Column(
              children: [
            TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  hintText: "Search",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.grey[200]),
              onChanged: (value) async {
                if (value.isEmpty) {
                  refresh();
                } else {
                  final data = await SQLHelperReservation.getUserByName(
                      value, _userEmail);
                  setState(() {
                    reservation = data;
                  });
                }
              },
            ),
            SizedBox(
              height: 2.h,
            ),
            reservation.length == 0
                ? Text("No Reservation found")
                : Expanded(
                    child: ListView.builder(
                    itemCount: reservation.length,
                    itemBuilder: (context, index) => reservationCard(index),
                  ))
            ],
         ),
        );
      },
    ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Reservation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.cyan[600],
        onTap: _onItemTapped,
      ),
    );
  }

  Widget reservationCard(int index) {
    final hasBpjs = reservation[index]['bpjs'] != '';
    return GestureDetector(
      onTap: () {
        createPdf(reservation[index]['id'], reservation[index]['doctorName'],
            reservation[index]['date'], context);
      },
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 80.px,
                width: 80.px,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                      image: AssetImage(
                          'images/${reservation[index]['doctorName']}.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              SizedBox(
                width: 10.px,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Dr. ' + reservation[index]['doctorName'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20.sp,
                          )),
                      SizedBox(
                        width: 2.w,
                      ),
                      hasBpjs
                          ? Container(
                              alignment: Alignment.center,
                              width: 14.w,
                              height: 4.h,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(
                                "BPJS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 7.px,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                  Text(
                    reservation[index]['date'],
                    style: TextStyle(fontSize: 13.px),
                  ),
                  Text(
                    reservation[index]['time'],
                    style: TextStyle(fontSize: 13.px),
                  ),
                  SizedBox(
                    height: 2.h,
                  ),
                  Row(
                    children: [
                      // SizedBox(
                      //   width: 1.w,
                      // ),
                      CircleAvatar(
                        radius: 20,
                        backgroundColor: Colors.blue,
                        child: IconButton(
                          onPressed: () => {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ReservationForm(
                                    date: reservation[index]['date'],
                                    id: reservation[index]['id'],
                                    time: reservation[index]['time'],
                                  ),
                                )).then((_) => refresh())
                          },
                          icon: Icon(
                            Icons.create_outlined,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(),
                        ),
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      CircleAvatar(
                        radius: 20.px,
                        backgroundColor: Colors.red,
                        child: IconButton(
                          onPressed: () => {
                            deleteReservation(reservation[index]['id'])
                                .then((_) => refresh())
                          },
                          icon: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                          style: ButtonStyle(),
                        ),
                      )
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteReservation(int id) async {
    await SQLHelperReservation.deleteReservation(id);
  }
}
