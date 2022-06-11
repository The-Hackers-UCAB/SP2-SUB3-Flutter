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

  @override
  void initState() {
    _newsBloc.add(GetCovidList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('COVID-19 List')),
      body: _buildListCovid(),
    );
  }

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
          margin: EdgeInsets.all(8.0),
          child: Row(
            children: [
              Container(
                height: 50,
                width: 50,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image:
                            NetworkImage('https://picsum.photos/250?image=9'),
                        fit: BoxFit.cover),
                    shape: BoxShape.circle),
              ),
              Card(
                child: Container(
                  margin: EdgeInsets.all(8.0),
                  child: Column(
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
            ],
          ),
        );
      },
    );
  }

  //BoxDecoration Imagenes() {
  //  BoxDecoration imagen =
  //      DecorationImage(image: NetworkImage("urlImage"), fit: BoxFit.cover);
  //}

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
