import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/reservation_form.dart';
import 'package:ugd_ui_widget/View/qrcode_reservation.dart';
import 'package:ugd_ui_widget/database/sql_helper_reservation.dart';
import 'home.dart';
import 'profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
            const SizedBox(
              height: 20,
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => QRCodeView(
                      data: reservation[index]['id'].toString(),
                    )));
      },
      child: Card(
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 124,
                width: 124,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image(
                      image: AssetImage(
                          'images/${reservation[index]['doctorName']}.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text('Dr. ' + reservation[index]['doctorName'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          )),
                      hasBpjs
                          ? Container(
                              alignment: Alignment.center,
                              width: 35,
                              height: 16,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Text(
                                "BPJS",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ),
                  Text(
                    reservation[index]['date'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    reservation[index]['time'],
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 100,
                      ),
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
                        width: 8,
                      ),
                      CircleAvatar(
                        radius: 20,
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
