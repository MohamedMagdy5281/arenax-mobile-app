import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'edit_profile_notifier_provider.g.dart';

class EditProfileState {
  final bool? isPageLoading;

  const EditProfileState({
    this.isPageLoading=false
  });

  EditProfileState copyWith({
    bool? isPageLoading,
  }) {
    return EditProfileState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
    );
  }
}



@riverpod
class EditProfileNotifier extends _$EditProfileNotifier {
  @override
  EditProfileState build() {

    return const EditProfileState();
  }

   void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }


  }


