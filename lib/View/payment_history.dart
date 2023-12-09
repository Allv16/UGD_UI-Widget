import 'package:flutter/material.dart';

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
          PaymentHistoryTab(title: 'On Progress', tabController: _tabController),
          PaymentHistoryTab(title: 'Completed', tabController: _tabController),
        ],
      ),
    );
  }
}

class PaymentHistoryTab extends StatelessWidget {
  final String title;
  final TabController? tabController;

  const PaymentHistoryTab({Key? key, required this.title, this.tabController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: 5, // card count
      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 16.0),
      itemBuilder: (context, index) {
        return PaymentCard(
          isOnProgress: title == 'On Progress', 
        );
      },
    );
  }
}



class PaymentCard extends StatelessWidget {
  final bool isOnProgress;

  const PaymentCard({Key? key, required this.isOnProgress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text('My Reservation'),
            trailing: isOnProgress
                ? Chip(
                    label: Text('On Progress'),
                    backgroundColor: Colors.green,
                  )
                : Chip(
                    label: Text('Paid'),
                    backgroundColor: Colors.orange,
                  ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.medical_services, color: Colors.grey),
                SizedBox(width: 8.0),
                Text('Dr. Name', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(Icons.calendar_today, color: Colors.grey),
                SizedBox(width: 8.0),
                Text('Day, Date Month Year', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                Icon(Icons.payment, color: Colors.grey),
                SizedBox(width: 8.0),
                Text('Payment Method', style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text('Total Amount', style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          if (isOnProgress)
            Padding(
              padding: const EdgeInsets.all(16.0),
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
}

