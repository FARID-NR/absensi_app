part of 'checkin_attendance_bloc.dart';

@freezed
class CheckinAttendanceEvent with _$CheckinAttendanceEvent {
  const factory CheckinAttendanceEvent.started() = _Started;
  const factory CheckinAttendanceEvent.checkIn(String latitude, String longitude) = _CheckIn;
}