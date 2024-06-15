part of 'get_attendances_bloc.dart';

@freezed
class GetAttendancesState with _$GetAttendancesState {
  const factory GetAttendancesState.initial() = _Initial;
  const factory GetAttendancesState.loading() = _Loading;
  const factory GetAttendancesState.loaded(Attendance attendance) = _Loaded;
  const factory GetAttendancesState.error(String message) = _Error;
  const factory GetAttendancesState.empty() = _Empty;
}
