import 'package:flutter/material.dart';

class CoverageDetails extends StatelessWidget {
  const CoverageDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Coverage Details")),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ExpansionTile(
                title: Text("What Is Insurance Coverage?"),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                        "Insurance coverage is the amount of risk or liability that is covered for an individual or entity by way of insurance services. Insurance coverage, such as auto insurance, life insurance—or more exotic forms, such as hole-in-one insurance—is issued by an insurer in the event of unforeseen occurrences."),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ExpansionTile(
                title: Text("Understanding Insurance Coverage"),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                        "Insurance coverage helps consumers recover financially from unexpected events, such as car accidents or the loss of an income-producing adult supporting a family. In exchange for this coverage, the insured person pays a premium to the insurance company. Insurance coverage and its costs are often determined by multiple factors."),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ExpansionTile(
                title: Text("Main Types of Insurance Coverage"),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                        "There are different types of insurance coverage someone may need. Here are some of the most common options for insuring yourself and your property."),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                        "1. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi error ex placeat repudiandae et ut modi non libero mollitia velit. Dolor consequuntur quo error explicabo? Officiis vitae sed officia autem harum sequi pariatur corporis fugit suscipit? Laboriosam animi voluptatum quibusdam voluptate expedita corrupti natus rerum, quaerat velit, voluptates saepe quasi."),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                        "2. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi error ex placeat repudiandae et ut modi non libero mollitia velit. Dolor consequuntur quo error explicabo? Officiis vitae sed officia autem harum sequi pariatur corporis fugit suscipit? Laboriosam animi voluptatum quibusdam voluptate expedita corrupti natus rerum, quaerat velit, voluptates saepe quasi."),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                        "3. Lorem ipsum dolor sit amet, consectetur adipisicing elit. Sequi error ex placeat repudiandae et ut modi non libero mollitia velit. Dolor consequuntur quo error explicabo? Officiis vitae sed officia autem harum sequi pariatur corporis fugit suscipit? Laboriosam animi voluptatum quibusdam voluptate expedita corrupti natus rerum, quaerat velit, voluptates saepe quasi."),
                  )
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}
