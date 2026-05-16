import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'forget_password_notifier_provider.g.dart';

class ForgetPasswordState {
  final bool isPageLoading;
  final bool isSendButtonLoading;
  const ForgetPasswordState({
    this.isPageLoading = false,
    this.isSendButtonLoading = false,
  });

  ForgetPasswordState copyWith({
    bool? isPageLoading,
    bool? isSendButtonLoading,
  }) {
    return ForgetPasswordState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isSendButtonLoading: isSendButtonLoading ?? this.isSendButtonLoading,
    );
  }
}

@riverpod
class ForgetPasswordNotifier extends _$ForgetPasswordNotifier {
  @override
  ForgetPasswordState build() {
    return const ForgetPasswordState();
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }

  void setLoginButtonLoading(bool isLoading) {
    state = state.copyWith(isSendButtonLoading: isLoading);
  }
}
