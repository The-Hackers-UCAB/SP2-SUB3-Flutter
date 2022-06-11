import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/covid_model.dart';
import '../resources/api_repository.dart';
import 'covid_event.dart';

class CovidBloc extends Bloc<CovidEvent, CovidState> {
  CovidBloc() : super(CovidInitial()) {
    final ApiRepository _apiRepository = ApiRepository();

    on<GetCovidList>((event, emit) async {
      try {
        emit(CovidLoading());
        final mList = await _apiRepository.fetchCovidList();
        emit(CovidLoaded(mList));
        //if (mList?.error != null) {
        //  emit(CovidError(mList?.error));
        //}
      } on NetworkError {
        emit(CovidError("Failed to fetch data. is your device online?"));
      }
    });
  }
}

abstract class CovidState extends Equatable {
  const CovidState();

  @override
  List<Object?> get props => [];
}

class CovidInitial extends CovidState {}

class CovidLoading extends CovidState {}

class CovidLoaded extends CovidState {
  final CovidModel? covidModel;
  const CovidLoaded(this.covidModel);
}

class CovidError extends CovidState {
  final String? message;
  const CovidError(this.message);
}
