// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:absensi_app/data/datasources/attendance_remote_datasource.dart';
import 'package:absensi_app/data/models/response/attendance_history_response_model.dart';

part 'get_attendances_bloc.freezed.dart';
part 'get_attendances_event.dart';
part 'get_attendances_state.dart';

class GetAttendancesBloc extends Bloc<GetAttendancesEvent, GetAttendancesState> {
  final AttendanceRemoteDatasource attendanceRemoteDatasource;
  GetAttendancesBloc(
    this.attendanceRemoteDatasource,
  ) : super(const _Initial()) {
    on<_GetAttendances>((event, emit) async {
      emit(const _Loading());
      final result = await attendanceRemoteDatasource.getAttendance(event.date);
      result.fold(
        (l) => emit(_Error(l)),
        (r) {
          if (r.data!.isEmpty) {
            emit(const _Empty());
          } else {
            emit(_Loaded(r.data!.first));
          }
        } ,
      );
    });
  }
}
