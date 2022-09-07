import 'package:flutter/material.dart';

class CorporateGovernance extends StatelessWidget {
  const CorporateGovernance({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Corporate Governance")),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: ExpansionTile(
                title: Text("What is Corporate Governance?"),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                        "Corporate governance is the system of rules, practices and processes by which a company is directed and controlled."),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                        "Corporate Governance refers to the way in which companies are governed and to what purpose. It identifies who has power and accountability, and who makes decisions. It is, in essence, a toolkit that enables management and the board to deal more effectively with the challenges of running a company. Corporate governance ensures that businesses have appropriate decision-making processes and controls in place so that the interests of all stakeholders (shareholders, employees, suppliers, customers and the community) are balanced."),
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
                title: Text("Main Function of Corporate Governance"),
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                        "There are different types of orporate Governance someone may need. Here are some of the most common options for insuring yourself and your property."),
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
