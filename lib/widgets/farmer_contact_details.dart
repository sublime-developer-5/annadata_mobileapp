import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FarmerContactDetails extends StatefulWidget {
  const FarmerContactDetails({Key? key}) : super(key: key);

  @override
  State<FarmerContactDetails> createState() => _FarmerContactDetailsState();
}

class _FarmerContactDetailsState extends State<FarmerContactDetails> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      elevation: 16,
      child: Container(
          height: MediaQuery.of(context).size.height / 1.5,
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Farmer Name:",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik Regular'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Jayesh Dalvi",
                style: TextStyle(
                    // color: Colors.green,
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik Regular'),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Mobile Number:",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik Regular'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    // phoneNumber.toString(),
                    "+91 8956250864",
                    style: TextStyle(
                        // color: Colors.green,
                        fontSize: 15,
                        //  fontWeight: FontWeight.bold,
                        fontFamily: 'Rubik Regular'),
                  ),
                  TextButton(
                      onPressed: () async {
                        // final url = 'tel:$phoneNumber';

                        // // ignore: deprecated_member_use
                        // if (await canLaunch(url)) {
                        //   // ignore: deprecated_member_use
                        //   await launch(url);
                        // }
                      },
                      child: Text("Call Now"))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Email ID:",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik Regular'),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.5,
                    child: Text(
                      "emailID",
                      //overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          // color: Colors.green,
                          fontSize: 15,
                          //fontWeight: FontWeight.bold,
                          fontFamily: 'Rubik Regular'),
                    ),
                  ),
                  TextButton(
                      onPressed: () async {
                        // final url = 'mailto:$emailID';

                        // // ignore: deprecated_member_use
                        // if (await canLaunch(url)) {
                        //   // ignore: deprecated_member_use
                        //   await launch(url);
                        // }
                      },
                      child: Text("Email Now"))
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Address:",
                style: TextStyle(
                    color: Colors.green,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik Regular'),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Village, City, District, State, ",
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(

                    // color: Colors.green,
                    fontSize: 15,
                    // fontWeight: FontWeight.bold,
                    fontFamily: 'Rubik Regular'),
              ),
              const SizedBox(
                height: 30,
              ),
              // ElevatedButton(
              //     onPressed: () {},
              //     style: ButtonStyle(
              //         backgroundColor:
              //             MaterialStateProperty.all(
              //                 Colors.green),
              //         shape: MaterialStateProperty.all<
              //                 RoundedRectangleBorder>(
              //             RoundedRectangleBorder(
              //                 borderRadius:
              //                     BorderRadius.circular(
              //                         10)))),
              //     child: const Text(
              //       'Call Now',
              //       style: TextStyle(
              //           fontWeight: FontWeight.bold,
              //           fontSize: 15),
              //     ))
            ],
          )),
    );
  }
}
