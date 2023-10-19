import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/reservation_form.dart';

class MyReservation extends StatefulWidget {
  const MyReservation({super.key});

  @override
  State<MyReservation> createState() => _MyReservationState();
}

class _MyReservationState extends State<MyReservation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Reservation'),
        centerTitle: true,
        leading: Icon(Icons.arrow_back_ios_new_rounded),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ReservationForm(),
              ))
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
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
                child: ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) => reservationCard(),
            ))
          ],
        ),
      ),
    );
  }

  Widget reservationCard() => Card(
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
                  child: const Image(
                      image: AssetImage('images/Alvian.jpg'),
                      fit: BoxFit.cover),
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Alvian Wijaya',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                      )),
                  Text(
                    'Wed, 12 October 2023',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    '12:15',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
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
                          onPressed: null,
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
                          onPressed: null,
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
      );
}
