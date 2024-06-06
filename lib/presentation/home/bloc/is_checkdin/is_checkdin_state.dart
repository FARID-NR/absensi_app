part of 'is_checkdin_bloc.dart';

@freezed
class IsCheckdinState with _$IsCheckdinState {
  const factory IsCheckdinState.initial() = _Initial;
  const factory IsCheckdinState.loading() = _Loading;
  const factory IsCheckdinState.loaded(bool data) = _Loaded;
  const factory IsCheckdinState.error(String message) = _Error;
}
