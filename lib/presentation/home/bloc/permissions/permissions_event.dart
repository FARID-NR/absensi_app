part of 'permissions_bloc.dart';

@freezed
class PermissionsEvent with _$PermissionsEvent {
  const factory PermissionsEvent.started() = _Started;
  const factory PermissionsEvent.addPermissions({
    required String date,
    required String reason,
    required XFile? image
  }) = _AddPermissions;
}