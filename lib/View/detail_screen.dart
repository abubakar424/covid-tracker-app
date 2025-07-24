import 'package:covid_tracker_app/View/world_stats.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  String name;
  String image;
  int? totalCases , totalDeaths, totalRecovered, active, critical, todayRecovered, text ;
   DetailScreen({super.key, required this.name, required this.text,required this.active,required this.critical,
     required this.todayRecovered,required this.image,required this.totalCases,required this.totalDeaths,required this.totalRecovered,});

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
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.topCenter,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * .067,) ,
                      ReusableRow(value: 'Cases', title: widget.totalCases.toString()),
                      ReusableRow(value: 'Recovered', title: widget.totalRecovered.toString()),
                      ReusableRow(value: 'Death', title: widget.totalDeaths.toString()),
                      ReusableRow(value: 'Critical', title: widget.critical.toString()),
                      ReusableRow(value: 'Total Recovered', title: widget.totalRecovered.toString()),

                    ],
                  ),
                ),
              ) ,
              CircleAvatar(
                radius: 50,backgroundImage: NetworkImage(widget.image),
              )
            ],
          )
        ],
      ),
    );
  }
}
