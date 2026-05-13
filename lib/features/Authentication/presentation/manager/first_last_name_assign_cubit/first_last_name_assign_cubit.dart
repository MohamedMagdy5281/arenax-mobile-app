import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/first_last_name_assign_cubit/first_last_name_assign_state.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;

class FirstLastNameAssignCubit extends Cubit<FirstLastNameAssignState> {
  FirstLastNameAssignCubit() : super(FirstLastNameAssignInitial());

  static FirstLastNameAssignCubit get(context) => BlocProvider.of(context);

  ///******Assign User Data **********/
  api_client.UpdateUserResponse? userDetailsResponse;
  Future<void> updateUserData(
      String firstName, String lastName, DateTime dateOfBirth) async {
    api_client.UpdateUserRequest model = api_client.UpdateUserRequest();

    // model.nativeLanagaugeId = languages[languagesSelectedIndex!].id;
    // model.dateOfBirth = dateOfBirth;
    model.firstName = firstName;
    model.lastName = lastName;

    api_client.UserApi api = api_client.UserApi();

    try {
      emit(StartLoadingUpdateUserData());
      userDetailsResponse = await api.apiUserUpdateUserPost(body: model);

      if (userDetailsResponse != null) {
        await getCurrentUser();
        emit(UpdateUserDataSuccess());
        emit(StopLoadingUpdateUserData());
      }
    } on api_client.ApiException catch (e) {
      emit(UpdateUserDataFailure(
          errorMessage: jsonDecode(e.message!)['errorMessage']));
      emit(StopLoadingUpdateUserData());
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(UpdateUserDataFailure(
          errorMessage: globals.appLang == 'en'
              ? "Something went wrong, please try later"
              : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
      emit(StopLoadingUpdateUserData());
      if (kDebugMode) {
        print(e);
      }
    }
  }

  ///*********Get Current User *************/
  ///
  api_client.GetCurrentUserDetailsResponse? currentUser;
  Future<void> getCurrentUser() async {
    api_client.GetCurrentUserDetailsRequest model =
        api_client.GetCurrentUserDetailsRequest();
    api_client.AuthenticationApi api = api_client.AuthenticationApi();

    try {
      currentUser = await api.apiAuthenticationCurrentUserPost(body: model);

      if (currentUser != null) {
        CasheHelper.user = api_client.UserModel();
        CasheHelper.user?.dateOfBirth = currentUser!.user!.dateOfBirth;
        CasheHelper.user?.email = currentUser!.user!.email;
        CasheHelper.user?.genderTypeId = currentUser!.user!.genderTypeId;
        CasheHelper.user?.profilePictureId =
            currentUser!.user!.profilePictureId;
        CasheHelper.firstName = currentUser!.user!.firstName;
        CasheHelper.lastName = currentUser!.user!.lastName;
        CasheHelper.accentCode = currentUser!.user!.accent!.code;
        CasheHelper.accentId = currentUser!.user!.accentId;
        CasheHelper.languageId = currentUser!.user!.nativeLanagaugeId;
        CasheHelper.mainGoalId = currentUser!.user!.mainGoalId;
        globals.freeChatPrompt = currentUser!.freeChatPrompt;

        if (currentUser!.user!.subscriptions != null &&
            currentUser!.user!.subscriptions!.isNotEmpty) {
          for (var subsription in currentUser!.user!.subscriptions!) {
            if (subsription.isActive == true &&
                !globals.activeProductIds.contains(subsription.productId)) {
              globals.activeProductIds.add(subsription.inAppProductId!);
              emit(UpdateActiveProducts(globals.activeProductIds));
            }
          }
          final lastSubscription = currentUser!.user!.subscriptions!.last;
          int subscriptionRemainingDays = lastSubscription.subscriptionEndDate!
              .difference(DateTime.now().toUtc())
              .inDays;
          if (subscriptionRemainingDays >= 0) {
            globals.isSubscriptionActive = true;
            globals.subscriptionRemainingDays =
                subscriptionRemainingDays.toString();
          }
        } else if (currentUser!.user!.freeTrial != null) {
          int freeTrialRemainingDays = currentUser!.user!.freeTrial!.endDate!
              .difference(DateTime.now().toUtc())
              .inDays;
          if (freeTrialRemainingDays >= 0) {
            globals.isFreeTrialActive = true;
            globals.isSubscriptionActive = false;
            globals.activeProductIds.clear();
            globals.freeRemainingDays = freeTrialRemainingDays.toString();
          }
        } else {
          globals.isSubscriptionActive = false;
          globals.isFreeTrialActive = false;
          globals.activeProductIds.clear();
        }
      }
    } on api_client.ApiException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
