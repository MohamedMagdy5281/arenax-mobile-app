abstract class AssignMainGoalState {}

class AssignMainGoalInitial extends AssignMainGoalState {}

// main goal element change
class ChangeSelectedMainGoal extends AssignMainGoalState {
  String selectedGoal;
  ChangeSelectedMainGoal(this.selectedGoal);
}

// accent element change
class ChangeSelectedPreferredAccent extends AssignMainGoalState {
  String selectedAccent;
  ChangeSelectedPreferredAccent(this.selectedAccent);
}

// assign main goal
class StartLoadingAssignMainGoalState extends AssignMainGoalState {}
class StopLoadingAssignMainGoalState extends AssignMainGoalState {}
class AssignMainGoalSuccessState extends AssignMainGoalState {}
class AssignMainGoalFailureState extends AssignMainGoalState {
  final String errorMessage;

  AssignMainGoalFailureState({required this.errorMessage});
}