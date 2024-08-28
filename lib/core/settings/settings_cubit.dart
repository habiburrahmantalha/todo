import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/resource/resource.dart';
import 'package:todo/utils/storage_manager.dart';

part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({String? languageCode, ThemeMode? themeMode})
      : super(SettingsState(languageCode: languageCode, theme: themeMode));

  void setLanguageCode(String languageCode) {
    StorageManager.instance.setString(R.string.languageCode, languageCode);
    emit(state.copyWith(languageCode: languageCode));
  }

  void setAppTheme(ThemeMode theme) {
    if (theme == ThemeMode.light) {
      emit(state.copyWith(theme: ThemeMode.light));
    } else if (theme == ThemeMode.dark) {
      emit(state.copyWith(theme: ThemeMode.dark));
    }
  }
}
