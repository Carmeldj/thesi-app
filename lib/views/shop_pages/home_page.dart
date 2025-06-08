import 'package:flutter/material.dart';
import 'package:thesis_app/components/input.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final hasAShop = true;
  final TextEditingController searchController = TextEditingController();
  final creator = [
    "Leon",
    "Junior",
    "Ella",
    "Sophie",
    "Leon",
    "Junior",
    "Ella",
    "Sophie",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              // Title section
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "LiveShop",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Search section
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50,
                      width: MediaQuery.of(context).size.width - 20,
                      child: Input(
                        controller: searchController,
                        decoration: InputDecoration(
                          hintText: "Rechercher",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: Align(
                            widthFactor: 1.0,
                            heightFactor: 1.0,
                            child: Icon(Icons.search),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                // Creator section
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(width: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: creator.length,

                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        child: Column(
                          children: [
                            Container(
                              height: 70,
                              width: 70,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(100),
                              ),
                            ),
                            Text(creator[index]),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "En ligne",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                SizedBox(
                  height: 400,
                  child: ListView.separated(
                    itemBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 300,
                              width: 200,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  creator[index],
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text("En live maintenant"),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(width: 20),
                    scrollDirection: Axis.horizontal,
                    itemCount: creator.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
