import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/covid_model.dart';
import '../models/covid_model.dart';
import '../resources/api_repository.dart';
import 'covid_event.dart';

class DoctorBloc extends Bloc<DoctorEvent, DoctorState> {
  DoctorBloc() : super(DoctorInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetDoctorList>((event, emit) async {
      try {
        emit(DoctorLoading());
        final mList = await _apiRepository.fetchCovidList();
        emit(DoctorLoaded(mList));
        //if (mList?.error != null) {
        //  emit(DoctorError(mList?.error));
        //}
      } on NetworkError {
        emit(DoctorError("Failed to fetch data. is your device online?"));
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
