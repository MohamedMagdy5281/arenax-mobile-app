abstract class AssignTargetAccentState {}

class AssignTargetAccentInitial extends AssignTargetAccentState {}

// accent element change
class ChangeSelectedPreferredAccent extends AssignTargetAccentState {
  String selectedAccent;
  ChangeSelectedPreferredAccent(this.selectedAccent);
}

// assign target accent
class StartLoadingAssignTargetAccentState extends AssignTargetAccentState {}
class StopLoadingAssignTargetAccentState extends AssignTargetAccentState {}
class AssignTargetAccentSuccessState extends AssignTargetAccentState {}
class AssignTargetAccentFailureState extends AssignTargetAccentState {
  final String errorMessage;

  AssignTargetAccentFailureState({required this.errorMessage});
}