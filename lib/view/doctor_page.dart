import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myonlinedoctor/models/FilterModel.dart';

import '../bloc/doctor_bloc.dart';
import '../bloc/doctor_event.dart';

import '../models/DoctorModel.dart';

class DoctorPage extends StatefulWidget {
  const DoctorPage({Key? key}) : super(key: key);

  @override
  _DoctorPageState createState() => _DoctorPageState();
}



class _DoctorPageState extends State<DoctorPage> {
  final DoctorBloc _newsBloc = DoctorBloc();
  String result = '';
  final myController = TextEditingController();
    
  @override
  void initState() {
    _newsBloc.add(GetDoctorList(FilterModel('especialidad',result)));
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
      appBar: AppBar(
        centerTitle: true,
        title: const Text('myOnlineDoctor')),
      body: Column(
        children: <Widget>[
          _buildFilterDoctor(),
          Expanded(child: _buildListDoctor())
        ],
      ),
    );
  }

  Widget _buildFilterDoctor(){
    return Container(
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
        onSubmitted: (String str) {
          setState(() {
            result = str;
            print(result);
            print("XXXXXXX");
            // didUpdateWidget(widget);
            // dispose();
            initState();

          });
        },
      ),
    );
  }

  Widget _buildListDoctor() {
    return Container(
      margin: const EdgeInsets.all(0),
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
            width: 80,
            child: Row(
              children: [
                Container(
                  margin: const EdgeInsets.all(8),
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
                    margin: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          sexoDoctor(model[index].sexo) +
                              " ${model[index].nombre} ${model[index].apellido}",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                toEspecialidades(model[index].especialidades),
                                maxLines: 4,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
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

  String toEspecialidades(List<String> especialidades) {
    var listener = especialidades.iterator;
    String acum = '';

    if (listener.moveNext()) {
      acum = listener.current;
    }
    while (listener.moveNext()) {
      acum = acum + ', ' + listener.current;
    }
    return acum;
  }

  String sexoDoctor(String sexo) {
    if (sexo == 'M') {
      return 'Dr.';
    } else {
      return 'Dra.';
    }
  }

  String toLink(String foto) {
    return 'https://' + foto;
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());
}
