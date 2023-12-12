import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/pdf_view.dart';
import 'package:ugd_ui_widget/View/reservation_form_new.dart';
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
  String profilePath = '';
  String _bpjs = '';
  bool _isLoadingForCancle = false;

  //for bottom nav
  int _selectedIndex = 1;
  String _userEmail = '';
  void _onItemTapped(int index) {
    if (index == 0) {
      _selectedIndex = 0;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeView(),
        ),
      );
    } else if (index == 2) {
      _selectedIndex = 2;
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ProfileView(),
        ),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  Future<List<Reservation>>? _reservation;
  Future<List<Reservation>> fetchData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final data = await ReservationClient.fetchAll(prefs.getString('email')!);
    _userEmail = prefs.getString('email') ?? prefs.getString('email')!;
    _bpjs = prefs.getString('bpjs')!;
    return data;
  }

  @override
  void initState() {
    _reservation = fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reservation',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary)),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 3.w,
          vertical: 2.h,
        ),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<List<Reservation>>(
                future: _reservation,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text('Error'));
                  } else {
                    return snapshot.data == null || snapshot.data!.isEmpty
                        ? const Center(child: Text("No Reservation"))
                        : buildCardList(snapshot.data!);
                  }
                },
              ),
            )
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

  Widget buildCardList(List<Reservation> reservation) {
    return ListView.builder(
      itemCount: reservation.length,
      itemBuilder: (context, index) {
        return buildCard(reservation[index]);
      },
    );
  }

  Widget buildCard(Reservation reservation) {
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
                          image: AssetImage(
                              'images/doctors/${reservation.praktek.dokter.profileDokter}'),
                          fit: BoxFit.cover),
                    ),
                  ),
                  SizedBox(
                    width: 10.px,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Dr. ${reservation.praktek.dokter.nama}',
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
                            reservation.praktek.dokter.spesialis,
                            style: TextStyle(
                                fontSize: 15.sp, color: Colors.grey[600]),
                          ),
                          reservation.hasBPJS
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
                          formatDate(reservation.date),
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
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
                          "${reservation.praktek.jamPraktek} - ${addOneHour(reservation.praktek.jamPraktek)} WIB",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15.sp,
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
                        setState(() {
                          _isLoadingForCancle = true;
                        });
                        ReservationClient.destroy(reservation.id).then((_) {
                          setState(() {
                            _reservation = fetchData();
                            _isLoadingForCancle = false;
                          });
                        });
                      },
                      child: _isLoadingForCancle
                          ? const CircularProgressIndicator()
                          : Text(
                              'Cancle',
                              style: TextStyle(
                                  color: Colors.grey[600], fontSize: 16),
                            )),
                  ElevatedButton(
                      style: OutlinedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)),
                        minimumSize: Size(40.w, 5.h),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReservationForm(
                              date: reservation.date,
                              bpjsNumber: _bpjs,
                              idDoctor:
                                  reservation.praktek.dokter.id.toString(),
                              hasBpjs: reservation.hasBPJS,
                              idReservation: reservation.id,
                            ),
                          ),
                        ).then((_) {
                          setState(() {
                            _reservation = fetchData();
                          });
                        });
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
