import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/View/my_reservation.dart';
import 'package:ugd_ui_widget/client/praktek_client.dart';
import 'package:ugd_ui_widget/client/reservationClient.dart';
import 'package:ugd_ui_widget/entity/Praktek.dart';

class ReservationForm extends StatefulWidget {
  final String idDoctor;
  final String bpjsNumber;
  final String? date;
  final String? idPraktek;
  final bool? hasBpjs;
  final int? idReservation;

  const ReservationForm(
      {Key? key,
      required this.idDoctor,
      required this.bpjsNumber,
      this.idReservation,
      this.date,
      this.idPraktek,
      this.hasBpjs})
      : super(key: key);

  @override
  State<ReservationForm> createState() => _ReservationFormState();
}

class _ReservationFormState extends State<ReservationForm> {
  String? selectedDate;
  String? selectedTime;
  String? selectedIdPraktek;
  int? idPayment;
  int idReservation = -1;
  List<Map<String, dynamic>>? availableTime;
  Future<List<Praktek>>? _praktekList;
  bool isSwitched = false;
  bool _isLoading = false;

  get reservationClient => null;

  @override
  void initState() {
    super.initState();
    _praktekList = _fetchData();
    if (widget.date != null) {
      selectedDate = widget.date;
      isSwitched = widget.hasBpjs!;
      setAvailableTime(DateFormat('EEEE').format(DateTime.parse(widget.date!)));
      selectedIdPraktek = widget.idPraktek;
      idReservation = widget.idReservation!;
    }
  }

  Future<List<Praktek>>? _fetchData() async {
    final data = await doctorClient.fetchPraktekByDoctor(widget.idDoctor);
    return data;
  }

  void setAvailableTime(String days) async {
    List<Praktek> praktekList = [];
    await _praktekList!.then((value) => praktekList = value);

    List<Map<String, dynamic>> availableTime = [];
    for (var i = 0; i < praktekList.length; i++) {
      if (praktekList[i].hariPraktek == days) {
        availableTime.add({
          'jamPraktek': praktekList[i].jamPraktek,
          'idPraktek': praktekList[i].id.toString(),
        });
      }
    }
    setState(() {
      this.availableTime = availableTime;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Book An Appointment',
            style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.primary)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Select Date',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7))),
              Text(
                  'You can only book for the next 14 days, slide to see more available date.',
                  style: TextStyle(
                      fontSize: 14.sp, color: Colors.grey.withOpacity(0.7))),
              FutureBuilder(
                  future: _praktekList,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                          height: 15.h,
                          child:
                              const Center(child: CircularProgressIndicator()));
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('Error'));
                    } else {
                      return snapshot.data == null || snapshot.data!.isEmpty
                          ? const Center(child: Text("No Reservation"))
                          : Container(
                              padding: EdgeInsets.only(left: 1.w),
                              margin: const EdgeInsets.symmetric(
                                horizontal: 0,
                              ),
                              height: 15.h,
                              child: ListView(
                                  scrollDirection: Axis.horizontal,
                                  children: _dateCardList(snapshot.data!)),
                            );
                    }
                  }),
              Text('Select Time',
                  style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black.withOpacity(0.7))),
              Text(
                  "Displayed time below is the available time for the selected date.",
                  style: TextStyle(
                      fontSize: 14.sp, color: Colors.grey.withOpacity(0.7))),
              Container(
                height: 8.h,
                margin: const EdgeInsets.symmetric(horizontal: 0),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: availableTime == null
                      ? []
                      : _timeButtonList(availableTime!),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Use BPJS',
                          style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black.withOpacity(0.7))),
                      Text('You can use BPJS make reservation FREE',
                          style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.grey.withOpacity(0.7)))
                    ],
                  ),
                  Switch(
                      value: isSwitched,
                      activeColor: Colors.green[400],
                      onChanged: (value) {
                        setState(() {
                          widget.bpjsNumber != '-1' && idReservation == -1
                              ? isSwitched = value
                              : null;
                        });
                      }),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    minimumSize: Size(100.w, 6.h)),
                onPressed: () async {
                  if (selectedDate == null || selectedIdPraktek == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Please select date and time')));
                    return;
                  }
                  setState(() {
                    _isLoading = true;
                  });
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  idReservation == -1
                      ? await ReservationClient.create(
                          prefs.getString("email")!,
                          selectedDate!,
                          isSwitched,
                          selectedIdPraktek!,
                        )
                      : await ReservationClient.update(
                          idReservation, selectedDate!, selectedIdPraktek!);
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MyReservation()),
                      (route) => false);
                },
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Book Now",
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _dateCard(DateTime dateTime) {
    bool isSelected = false;
    selectedDate == null
        ? isSelected = false
        : isSelected =
            selectedDate == DateFormat('yyyy-MM-dd').format(dateTime);

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDate = DateFormat('yyyy-MM-dd').format(dateTime);
          selectedTime = null;
          setAvailableTime(DateFormat('EEEE').format(dateTime));
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 3.w, top: 2.h, bottom: 2.h),
        child: Container(
          constraints: BoxConstraints(
            minWidth: 20.w,
            maxHeight: 10.h,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: isSelected
                ? Theme.of(context).colorScheme.primary
                : Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                blurRadius: 5,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat('EEE').format(dateTime),
                style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: isSelected
                        ? Colors.white
                        : Colors.black.withOpacity(0.9)),
              ),
              Text(
                dateTime.day.toString(),
                style: TextStyle(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w500,
                    color: isSelected
                        ? Colors.white
                        : Colors.black.withOpacity(0.9)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  String getDayName(int dayNumber) {
    switch (dayNumber) {
      case 1:
        return 'Monday';
      case 2:
        return 'Tuesday';
      case 3:
        return 'Wednesday';
      case 4:
        return 'Thursday';
      case 5:
        return 'Friday';
      case 6:
        return 'Saturday';
      case 7:
        return 'Sunday';
      default:
        return '';
    }
  }

  List<Widget> _dateCardList(List<Praktek> praktekList) {
    List<String> targetDays = praktekList.map((e) => e.hariPraktek).toList();
    List<Widget> dateCardList = [];
    for (var i = 0; i < 14; i++) {
      DateTime currentDate = DateTime.now().add(Duration(days: i));
      String currentDayName = getDayName(currentDate.weekday);

      if (targetDays.contains(currentDayName)) {
        dateCardList.add(_dateCard(currentDate));
      }
    }
    return dateCardList;
  }

  Widget _timeButton(String time, String idPraktek) {
    bool isSelected = false;
    selectedTime == null
        ? isSelected = false
        : isSelected = selectedIdPraktek == idPraktek;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedTime = time;
          selectedIdPraktek = idPraktek;
        });
      },
      child: Padding(
        padding: EdgeInsets.only(right: 2.w, top: 2.h, bottom: 2.h),
        child: Container(
          constraints: BoxConstraints(
            minWidth: 15.w,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.grey.withOpacity(isSelected ? 0.7 : 0.1),
            border: Border.all(color: Colors.grey.withOpacity(0.8), width: 1),
          ),
          child: Center(
            child: Text(
              time,
              style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.black.withOpacity(0.5)),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _timeButtonList(List<Map<String, dynamic>> timeList) {
    List<Widget> timeButtonList = [];
    for (var i = 0; i < timeList.length; i++) {
      timeButtonList.add(
          _timeButton(timeList[i]['jamPraktek'], timeList[i]['idPraktek']));
    }
    return timeButtonList;
  }
}
