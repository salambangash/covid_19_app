import 'package:covid_19_app/View/world_state_screen.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {

  String image;
  String name;
  int totalCases, totalDeaths, totalRecovered,todayDeaths, active, critical,todayRecovered,test;
   DetailScreen({
     required this.image,
     required this.name,
     required this.totalCases,
     required this.todayRecovered,
     required this.totalDeaths,
     required this.active,
     required this.critical,
     required this.totalRecovered,
     required this.todayDeaths,
     required this.test
   });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .06,),
                      ReusebleRow(title: 'Cases', value: widget.totalCases.toString(),),
                      ReusebleRow(title: 'Recovered', value: widget.totalRecovered.toString(),),
                      ReusebleRow(title: 'Deaths', value: widget.totalDeaths.toString(),),
                      ReusebleRow(title: 'Critical', value: widget.critical.toString(),),
                      ReusebleRow(title: 'Today Recovered', value: widget.todayRecovered.toString(),),
                      ReusebleRow(title: 'Today Deaths', value: widget.todayDeaths.toString(),)
                    ],
                  ),
                ),
              ),
              CircleAvatar(

                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
