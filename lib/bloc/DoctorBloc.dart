import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/DoctorModel.dart';
import '../resources/ApiRepository.dart';
import 'DoctorEvent.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorInitial()) {
    final ApiRepository apiRepository = ApiRepository();

    on<GetDoctorList>((event, emit) async {
      try {
        
        emit(DoctorLoading());
        final mList =  await apiRepository.fetchDoctorList(event.filtro);
        emit(DoctorLoaded(mList));
        //if (mList?.error != null) {
        //  emit(DoctorError(mList?.error));
        //}
      } on NetworkError {
        emit(DoctorError("Fallo en la busqueda de datos"));
      }
    });
  }
}

abstract class DoctorState extends Equatable {
  const DoctorState();

  @override
  List<Object?> get props => [];
}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final List<DoctorModel>? doctorModel;
  const DoctorLoaded(this.doctorModel);
}

class DoctorError extends DoctorState {
  final String? message;
  const DoctorError(this.message);
}


class NetworkError extends Error {}