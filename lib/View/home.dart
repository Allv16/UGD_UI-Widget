import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "Hi Alvian!",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.cyan[600],
                ),
              ),
              SizedBox(
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
                height: 80,
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
                        style: TextStyle(color: Colors.grey[200], fontSize: 20),
                      )
                    ]),
              ),
              SizedBox(
                height: 80,
              ),
              //What do you need?
              Text(
                "What do you need?",
                style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                    color: Colors.cyan[600]),
              ),
              //grid - Ayas

              //grid - Ayas
            ],
          ),
        ),
      ),
    );
  }
}
