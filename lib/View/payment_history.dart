import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ugd_ui_widget/client/pembayaranClient.dart';
import 'package:ugd_ui_widget/model/payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final listPaid = FutureProvider<List<Payment>>((ref) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email') ?? '';
      return await PaymentClient.fetchAllPaid(email);
    } catch (e) {
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
    // return ListView.separated(
    //   itemCount: 5, // card count
    //   separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16.0),
    //   itemBuilder: (context, index) {
    //     return PaymentCard(
    //       isOnProgress: title == 'Completed',
    //     );
    //   },
    // );
  }
}

class PaymentHistoryProgress extends ConsumerWidget {
  final String title;
  final TabController? tabController;

  PaymentHistoryProgress({Key? key, required this.title, this.tabController})
      : super(key: key);

  //utk ambil data unpaid dr APIIIII
  final listUnpaid = FutureProvider<List<Payment>>((ref) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String email = prefs.getString('email') ?? '';
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
        return ListView.separated(
          itemCount: data.length, // card count
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 16.0),
          itemBuilder: (context, index) {
            return paymentCard(data[index], true, context, ref);
          },
        );
      },
      loading: () => Center(child: CircularProgressIndicator()),
      error: (e, s) => Center(child: Text(e.toString())),
    );
  }
}

Widget paymentCard(Payment p, bool isOnProgress, context, ref) {
  return Card(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: Text('My Reservation'),
          trailing: isOnProgress
              ? Chip(
                  label: Text('On Progress'),
                  backgroundColor: Color.fromARGB(255, 255, 232, 21),
                )
              : Chip(
                  label: Text('Paid'),
                  backgroundColor: const Color.fromARGB(255, 108, 226, 112),
                ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.medical_services, color: Colors.grey),
              SizedBox(width: 8.0),
              Text('Dr. ${p.reservation!.doctorName}',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.calendar_today, color: Colors.grey),
              SizedBox(width: 8.0),
              Text('${p.reservation!.date}',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        if(!isOnProgress)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Row(
            children: [
              Icon(Icons.payment, color: Colors.grey),
              SizedBox(width: 8.0),
              Text('${p.jenis_pembayaran}',
                  style: TextStyle(color: Colors.black)),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              SizedBox(height: 8), 
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rp ${p.amount}', style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        ),
        if (isOnProgress)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Handle Cancel button tap
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.red),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                SizedBox(width: 8.0),
                OutlinedButton(
                  onPressed: () {
                    // Handle Change button tap
                  },
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(color: Colors.blue),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  child: Text('Change'),
                ),
              ],
            ),
          ),
      ],
    ),
  );
}
