import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_interest_cubit/assign_user_interest_state.dart';

class AssignUserInterestCubit extends Cubit<AssignUserInterestState> {
  AssignUserInterestCubit() : super(AssignUserInterestInitial());

  static AssignUserInterestCubit get(context) => BlocProvider.of(context);
  static const pageSize = 10;
  Future<void> _clearCache() async {
    PaintingBinding.instance.imageCache.clear();
    PaintingBinding.instance.imageCache.clearLiveImages();
  }

  /// *hobbies*
  final PagingController<int, api_client.GetPaginatedInterestResponse?>
  getInterestPagingController = PagingController(firstPageKey: 1);

  api_client.GetPaginatedInterestResponsePaginatedList? getPaginatedInterestResponsePaginatedList;
  Future<void> getAllInterests(int pageKey) async {
    api_client.GetPaginatedInterestRequest model = api_client.GetPaginatedInterestRequest();

    model.paginationInput = api_client.PaginationInput();
    model.paginationInput?.currentPage = pageKey;
    model.paginationInput?.getAll = false;
    model.paginationInput?.takenRows = pageSize;
    model.paginationInput?.count = pageSize;

    api_client.InterestApiApi api = api_client.InterestApiApi();
    try {
      getPaginatedInterestResponsePaginatedList =
      await api.apiInterestApiGetPaginatedInterestPost(body: model);

      if (pageKey == 1) {
        await _clearCache();
        getInterestPagingController.refresh();
        getInterestPagingController.itemList?.clear();
      }

      if (getPaginatedInterestResponsePaginatedList != null) {
        if (getPaginatedInterestResponsePaginatedList!.items!.isNotEmpty) {
          if (getPaginatedInterestResponsePaginatedList!.items!.length < pageSize) {
            getInterestPagingController.appendLastPage(getPaginatedInterestResponsePaginatedList!.items!);
          } else {
            final nextPageKey = pageKey + 1;
            getInterestPagingController.appendPage(
                getPaginatedInterestResponsePaginatedList!.items!, nextPageKey);
          }
        } else {
          // If there are no items, append an empty last page
          getInterestPagingController.appendLastPage([]);
        }
      }
    } on api_client.ApiException catch (e) {
      getInterestPagingController.error = e;
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      getInterestPagingController.error = e;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getAllInterestsInitialize() async{
    getInterestPagingController.addPageRequestListener((pageKey) {
      getAllInterests(pageKey);
    });
    getInterestPagingController.refresh();
  }

  List<String> selectedHobbies = [];
  void changeHobbyChoice(String id) {
    if (selectedHobbies.contains(id)) {
      selectedHobbies.remove(id);
    } else {
      selectedHobbies.add(id);
    }
    emit(ChangeSelectedHobbies(selectedHobbies));
  }

  /// *******AssignUserInterest*******
  api_client.UpdateUserBulkInterestResponse? updateUserBulkInterestResponse;
  Future<void> assignUserInterest({required List<String> interests}) async {
    api_client.UpdateUserBulkInterestRequest model = api_client.UpdateUserBulkInterestRequest();
    model.interestIds = interests;

    api_client.UserInterestApiApi api = api_client.UserInterestApiApi();
    try {
      emit(StartLoadingAssignUserInterest());
      updateUserBulkInterestResponse = await api.apiUserInterestApiUpdateUserBulkInterestPost(body: model);
      if (updateUserBulkInterestResponse != null) {
        // if(updateUserBulkInterestResponse!.successed == true){
          emit(StopLoadingAssignUserInterest());
          emit(AssignUserInterestSuccessState());
        // }else{
        //   emit(StopLoadingAssignUserInterest());
        //   emit(AssignUserInterestFailureState(errorMessage: updateUserBulkInterestResponse!.errorMessage!));
        // }
      }else{
        emit(StopLoadingAssignUserInterest());
        emit(AssignUserInterestFailureState(errorMessage: globals.appLang == 'en'
            ? "Something went wrong, please try later"
            : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
      }
    } on api_client.ApiException catch (e) {
      emit(StopLoadingAssignUserInterest());
      emit(AssignUserInterestFailureState(errorMessage: jsonDecode(e.message!)['errors'][0]));
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingAssignUserInterest());
      emit(AssignUserInterestFailureState(errorMessage: globals.appLang == 'en'
          ? "Something went wrong, please try later"
          : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }
}