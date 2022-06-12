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
  final DoctorBloc _newsBloc = DoctorBloc();
  final myController = TextEditingController();
  @override
  void initState() {
    _newsBloc.add(GetDoctorList());
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
        appBar: AppBar(title: const Text('MyOnlineDoctor')),
        body: Column(
          children: <Widget>[
            Container(
              margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: TextField(
                //controller: controller,
                decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Especialidad',
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
      margin: EdgeInsets.all(0),
      child: BlocProvider(
        create: (_) => _newsBloc,
        child: BlocListener<DoctorBloc, DoctorState>(
          listener: (context, state) {
            if (state is DoctorError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            }
          },
          child: BlocBuilder<DoctorBloc, DoctorState>(
            builder: (context, state) {
              if (state is DoctorInitial) {
                return _buildLoading();
              } else if (state is DoctorLoading) {
                return _buildLoading();
              } else if (state is DoctorLoaded) {
                return _buildCard(context, state.doctorModel);
              } else if (state is DoctorError) {
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

  Widget _buildCard(BuildContext context, List<DoctorModel>? model) {
    return ListView.builder(
      itemCount: model?.length,
      itemBuilder: (context, index) {
        return Card(
          child: SizedBox(
            height: 85,
            width: 100,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(3),
                  height: 55,
                  width: 55,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(toLink(model![index].foto)),
                          fit: BoxFit.cover),
                      shape: BoxShape.circle),
                ),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "${model[index].nombre} ${model[index].apellido}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          "${model[index].especialidad}",
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  var count = 0;
  String toLink(String foto) {
    return 'https://' + foto;
  }

  Widget _buildLoading() => Center(child: CircularProgressIndicator());
}
