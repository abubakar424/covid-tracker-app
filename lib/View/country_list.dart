
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../Services/stat_services.dart';
import 'detail_screen.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController searchController = TextEditingController() ;
  @override
  Widget build(BuildContext context) {
    StatServices statServices = StatServices() ;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                hint: Text('Search with country name'),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(50) ,
                )
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<dynamic>>(
              future: statServices.countriesListApi(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  // ⏳ Show shimmer while loading
                  return ListView.builder(
                    itemCount: 4,
                    itemBuilder: (context, index) => Shimmer.fromColors(
                      baseColor: Colors.grey.shade700,
                      highlightColor: Colors.grey.shade100,
                      child: ListTile(
                        leading: Container(height: 50, width: 50, color: Colors.white),
                        title: Container(height: 10, width: 80, color: Colors.white),
                        subtitle: Container(height: 10, width: 80, color: Colors.white),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  // ❌ Show error
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  // 📭 Show empty state
                  return Center(child: Text('No data available.'));
                } else {
                  // ✅ Show the actual data
                  final data = snapshot.data!;
                  return ListView.builder(
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      final country = data[index];
                      final name = country['country'] ?? '';

                      if (searchController.text.isEmpty ||
                          name.toLowerCase().contains(searchController.text.toLowerCase())) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailScreen(
                                  name: country['country'],
                                  image: country['countryInfo']['flag'],
                                  totalCases: country['cases'],
                                  todayRecovered: country['recovered'],
                                  totalDeaths: country['deaths'],
                                  active: country['active'],
                                  text: country['tests'],
                                  totalRecovered: country['totalRecovered'],
                                  critical: country['critical'],
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            leading: Image.network(
                              country['countryInfo']['flag'],
                              height: 50,
                              width: 50,
                            ),
                            title: Text(country['country']),
                            subtitle: Text(country['cases'].toString()),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    },
                  );
                }
              },
            ),
          ),
        ],
      )),
    );
  }
}
