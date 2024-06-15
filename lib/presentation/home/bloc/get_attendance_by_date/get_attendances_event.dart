part of 'get_attendances_bloc.dart';

@freezed
class GetAttendancesEvent with _$GetAttendancesEvent {
  const factory GetAttendancesEvent.started() = _Started;
  const factory GetAttendancesEvent.getAttendances(String date) = _GetAttendances;
}