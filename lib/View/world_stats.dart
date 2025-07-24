import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

import '../Models/world_states_model.dart';
import '../Services/stat_services.dart';
import 'country_list.dart';

class WorldStats extends StatefulWidget {
  const WorldStats({super.key});

  @override
  State<WorldStats> createState() => _WorldStatsState();
}

class _WorldStatsState extends State<WorldStats> with TickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final colorList = <Color> [
    const Color(0xff4285F4),
    const Color(0xff2ea260),
    const Color(0xffae5242)
  ];
  @override
  Widget build(BuildContext context) {
    StatServices statServices = StatServices() ;
    return Scaffold(
      body: SafeArea(child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height*.01,),
              FutureBuilder(future: statServices.fetchworld(),
                  builder: (context,AsyncSnapshot<WorldStatesModel> snapshot){
                if(!snapshot.hasData){
                  return Expanded(flex: 1,
                      child: SpinKitFadingCircle(
                    color: Colors.white,size: 50,controller: _controller,
                  ));
                }else{
                  return Column(
                    children: [
                      PieChart(
                        dataMap:  {
                          "Total": double.parse(snapshot.data!.cases!.toString()) ,
                          "Recovered": double.parse(snapshot.data!.recovered!.toString()),
                          "Deaths": double.parse(snapshot.data!.deaths!.toString())
          
                        },
                        chartValuesOptions: const ChartValuesOptions(
                          showChartValuesInPercentage: true
                        ),
                        animationDuration: const Duration(microseconds: 1200),
                        chartType: ChartType.ring,
                        colorList:colorList,
                        chartRadius: MediaQuery.of(context).size.width/3.2,
                        legendOptions: const LegendOptions(
                            legendPosition: LegendPosition.left
                        ),
          
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height*.04),
                        child: Card(
                          child: Column(
                            children: [
                              ReusableRow(value: 'Total', title: snapshot.data!.cases.toString()),
                              ReusableRow(value: 'Deaths', title: snapshot.data!.deaths.toString()),
                              ReusableRow(value: 'Recovered', title: snapshot.data!.recovered.toString()),
                              ReusableRow(value: 'Active', title: snapshot.data!.active.toString()),
                              ReusableRow(value: 'Critical', title: snapshot.data!.critical.toString()),
                              ReusableRow(value: 'Today Deaths', title: snapshot.data!.todayDeaths.toString()),
                              ReusableRow(value: 'Today Recovered', title: snapshot.data!.todayRecovered.toString()),
          
                            ],
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const CountryList()))      ;
                    },
                        child: Container(
                          height: 50,
                          decoration:  BoxDecoration(
                              color: Color(0xff1aa260),
                              borderRadius: BorderRadius.circular(10)
                          ),
                          child: const Center(
                            child: Text('Track Countries'),
                          ),
                        ),
                      )
                    ],
                  ) ;
                }
              }),
          
            ],
          ),
        ),
      )),
    ); // your actual widget here
  }
}

class ReusableRow extends StatelessWidget {
  String title, value ;
   ReusableRow({super.key, required this.value, required this.title});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 20,bottom: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(value) ,
              Text(title) ,
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}
