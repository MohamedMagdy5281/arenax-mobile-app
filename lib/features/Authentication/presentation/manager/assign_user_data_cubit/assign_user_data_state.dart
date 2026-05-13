import 'package:flutter/material.dart';

abstract class AssignUserDataState {}

class AssignUserDataInitial extends AssignUserDataState {}

// language
class LanguageUpdate extends AssignUserDataState {
  int languageTag;

  LanguageUpdate(this.languageTag);
}
class OnNewLanguageSelect extends AssignUserDataState {
  TextEditingController? controller;
  int? languageSelectedIndex;
  int? languageTag;
  bool? languagesShowOptions;
  OnNewLanguageSelect(this.controller, this.languageSelectedIndex,
      this.languageTag, this.languagesShowOptions);
}
class LanguagesToggleAutoCompleteList extends AssignUserDataState {
  bool? languagesShowOptions;
  LanguagesToggleAutoCompleteList(this.languagesShowOptions);
}
class ChangeLanguageButtonDisabled extends AssignUserDataState {}

// get languages
class StartLoadingGetLanguagesState extends AssignUserDataState {}
class StopLoadingGetLanguagesState extends AssignUserDataState {}

// assign user data
class StartLoadingAssignUserDetailsState extends AssignUserDataState {}
class StopLoadingAssignUserDetailsState extends AssignUserDataState {}
class AssignUserDetailsSuccessState extends AssignUserDataState {}
class AssignUserDetailsFailureState extends AssignUserDataState {
  final String errorMessage;

  AssignUserDetailsFailureState({required this.errorMessage});
}