import 'package:flutter/material.dart';
import 'package:ugd_ui_widget/View/profile.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Material menuBox(String gambar, String text, int color) {
    return Material(
      color: Colors.white,
      elevation: 15.0,
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Material(
                      borderRadius: BorderRadius.circular(24.0),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Image.asset(
                          gambar,
                          width: 55,
                          height: 55,
                        ),
                      )),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(text,
                          style: TextStyle(
                            color: Color(color),
                            fontSize: 20.0,
                          )))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Container(
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Hi all!",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: Colors.cyan[600],
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Find Your Doctor",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w900,
                              color: Colors.cyan[600],
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Profile(),
                              ), // Replace ViewListPage() with your actual page widget
                            );
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CircleAvatar(
                                radius: 50, // Adjust the radius as needed
                                backgroundImage:
                                    AssetImage('images/medicine.png'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(15)),
                  // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
                  child: Row(children: [
                    const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                    const Text(
                      "Search",
                      style: TextStyle(color: Colors.black),
                    )
                  ]),
                ),
                SizedBox(
                  height: 50,
                ),

                Container(
                  padding: const EdgeInsets.all(25.0),
                  decoration: BoxDecoration(
                      color: Colors.cyan[600],
                      borderRadius: BorderRadius.circular(15)),
                  // ignore: prefer_const_constructors, prefer_const_literals_to_create_immutables
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Health Fact",
                          style: TextStyle(
                              color: Colors.grey[200],
                              fontSize: 25,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Dalam istilah Kedokteran, istilah penyakit panas dalam tidak pernah ada.",
                          style:
                              TextStyle(color: Colors.grey[200], fontSize: 20),
                        )
                      ]),
                ),

                SizedBox(
                  height: 50,
                ),
                //What do you need?
                Text(
                  "What do you need?",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w900,
                      color: Color(0xFF00ACC1)),
                ),
                SizedBox(
                  height: 30,
                ),
                GridView.count(
                  crossAxisCount: 3, // 3 columns
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  shrinkWrap: true,
                  children: [
                    menuBox("images/medicine.png", "Medecine", 0xFF00ACC1),
                    menuBox("images/medicine.png", "Diagnostic", 0xFF00ACC1),
                    menuBox("images/medicine.png", "Consultation", 0xFF00ACC1),
                    menuBox("images/medicine.png", "Ambulance", 0xFF00ACC1),
                    menuBox("images/medicine.png", "Nurse", 0xFF00ACC1),
                    menuBox("images/medicine.png", "First Aid", 0xFF00ACC1),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
