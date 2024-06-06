part of 'is_checkdin_bloc.dart';

@freezed
class IsCheckdinEvent with _$IsCheckdinEvent {
  const factory IsCheckdinEvent.started() = _Started;
  const factory IsCheckdinEvent.isCheckIn() = _IsCheckIn;
}