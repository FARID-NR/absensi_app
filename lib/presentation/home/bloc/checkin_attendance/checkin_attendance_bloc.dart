// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:absensi_app/data/models/request/checkinout_request_model.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:absensi_app/data/datasources/attendance_remote_datasource.dart';
import 'package:absensi_app/data/models/response/checkinout_response_model.dart';

part 'checkin_attendance_bloc.freezed.dart';
part 'checkin_attendance_event.dart';
part 'checkin_attendance_state.dart';

class CheckinAttendanceBloc extends Bloc<CheckinAttendanceEvent, CheckinAttendanceState> {
  final AttendanceRemoteDatasource datasource;
  CheckinAttendanceBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_CheckIn>((event, emit) async {
      emit(const _Loading());
      final requestModel = CheckInOutRequestModel(
        latitude: event.latitude,
        longitude: event.longitude,
      );
      final result = await datasource.checkin(requestModel);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(r)),
      );
    });
  }
}
