import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_main_goal_cubit/assign_main_goal_state.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;

class AssignMainGoalCubit extends Cubit<AssignMainGoalState> {
  AssignMainGoalCubit() : super(AssignMainGoalInitial());

  static AssignMainGoalCubit get(context) => BlocProvider.of(context);
  static const pageSize = 10;
  Future<void> _clearCache() async {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  /// *MainGoal*
  final PagingController<int, api_client.GetPaginatedMainGoalResponse?>
      getMainGoalPagingController = PagingController(firstPageKey: 1);

  api_client.GetPaginatedMainGoalResponsePaginatedList?
      getPaginatedMainGoalResponsePaginatedList;
  Future<void> getAllMainGoals(int pageKey) async {
    api_client.GetPaginatedMainGoalRequest model =
        api_client.GetPaginatedMainGoalRequest();

    model.paginationInput = api_client.PaginationInput();
    model.paginationInput?.currentPage = pageKey;
    model.paginationInput?.getAll = false;
    model.paginationInput?.takenRows = pageSize;
    model.paginationInput?.count = pageSize;

    api_client.MainGoalApiApi api = api_client.MainGoalApiApi();
    try {
      getPaginatedMainGoalResponsePaginatedList =
          await api.apiMainGoalApiGetPaginatedMainGoalPost(body: model);

      if (pageKey == 1) {
        await _clearCache();
        getMainGoalPagingController.refresh();
        getMainGoalPagingController.itemList?.clear();
      }

      if (getPaginatedMainGoalResponsePaginatedList != null) {
        if (getPaginatedMainGoalResponsePaginatedList!.items!.isNotEmpty) {
          if (getPaginatedMainGoalResponsePaginatedList!.items!.length <
              pageSize) {
            getMainGoalPagingController.appendLastPage(
                getPaginatedMainGoalResponsePaginatedList!.items!);
          } else {
            final nextPageKey = pageKey + 1;
            getMainGoalPagingController.appendPage(
                getPaginatedMainGoalResponsePaginatedList!.items!, nextPageKey);
          }
        } else {
          // If there are no items, append an empty last page
          getMainGoalPagingController.appendLastPage([]);
        }
      }
    } on api_client.ApiException catch (e) {
      getMainGoalPagingController.error = e;
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      getMainGoalPagingController.error = e;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getAllGoalsInitialize() async {
    getMainGoalPagingController.addPageRequestListener((pageKey) {
      getAllMainGoals(pageKey);
    });
    getMainGoalPagingController.refresh();
  }

  String? currentGoal;
  void changeGoalChoice(String index) {
    if (index != currentGoal) {
      currentGoal = index;
    }
    emit(ChangeSelectedMainGoal(currentGoal!));
  }

  /// *******AssignMainGoal*******
  api_client.UpdateUserResponse? assignMainGoalUserResponse;
  Future<void> assignMainGoal({required String mainGoalId}) async {
    api_client.UpdateUserRequest model = api_client.UpdateUserRequest();
    model.mainGoalId = mainGoalId;

    api_client.UserApi api = api_client.UserApi();
    try {
      emit(StartLoadingAssignMainGoalState());
      assignMainGoalUserResponse = await api.apiUserUpdateUserPost(body: model);
      if (assignMainGoalUserResponse != null) {
        emit(StopLoadingAssignMainGoalState());
        emit(AssignMainGoalSuccessState());
      }
    } on api_client.ApiException catch (e) {
      emit(StopLoadingAssignMainGoalState());
      emit(AssignMainGoalFailureState(
          errorMessage: jsonDecode(e.message!)['errors'][0]));
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingAssignMainGoalState());
      emit(AssignMainGoalFailureState(
          errorMessage: globals.appLang == 'en'
              ? "Something went wrong, please try later"
              : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }
}
