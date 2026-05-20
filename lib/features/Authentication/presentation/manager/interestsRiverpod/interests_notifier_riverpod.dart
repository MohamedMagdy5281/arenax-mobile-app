import 'package:arenax_mobile_app/core/utils/assets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'interests_notifier_riverpod.g.dart';

class InterestsNotifierRiverpod {
  final bool isPageLoading;
  final bool isInterestsButtonLoading;
  final List<String> selectedInterests;
  const InterestsNotifierRiverpod({
    this.selectedInterests = const [],
    this.isPageLoading = false,
    this.isInterestsButtonLoading = false,
  });

  InterestsNotifierRiverpod copyWith({
    List<String>? selectedInterests,
    bool? isPageLoading,
    bool? isInterestsButtonLoading,
  }) {
    return InterestsNotifierRiverpod(
      selectedInterests: selectedInterests ?? this.selectedInterests,
      isPageLoading: isPageLoading ?? this.isPageLoading,
      isInterestsButtonLoading:
          isInterestsButtonLoading ?? this.isInterestsButtonLoading,
    );
  }
}

@riverpod
class InterestsNotifier extends _$InterestsNotifier {
  List interests = [
    {
      "id": "1",
      "name": "Sports",
      "image": AssetsData.sportsImage,
    },
    {
      "id": "2",
      "name": "Sports",
      "image": AssetsData.sportsImage,
    },
    {
      "id": "3",
      "name": "Sports",
      "image": AssetsData.sportsImage,
    },
    {
      "id": "4",
      "name": "Sports",
      "image": AssetsData.sportsImage,
    },
    {
      "id": "5",
      "name": "Sports",
      "image": AssetsData.sportsImage,
    }
  ];

  get interestsList => null;

  @override
  InterestsNotifierRiverpod build() {
    return const InterestsNotifierRiverpod();
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }

  void setInterestsButtonLoading(bool isLoading) {
    state = state.copyWith(isInterestsButtonLoading: isLoading);
  }

  void toggleInterest(String interestId) {
    final currentInterests = state.selectedInterests;
    if (currentInterests.contains(interestId)) {
      // If the interest is already selected, remove it
      state = state.copyWith(
        selectedInterests:
            currentInterests.where((i) => i != interestId).toList(),
      );
    } else {
      // If the interest is not selected, add it
      state = state.copyWith(
        selectedInterests: [...currentInterests, interestId],
      );
    }
  }
}
