import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({Key? key}) : super(key: key);

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About Our Company"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Our Motive Is To Provide Best For Those Who Deserve",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
            ),
            SizedBox(height: 10),
            Text(
                "Lorem ipsum dolor, sit amet consectetur adipisicing elit. Officiis exercitationem commodi aliquam necessitatibus vero reiciendis quaerat illo est fuga ea temporibus natus doloremque ipsum voluptas quod deserunt expedita reprehenderit pariatur quidem quisquam, recusandae animi non! Voluptas totam repudiandae rerum molestiae possimus quis numquam sapiente sunt architecto quisquam Aliquam odio option"),
            SizedBox(height: 10),
            SizedBox(
              // height: MediaQuery.of(context).size.height / 3,
              width: MediaQuery.of(context).size.width,
              child: Card(
                  child: FittedBox(
                fit: BoxFit.cover,
                child: Image.network(
                    "https://thumbs.dreamstime.com/b/country-farm-landscape-25598352.jpg"),
              )),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Text(
                          "34785",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Text("Registered Users")),
                  ],
                ),
                Container(
                  color: Colors.grey,
                  width: 1,
                  height: 35,
                  // margin: EdgeInsets.symmetric(horizontal: 4),
                ),
                Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Text(
                          "34785",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Text("Per Day Visitor")),
                  ],
                ),
                Container(
                  color: Colors.grey,
                  width: 1,
                  height: 35,
                  // margin: EdgeInsets.symmetric(horizontal: 4),
                ),
                Column(
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Text(
                          "34785",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        )),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 3.5,
                        child: Text("Total Products")),
                  ],
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
