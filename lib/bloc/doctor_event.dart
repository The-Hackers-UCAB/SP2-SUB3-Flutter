//part of 'covid_bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:myonlinedoctor/models/FilterModel.dart';

abstract class DoctorEvent extends Equatable {
  const DoctorEvent();

  @override
  List<Object> get props => [];
}

class GetDoctorList extends DoctorEvent {

  final FilterModel filtro; 

  const GetDoctorList(this.filtro);
}
