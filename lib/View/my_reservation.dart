import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/pdf_view.dart';
import 'package:ugd_ui_widget/View/reservation_form.dart';
import 'package:ugd_ui_widget/database/sql_helper_reservation.dart';
import 'package:ugd_ui_widget/entity/Reservation.dart';
import 'home.dart';
import 'profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/client/reservationClient.dart';
import 'package:intl/intl.dart';

final List<String> doctor = ['Aji', 'Caily', 'Alina', 'Bonita', 'Daisy'];

class MyReservation extends StatefulWidget {
  const MyReservation({super.key});

  @override
  State<MyReservation> createState() => _MyReservationState();
}

class _MyReservationState extends State<MyReservation> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController noTelpController = TextEditingController();
  TextEditingController tglLahirController = TextEditingController();
  String profilePath = '';

  Future<void> loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    String? email = prefs.getString('email');
    String? noTelp = prefs.getString('noTelp');
    String? tgl = prefs.getString('tglLahir');
    String? newPath = prefs.getString('profilePath');

    setState(() {
      usernameController.text = username ?? '';
      emailController.text = email ?? '';
      noTelpController.text = noTelp != null ? noTelp.toString() : '';
      tglLahirController.text = tgl ?? '';
      profilePath = newPath!;
    });
  }

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

  List<Reservation> reservation = [];
  void refresh() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await ReservationClient.fetchAll(prefs.getString('email')!);
    print(data);
    setState(() {
      reservation = data;
      _userEmail = prefs.getString('email')!;
    });
  }

  @override
  void initState() {
    refresh();
    super.initState();
    loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reservation',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReservationForm(
                  date: null,
                  id: -1,
                  time: null,
                ),
              )).then((_) => refresh())
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 2.h,
        ),
        child: Column(
          children: [
            // TextField(
            //   decoration: InputDecoration(
            //       border: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(10)),
            //       hintText: "Search",
            //       prefixIcon: const Icon(Icons.search),
            //       filled: true,
            //       fillColor: Colors.grey[200]),
            //   onChanged: (value) async {
            //     if (value.isEmpty) {
            //       refresh();
            //     } else {
            //       final data =
            //           await ReservationClient.getUserByName(_userEmail);
            //       setState(() {
            //         reservation = data;
            //       });
            //     }
            //   },
            // ),
            SizedBox(
              height: 2.h,
            ),
            reservation.isEmpty
                ? Text("No Reservation found")
                : Expanded(
                    child: ListView.builder(
                    itemCount: reservation.length,
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) => reservationCard(index),
                  )),
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
    return GestureDetector(
      onTap: () {
        null;
      },
      child: Card(
        color: Color(0xFFfcfcfc),
        child: Padding(
          padding: EdgeInsets.all(2.h),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 16.w,
                    height: 8.h,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image(
                          image: AssetImage('images/Aji.jpg'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 10.px,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. ${reservation[index].praktek.dokter.nama}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.sp,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          )),
                      SizedBox(
                        height: 0.5.h,
                      ),
                      Row(
                        children: [
                          Text(
                            reservation[index].praktek.dokter.spesialis,
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.grey[600]),
                          ),
                          reservation[index].hasBPJS
                              ? Container(
                                  margin: EdgeInsets.only(left: 2.w),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 2.w, vertical: 0.5.h),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      color: Colors.green[400]),
                                  child: Text(
                                    'BPJS',
                                    style: TextStyle(
                                        fontSize: 12.sp,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                )
                              : const SizedBox(width: 0)
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                width: double.infinity,
                height: 7.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: const Color(0xFFe4ecf1),
                ),
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.date_range, color: Colors.grey[600]),
                        SizedBox(width: 2.w),
                        Text(
                          formatDate(reservation[index].date),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              wordSpacing: -1,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time, color: Colors.grey[600]),
                        SizedBox(width: 2.w),
                        Text(
                          "${reservation[index].praktek.jamPraktek} - ${addOneHour(reservation[index].praktek.jamPraktek)} WIB",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 16.sp,
                              wordSpacing: -1,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        side: const BorderSide(color: Colors.grey, width: 0.8),
                        backgroundColor: const Color(0xFFfcfcfc),
                        minimumSize: Size(40.w, 5.h),
                      ),
                      onPressed: () {
                        ReservationClient.destroy(reservation[index].id)
                            .then((_) => refresh());
                      },
                      child: Text(
                        'Cancle',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      )),
                  ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        minimumSize: Size(40.w, 5.h),
                      ),
                      onPressed: () {
                        if (reservation[index].hasBPJS) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationForm(
                                date: reservation[index].date,
                                id: reservation[index].id,
                                time: reservation[index].praktek.jamPraktek,
                                bpjs: reservation[index].hasBPJS.toString(),
                              ),
                            ),
                          ).then((_) => refresh());
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ReservationForm(
                                date: reservation[index].date,
                                id: reservation[index].id,
                                time: reservation[index].praktek.jamPraktek,
                                bpjs: '',
                              ),
                            ),
                          ).then((_) => refresh());
                        }
                      },
                      child: const Text(
                        'Reschedule',
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      )),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> deleteReservation(String id) async {
    await SQLHelperReservation.deleteReservation(id);
  }
}

String formatDate(String date) {
  final inputFormat = DateFormat('yyyy-MM-dd');
  final inputDate = inputFormat.parse(date);

  final outputFormat = DateFormat('EEEE, MMM d');
  return outputFormat.format(inputDate);
}

String addOneHour(String time) {
  final timeFormat = DateFormat('HH:mm');
  DateTime dateTime = timeFormat.parse(time);
  dateTime = dateTime.add(const Duration(hours: 1));
  return timeFormat.format(dateTime);
}
