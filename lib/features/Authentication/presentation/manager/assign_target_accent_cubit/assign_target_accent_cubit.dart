import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_target_accent_cubit/assign_target_accent_state.dart';

class AssignTargetAccentCubit extends Cubit<AssignTargetAccentState> {
  AssignTargetAccentCubit() : super(AssignTargetAccentInitial());

  static AssignTargetAccentCubit get(context) => BlocProvider.of(context);
  static const pageSize = 10;
  Future<void> _clearCache() async {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  /// *Accent*
  final PagingController<int, api_client.GetPaginatedAccentResponse?>
      getAccentPagingController = PagingController(firstPageKey: 1);

  api_client.GetPaginatedAccentResponsePaginatedList?
      getPaginatedAccentResponsePaginatedList;
  Future<void> getAllAccents(int pageKey) async {
    api_client.GetPaginatedAccentRequest model =
        api_client.GetPaginatedAccentRequest();

    model.paginationInput = api_client.PaginationInput();
    model.paginationInput?.currentPage = pageKey;
    model.paginationInput?.getAll = false;
    model.paginationInput?.takenRows = pageSize;
    model.paginationInput?.count = pageSize;

    api_client.AccentApi api = api_client.AccentApi();
    try {
      getPaginatedAccentResponsePaginatedList =
          await api.apiAccentApiGetPaginatedAccentPost(body: model);

      if (pageKey == 1) {
        await _clearCache();
        getAccentPagingController.refresh();
        getAccentPagingController.itemList?.clear();
      }

      if (getPaginatedAccentResponsePaginatedList != null) {
        if (getPaginatedAccentResponsePaginatedList!.items!.isNotEmpty) {
          if (getPaginatedAccentResponsePaginatedList!.items!.length <
              pageSize) {
            getAccentPagingController.appendLastPage(
                getPaginatedAccentResponsePaginatedList!.items!);
          } else {
            final nextPageKey = pageKey + 1;
            getAccentPagingController.appendPage(
                getPaginatedAccentResponsePaginatedList!.items!, nextPageKey);
          }
        } else {
          // If there are no items, append an empty last page
          getAccentPagingController.appendLastPage([]);
        }
      }
    } on api_client.ApiException catch (e) {
      getAccentPagingController.error = e;
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      getAccentPagingController.error = e;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getAllAccentInitialize() async {
    getAccentPagingController.addPageRequestListener((pageKey) {
      getAllAccents(pageKey);
    });
    getAccentPagingController.refresh();
  }

  String? currentAccent;
  void changeAccentChoice(String index) {
    if (index != currentAccent) {
      currentAccent = index;
    }
    emit(ChangeSelectedPreferredAccent(currentAccent!));
  }

  /// *******AssignTargetAccent*******
  api_client.UpdateUserResponse? assignTargetAccentResponse;
  Future<void> assignTargetAccent({required String accentId}) async {
    api_client.UpdateUserRequest model = api_client.UpdateUserRequest();
    model.accentId = accentId;

    api_client.UserApi api = api_client.UserApi();
    try {
      emit(StartLoadingAssignTargetAccentState());
      assignTargetAccentResponse = await api.apiUserUpdateUserPost(body: model);
      if (assignTargetAccentResponse != null) {
        emit(StopLoadingAssignTargetAccentState());
        emit(AssignTargetAccentSuccessState());
      }
    } on api_client.ApiException catch (e) {
      emit(StopLoadingAssignTargetAccentState());
      emit(AssignTargetAccentFailureState(
          errorMessage: jsonDecode(e.message!)['errors'][0]));
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingAssignTargetAccentState());
      emit(AssignTargetAccentFailureState(
          errorMessage: globals.appLang == 'en'
              ? "Something went wrong, please try later"
              : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }
}
