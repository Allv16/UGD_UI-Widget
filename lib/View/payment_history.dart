import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:ugd_ui_widget/client/paymentClient.dart';
import 'package:ugd_ui_widget/model/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ugd_ui_widget/View/my_reservation.dart';

class PaymentHistoryPage extends StatefulWidget {
  @override
  _PaymentHistoryPageState createState() => _PaymentHistoryPageState();
}

class _PaymentHistoryPageState extends State<PaymentHistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment History'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'On Progress'),
            Tab(text: 'Completed'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          PaymentHistoryProgress(
              title: 'On Progress', tabController: _tabController),
          PaymentHistoryTab(title: 'Completed', tabController: _tabController),
        ],
      ),
    );
  }
}

class PaymentHistoryTab extends ConsumerWidget {
  final String title;
  final TabController? tabController;

  PaymentHistoryTab({Key? key, required this.title, this.tabController})
      : super(key: key);

  //utk ambil data paid dr APIIIII
  final listPaid = FutureProvider<List<Payments>>((ref) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email')!;
      return await PaymentClient.fetchAllPaid(email);
    } catch (e) {
      print("error--------");
      return Future.error(e.toString());
    }
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listenerPaid = ref.watch(listPaid);
    return listenerPaid.when(
      data: (data) {
        return ListView.separated(
          itemCount: data.length, // card count
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 16.0),
          itemBuilder: (context, index) {
            return paymentCard(data[index], false, context, ref);
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text(e.toString())),
    );
  }
}

class PaymentHistoryProgress extends ConsumerWidget {
  final String title;
  final TabController? tabController;

  PaymentHistoryProgress({Key? key, required this.title, this.tabController})
      : super(key: key);

  //utk ambil data unpaid dr APIIIII
  final listUnpaid = FutureProvider<List<Payments>>((ref) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = '1@';
      return await PaymentClient.fetchAllUnpaid(email);
    } catch (e) {
      return Future.error(e.toString());
    }
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var listenerUnpaid = ref.watch(listUnpaid);
    return listenerUnpaid.when(
      data: (data) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: ListView.separated(
            itemCount: data.length, // card count
            separatorBuilder: (BuildContext context, int index) =>
                SizedBox(height: 0.5.h),
            itemBuilder: (context, index) {
              return paymentCard(data[index], true, context, ref);
            },
          ),
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text(e.toString())),
    );
  }
}

Widget paymentCard(Payments p, bool isOnProgress, context, ref) {
  return Card(
    child: Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
        border: Border.all(color: Colors.grey, width: 1),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(FontAwesomeIcons.book,
                        size: 16.sp, color: Colors.grey),
                    SizedBox(
                      width: 1.w,
                    ),
                    Text("#${p.id}",
                        style: TextStyle(
                            fontSize: 14.sp, fontWeight: FontWeight.w500)),
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: p.status == 'Paid'
                        ? Colors.green[400]
                        : Colors.yellow[300],
                  ),
                  child: Text(
                    p.status,
                    style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        color: p.status == 'Paid'
                            ? Colors.white
                            : Colors.black.withOpacity(0.6)),
                  ),
                ),
              ],
            ),
            const Divider(),
            SizedBox(height: 2.h),
            Row(
              children: [
                Icon(FontAwesomeIcons.stethoscope,
                    size: 16.sp, color: Colors.grey),
                SizedBox(
                  width: 3.w,
                ),
                Text("Dr. ${p.reservation.praktek.dokter.nama}",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.w700)),
              ],
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.calendar,
                    size: 16.sp, color: Colors.grey),
                SizedBox(
                  width: 3.w,
                ),
                Text(formatDateTime(p.dateCreated),
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.clock, size: 16.sp, color: Colors.grey),
                SizedBox(
                  width: 3.w,
                ),
                Text(
                    "${p.reservation.praktek.jamPraktek} - ${addOneHour(p.reservation.praktek.jamPraktek)}",
                    style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            Row(
              children: [
                Icon(FontAwesomeIcons.creditCard,
                    size: 16.sp, color: Colors.grey),
                SizedBox(
                  width: 3.w,
                ),
                Text(p.jenisPembayaran, style: TextStyle(fontSize: 16.sp)),
              ],
            ),
            SizedBox(height: 1.5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Total",
                        style: TextStyle(fontSize: 13.sp, color: Colors.grey)),
                    Text("Rp. ${formatCurrency(p.amount)}",
                        style: TextStyle(
                            fontSize: 16.sp, fontWeight: FontWeight.w700)),
                  ],
                ),
                p.status == 'Paid'
                    ? OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5)),
                          minimumSize: const Size(25, 25),
                        ),
                        onPressed: () {},
                        child: Icon(Icons.print,
                            size: 16.sp, color: Colors.black.withOpacity(0.5)))
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                backgroundColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.grey, width: 0.8),
                                minimumSize: Size(5.w, 3.h),
                              ),
                              onPressed: () {},
                              child: Text(
                                'Cancle',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.4),
                                    fontSize: 14),
                              )),
                          SizedBox(width: 2.w),
                          ElevatedButton(
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50)),
                                minimumSize: Size(5.w, 3.h),
                              ),
                              onPressed: () {},
                              child: const Text(
                                'Pay',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 14),
                              )),
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

String formatDateTime(DateTime dateTime) {
  // Define the desired date format
  final DateFormat formatter = DateFormat('EEEE, dd MMMM yyyy');

  // Format the DateTime using the formatter
  return formatter.format(dateTime);
}

String addOneHour(String time) {
  final timeFormat = DateFormat('HH:mm');
  DateTime dateTime = timeFormat.parse(time);
  dateTime = dateTime.add(const Duration(hours: 1));
  return timeFormat.format(dateTime);
}

String formatCurrency(int amount) {
  // Define the desired currency format
  final NumberFormat formatter =
      NumberFormat.currency(locale: 'id_ID', symbol: '');

  // Format the numeric value using the formatter
  return formatter.format(amount);
}
