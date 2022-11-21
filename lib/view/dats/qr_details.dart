import 'package:flexable/config/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QrDetailsScreen extends StatefulWidget {
  const QrDetailsScreen({Key? key,}) : super(key: key);

  @override
  State<QrDetailsScreen> createState() => _QrDetailsScreenState();
}

class _QrDetailsScreenState extends State<QrDetailsScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    Future<void>.delayed(Duration.zero, () {
      _showSnackbar();
    });
    super.initState();
  }

  void _showSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content:
          Text(Get.arguments ? "Successfully Redeemed" : "Already Redeemed"),
      backgroundColor:
          Get.arguments ? Colors.green.shade700 : Colors.red.shade700,
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appcolor,
          centerTitle: true,
          title: const Text("Benjamin"),
          // actions: [
          //   IconButton(onPressed: () {}, icon: const Icon(Icons.person))
          // ]
        ),
        body: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                  onTap: () {}, child: Image.asset("assets/images/shop.png")),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  "Something About Shop",
                  style: TextStyle(
                      fontWeight: FontWeight.w500, color: black, fontSize: 16),
                ),
              )
            ],
          ),
          Center(
            child: Text(
              "History",
              style: TextStyle(
                  fontWeight: FontWeight.w500, color: black, fontSize: 16),
            ),
          )
          // ListView.builder(
          //   shrinkWrap: true,
          //   itemCount: 5,
          //   itemBuilder: (context, index) {
          //     return Card(
          //       child: Row(
          //         children: [
          //           width(20),
          //           ClipRRect(
          //             child: Image.asset(
          //               "assets/images/shop.png",
          //               width: 50,
          //               height: 50,
          //               fit: BoxFit.fill,
          //             ),
          //             borderRadius: BorderRadius.circular(50),
          //           ),
          //           width(20),
          //           Column(
          //             crossAxisAlignment: CrossAxisAlignment.start,
          //             children: [
          //               height(10),
          //               const Text(
          //                 "Daniel Radcliffe",
          //                 style: TextStyle(
          //                     fontSize: 16, fontWeight: FontWeight.w600),
          //               ),
          //               height(5),
          //               Text(
          //                 DateFormat('EEEE, MMMM dd').format(DateTime.now()),
          //                 style: const TextStyle(fontSize: 12),
          //               ),
          //               height(10),
          //             ],
          //           ),
          //         ],
          //       ),
          //     );
          //   },
          // ),
        ][currentIndex],
        // bottomNavigationBar: Container(
        //   decoration: BoxDecoration(
        //     color: Colors.greenAccent.shade400,
        //     borderRadius: BorderRadius.circular(10),
        //   ),
        //   height: 50,
        //   margin: const EdgeInsets.all(20),
        //   alignment: Alignment.center,
        //   child: Text(
        //     "Successfully Redeemed",
        //     style: TextStyle(
        //         fontWeight: FontWeight.bold, color: black, fontSize: 20),
        //   ),
        // ),
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
          selectedIndex: currentIndex,
          destinations: const <Widget>[
            NavigationDestination(
              icon: Icon(Icons.info),
              label: 'About',
            ),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: 'History',
            ),
          ],
        ),
      ),
    );
  }
}
