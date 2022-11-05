import 'package:covid_19_app/View/detail_screen.dart';
import 'package:covid_19_app/services/States_Services.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountriesListScreen extends StatefulWidget {
  const CountriesListScreen({Key? key}) : super(key: key);

  @override
  State<CountriesListScreen> createState() => _CountriesListScreenState();
}

class _CountriesListScreenState extends State<CountriesListScreen> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    StateServices stateServices = StateServices();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor ,
      ),
      body: SafeArea(
        child: Column(
          children: [
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: TextFormField(
                 onChanged: (value){
                   setState(() {

                   });
                 },
                 controller: searchController,
                 decoration:  InputDecoration(
                   contentPadding:const EdgeInsets.symmetric(horizontal: 20),
                   hintText: 'Search with country name',
                   border: OutlineInputBorder(
                     borderRadius: BorderRadius.circular(50.0),
                   )
                 ),
               ),
             ),
            Expanded(
              child: FutureBuilder(
                future: stateServices.countryListApi(),
                  builder: (context,AsyncSnapshot<List<dynamic>> snapshot){

                    if(!snapshot.hasData){
                      return  ListView.builder(
                          itemCount: 10,
                          itemBuilder: (context, index){
                            return Shimmer.fromColors(
                                baseColor: Colors.grey.shade700,
                                highlightColor: Colors.grey.shade100,
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Container(height: 10,width: 90,color: Colors.white,),
                                      subtitle: Container(height: 10,width: 90,color: Colors.white,),
                                      leading: Container(height: 50,width: 50,color: Colors.white,),
                                    )
                                  ],
                                )
                            );
                          });
                    }else{
                     return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            String name = snapshot.data![index]['country'];

                            if(searchController.text.isEmpty){

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=> DetailScreen(

                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            name: snapshot.data![index]['country'],
                                            totalCases: snapshot.data![index]['cases'],
                                            totalDeaths: snapshot.data![index]['deaths'],
                                            totalRecovered: snapshot.data![index]['recovered'],
                                            active: snapshot.data![index]['active'],
                                            critical: snapshot.data![index]['critical'],
                                            todayDeaths: snapshot.data![index]['todayDeaths'],
                                            todayRecovered: snapshot.data![index]['todayRecovered'],
                                            test: snapshot.data![index]['tests'],



                                          )));
                                    },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])
                                      ),
                                    ),
                                  )
                                ],
                              );

                            }else if(name.toLowerCase().contains(searchController.text.toLowerCase())){

                              return Column(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context)=> DetailScreen(

                                            image: snapshot.data![index]['countryInfo']['flag'],
                                            name: snapshot.data![index]['country'],
                                            totalCases: snapshot.data![index]['cases'],
                                            totalDeaths: snapshot.data![index]['deaths'],
                                            totalRecovered: snapshot.data![index]['recovered'],
                                            active: snapshot.data![index]['active'],
                                            critical: snapshot.data![index]['critical'],
                                            todayDeaths: snapshot.data![index]['todayDeaths'],
                                            todayRecovered: snapshot.data![index]['todayRecovered'],
                                            test: snapshot.data![index]['tests'],



                                          )));
                                  },
                                    child: ListTile(
                                      title: Text(snapshot.data![index]['country']),
                                      subtitle: Text(snapshot.data![index]['cases'].toString()),
                                      leading: Image(
                                          height: 50,
                                          width: 50,
                                          image: NetworkImage(snapshot.data![index]['countryInfo']['flag'])
                                      ),
                                    ),
                                  )
                                ],
                              );

                            }else{

                              return Container();
                            }

                      });
                    }

              },
              ),
            )
          ],
        ),
      ),
    );
  }
}
