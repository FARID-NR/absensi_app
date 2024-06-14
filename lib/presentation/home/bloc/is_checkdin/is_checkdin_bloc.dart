// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:absensi_app/data/datasources/attendance_remote_datasource.dart';
import 'package:absensi_app/presentation/home/model/status_absent.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:absensi_app/data/datasources/auth_remote_datasource.dart';

part 'is_checkdin_bloc.freezed.dart';
part 'is_checkdin_event.dart';
part 'is_checkdin_state.dart';

class IsCheckdinBloc extends Bloc<IsCheckdinEvent, IsCheckdinState> {
  final AttendanceRemoteDatasource datasource;
  IsCheckdinBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_IsCheckIn>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.isCheckdin();
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(_Loaded(StatusAbsent(
          isCheckdin: r.$1, 
          isCheckedout: r.$2)
          )
        ),
      );
    });
  }
}
