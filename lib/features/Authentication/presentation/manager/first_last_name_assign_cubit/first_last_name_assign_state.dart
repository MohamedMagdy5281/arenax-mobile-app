abstract class FirstLastNameAssignState {}

class FirstLastNameAssignInitial extends FirstLastNameAssignState {}

//Update user first and last name
class StartLoadingUpdateUserData extends FirstLastNameAssignState {}

class StopLoadingUpdateUserData extends FirstLastNameAssignState {}

class UpdateUserDataSuccess extends FirstLastNameAssignState {}

class UpdateUserDataFailure extends FirstLastNameAssignState {
  String? errorMessage;

  UpdateUserDataFailure({this.errorMessage});
}

class UpdateActiveProducts extends FirstLastNameAssignState {
  List<String> activeProducts;
  UpdateActiveProducts(this.activeProducts);
}
