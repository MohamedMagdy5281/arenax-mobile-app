abstract class AssignUserInterestState {}

class AssignUserInterestInitial extends AssignUserInterestState {}

// hobbies elements change
class ChangeSelectedHobby extends AssignUserInterestState {
  String selectedGoal;
  ChangeSelectedHobby(this.selectedGoal);
}
class ChangeSelectedHobbies extends AssignUserInterestState {
  List<String> selectedHobbies;
  ChangeSelectedHobbies(this.selectedHobbies);
}

// assign user interest
class StartLoadingAssignUserInterest extends AssignUserInterestState {}
class StopLoadingAssignUserInterest extends AssignUserInterestState {}
class AssignUserInterestSuccessState extends AssignUserInterestState {}
class AssignUserInterestFailureState extends AssignUserInterestState {
  final String errorMessage;

  AssignUserInterestFailureState({required this.errorMessage});
}