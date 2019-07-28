import 'package:clubangel/defines/define_colors.dart';
import 'package:flutter/material.dart';

class MainWidget extends StatefulWidget {
  MainWidget({Key key}) : super(key: key);

  _MainWidgetState createState() => _MainWidgetState();
}

class _MainWidgetState extends State<MainWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: Icon(
            Icons.home,
          ),
        ),
        body: Container(
          margin: EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Text("Real time", style: TextStyle(fontSize: 24)),
              SizedBox(
                height: 20.0,
              ),
              RealTimeSection(),
              // CartItems(
              //   price: "3,499.99",
              //   itemName: "PC - Custom Build",
              // ),
              SizedBox(
                height: 20.0,
              ),
              // CartItems(
              //   price: "3,499.99",
              //   itemName: "PC - Custom Build",
              // ),
              SizedBox(
                height: 30.0,
              ),
              Text("Protection Plans", style: TextStyle(fontSize: 24)),
              SizedBox(
                height: 20.0,
              ),
              ProtectionSection(),
              SizedBox(
                height: 40.0,
              ),
              // BottomPart(),
            ],
          ),
        ));
  }
}

class CartItems extends StatelessWidget {
  final String price;
  final String itemName;

  const CartItems({Key key, this.price, this.itemName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 100.0,
          height: 80.0,
          padding: EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: Colors.cyan,
              borderRadius: BorderRadius.circular(10.0)),
          child: Center(
            // child: Image(
            //   image: AssetImage("assets/customPC.png"),
            // ),
          ),
        ),
        Spacer(),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text("\$$price", style: TextStyle(fontSize: 18)),
            SizedBox(
              height: 5.0,
            ),
            Text(
              itemName,
              style: TextStyle(
                fontSize: 18,
              ),
              textAlign: TextAlign.right,
            )
          ],
        ),
        Spacer(),
        Icon(
          Icons.more_vert,
        )
      ],
    );
  }
}

class RealTimeSection extends StatelessWidget {
  const RealTimeSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          PlanCard(),
          PlanCard(),
          PlanCard(),
        ],
      ),
    );
  }
}

class ProtectionSection extends StatelessWidget {
  const ProtectionSection({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180.0,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          PlanCard(),
          PlanCardGrey(),
          PlanCardGrey(),
        ],
      ),
    );
  }
}

class PlanCard extends StatelessWidget {
  const PlanCard({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
          gradient: DefineMainLinearGradient, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "test1234",
              style:
                  TextStyle(fontWeight: FontWeight.w200),
            ),
          ),
          Spacer(),
          Align(
              alignment: Alignment.bottomRight,
              child: Text(
                "\$99.99",
                style: TextStyle(
                    fontWeight: FontWeight.w200,
                    fontSize: 16.0),
                textAlign: TextAlign.left,
              )),
        ],
      ),
    );
  }
}

class PlanCardGrey extends StatelessWidget {
  const PlanCardGrey({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.0),
      padding: EdgeInsets.all(12.0),
      width: 140.0,
      decoration: BoxDecoration(
          color: Colors.cyan, borderRadius: BorderRadius.circular(10.0)),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              "test2222",
              style:
                  TextStyle(fontWeight: FontWeight.w200),
            ),
          ),
          Spacer(),
          Align(
              alignment: Alignment.bottomRight,
              child: Text("Add".toUpperCase(),
                  style: TextStyle(
                      fontWeight: FontWeight.w200,
                      fontSize: 16.0))),
        ],
      ),
    );
  }
}

class LinearButton extends StatelessWidget {
  const LinearButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140.0,
      height: 40.0,
      decoration: BoxDecoration(
          gradient: DefineMainLinearGradient, borderRadius: BorderRadius.circular(10.0)),
      child: Center(
        child: Text("next"),
            
      ),
    );
  }
}

class BottomPart extends StatelessWidget {
  const BottomPart({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              "Estimated Total",
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 2.0,
            ),
            Text("\$4,027.97", style: TextStyle(fontSize: 22))
          ],
        ),
        LinearButton()
      ],
    );
  }
}
