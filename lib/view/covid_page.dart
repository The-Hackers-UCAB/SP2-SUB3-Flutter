import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myonlinedoctor/bloc/covid_event.dart';

import '../bloc/covid_bloc.dart';
import '../models/covid_model.dart';

class CovidPage extends StatefulWidget {
  const CovidPage({Key? key}) : super(key: key);

  @override
  _CovidPageState createState() => _CovidPageState();
}

class _CovidPageState extends State<CovidPage> {
  final CovidBloc _newsBloc = CovidBloc();
  final myController = TextEditingController();
  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    super.initState();
  }

  @override
  void dispose() {
    // Limpia el controlador cuando el Widget se descarte
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('COVID-19 List')),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextField(
                //controller: controller,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Covid',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(color: Colors.blue),
                    )),
                //onChanged: buscarPais(),
              ),
            ),
            Expanded(child: _buildListCovid())
          ],
        ));
  }

  //void buscarPais(String pais){
  //  final suggestion =
  //}
  Widget _buildListCovid() {
    return Container(
      margin: EdgeInsets.all(8.0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<CovidBloc, CovidState>(
          listener: (context, state) {
            if (state is CovidError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<CovidBloc, CovidState>(
            builder: (context, state) {
              if (state is CovidInitial) {
                return _buildLoading();
              } else if (state is CovidLoading) {
                return _buildLoading();
              } else if (state is CovidLoaded) {
                return _buildCard(context, state.covidModel);
              } else if (state is CovidError) {
                return Container();
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, CovidModel? model) {
    return ListView.builder(
      itemCount: model?.countries.length,
      itemBuilder: (context, index) {
        return Container(
          padding: const EdgeInsets.all(1),
          margin: EdgeInsets.all(5.0),
          child: Row(
            children: [
              Container(
                height: 55,
                width: 55,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(toLink()), fit: BoxFit.cover),
                    shape: BoxShape.circle),
              ),
              Expanded(
                child: Card(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text("Country: ${model?.countries[index].country}"),
                        Text(
                            "Total Confirmed: ${model?.countries[index].totalConfirmed}"),
                        Text(
                            "Total Deaths: ${model?.countries[index].totalDeaths}"),
                        Text(
                            "Total Recovered: ${model?.countries[index].totalRecovered}"),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  var count = 0;
  String toLink() {
    String link = 'https://picsum.photos/250?image=';

    count++;
    return link + count.toString();
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
