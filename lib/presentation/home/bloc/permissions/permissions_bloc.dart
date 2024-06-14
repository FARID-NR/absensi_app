// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';

import 'package:absensi_app/data/datasources/permission_remote_datasource.dart';

part 'permissions_bloc.freezed.dart';
part 'permissions_event.dart';
part 'permissions_state.dart';

class PermissionsBloc extends Bloc<PermissionsEvent, PermissionsState> {
  final PermissionRemoteDatasource datasource;
  PermissionsBloc(
    this.datasource,
  ) : super(const _Initial()) {
    on<_AddPermissions>((event, emit) async {
      emit(const _Loading());
      final result = await datasource.addPermission(event.date, event.reason, event.image);
      result.fold(
        (l) => emit(_Error(l)),
        (r) => emit(const _Loaded()),
      );
    });
  }
}
