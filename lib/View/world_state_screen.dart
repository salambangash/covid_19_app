import 'package:covid_19_app/View/CountriesList.dart';
import 'package:covid_19_app/model/WorldStateModel.dart';
import 'package:covid_19_app/services/States_Services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldStateScreen extends StatefulWidget {
  const WorldStateScreen({Key? key}) : super(key: key);

  @override
  State<WorldStateScreen> createState() => _WorldStateScreenState();
}

class _WorldStateScreenState extends State<WorldStateScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this)..repeat();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4) ,
    const Color(0xff1aa260) ,
    const Color(0xffde5246) ,
  ];

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.01,),
                FutureBuilder(
                  future: stateServices.fetchWorldStatesRecords(),
                    builder: (context,AsyncSnapshot<WorldStateModel> snapshot){

                    if(!snapshot.hasData){

                      return Expanded(
                          flex: 1,
                          child: SpinKitFadingCircle(

                            color: Colors.white,
                            size: 50.0,
                            controller: _controller,
                          )
                      );
                    }
                    else{
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              'Total': double.parse(snapshot.data!.cases.toString()),
                              'Recovered':double.parse(snapshot.data!.recovered.toString()),
                              'Deaths': double.parse(snapshot.data!.deaths.toString())
                            },
                            chartValuesOptions: const ChartValuesOptions(
                             showChartValuesInPercentage: true
                            ),
                            chartRadius: MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            animationDuration: const Duration(microseconds: 1200),
                            chartType: ChartType.ring,
                            colorList:colorList,
                          ),
                          Padding(
                            padding:  EdgeInsets.symmetric(vertical: MediaQuery.of(context).size.height * 0.06),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusebleRow(title:'Total', value: snapshot.data!.cases.toString()),
                                  ReusebleRow(title:'Recovered', value: snapshot.data!.recovered.toString()),
                                  ReusebleRow(title:'Deaths', value: snapshot.data!.deaths.toString()),
                                  ReusebleRow(title:'Active', value: snapshot.data!.active.toString()),
                                  ReusebleRow(title:'Critical', value: snapshot.data!.critical.toString()),
                                  ReusebleRow(title:'Today Cases', value: snapshot.data!.todayCases.toString()),
                                  ReusebleRow(title:'Today Recovered', value: snapshot.data!.todayRecovered.toString()),
                                  ReusebleRow(title:'Today Deaths', value: snapshot.data!.todayDeaths.toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap:(){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CountriesListScreen()));
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child:  Text('Track Countries',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                              ),
                            ),
                          )
                        ],
                      );
                    }
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ReusebleRow extends StatelessWidget {
  String title, value;
   ReusebleRow({Key? key, required this.title, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
              Text(value,style: const TextStyle(fontSize: 15,fontWeight: FontWeight.bold),)
            ],
          ),
          SizedBox(height: 5,),
          Divider()
        ],
      ),
    );
  }
}

