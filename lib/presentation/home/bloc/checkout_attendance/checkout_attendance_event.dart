part of 'checkout_attendance_bloc.dart';

@freezed
class CheckoutAttendanceEvent with _$CheckoutAttendanceEvent {
  const factory CheckoutAttendanceEvent.started() = _Started;
  const factory CheckoutAttendanceEvent.checkOut(String latitude, String longitude) = _CheckOut;
}