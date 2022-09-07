import 'package:flutter/material.dart';

class FacilityPanel extends StatelessWidget {
  const FacilityPanel({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green)),
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green)),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.local_shipping,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Free Home Delivery",
                style: TextStyle(fontFamily: 'Rubik Regular', fontSize: 11),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green)),
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green)),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      backgroundImage: NetworkImage(
                          "https://thumbs.dreamstime.com/b/recycle-icon-green-circle-arrow-white-background-98115864.jpg"),
                      // child: Icon(
                      //   Icons.arrow_circle_down,
                      //   color: Colors.green,
                      // ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Instant Return Policy",
                style: TextStyle(fontFamily: 'Rubik Regular', fontSize: 11),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.green)),
                child: CircleAvatar(
                  radius: 23,
                  backgroundColor: Colors.white,
                  child: Container(
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.green)),
                    child: CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 20,
                      child: Icon(
                        Icons.local_shipping,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Quick Support System",
                style: TextStyle(fontFamily: 'Rubik Regular', fontSize: 11),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ],
    );
  }
}
