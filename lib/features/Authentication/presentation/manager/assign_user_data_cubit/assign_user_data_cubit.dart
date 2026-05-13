import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:praktika_clone_app/features/Authentication/presentation/manager/assign_user_data_cubit/assign_user_data_state.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:praktika_clone_app/client/api.dart' as api_client;

class AssignUserDataCubit extends Cubit<AssignUserDataState> {
  AssignUserDataCubit() : super(AssignUserDataInitial());

  static AssignUserDataCubit get(context) => BlocProvider.of(context);

  /// *******Language*******

  int languageTag = 0;
  int? languagesSelectedIndex;
  FocusNode languagesFocusNode = FocusNode();
  bool languagesShowOptions = false;
  TextEditingController languageController = TextEditingController();

  void updateLanguageTag(int val) {
    if (languageTag != val) {
      languageTag = val;
      emit(LanguageUpdate(languageTag));
    }
  }

  Future<void> onNewLanguageSelect(
      api_client.GetPaginatedLanguageResponse newLang) async {
    languageController.text = globals.appLang == 'ar'
        ? newLang.nameAr ?? newLang.nameEn.toString()
        : newLang.nameEn ?? newLang.nameAr.toString();
    languagesSelectedIndex =
        languages.indexWhere((item) => item.id == newLang.id);

    emit(OnNewLanguageSelect(languageController, languagesSelectedIndex,
        languageTag, languagesShowOptions));
    // onChangeLanguageButtonDisable(languageController.text);
  }

  Future<void> languageToggleAutoCompleteList() async {
    languagesShowOptions = !languagesShowOptions;

    if (languagesShowOptions) {
      languagesFocusNode.requestFocus(); // Show the keyboard
    } else {
      languagesFocusNode.unfocus(); // Lose focus and close the keyboard
    }

    emit(LanguagesToggleAutoCompleteList(languagesShowOptions));
  }

  void setLanguagesShowOptions(bool value) {
    languagesShowOptions = value;
    emit(LanguagesToggleAutoCompleteList(languagesShowOptions));
  }

  // language button disable
  bool isLanguageButtonDisabled = true;
  void onChangeLanguageButtonDisable(String? controller) {
    if (controller == null || controller.trim().isEmpty || controller == "") {
      isLanguageButtonDisabled = true;
      emit(ChangeLanguageButtonDisabled());
    } else {
      isLanguageButtonDisabled = false;
      emit(ChangeLanguageButtonDisabled());
    }
  }

  // get paginated languages
  final PagingController<int, api_client.GetPaginatedLanguageResponse?>
      getLanguagesPagingController = PagingController(firstPageKey: 1);
  final int pageSize = 10;
  List<api_client.GetPaginatedLanguageResponse> languages = [];

  api_client.GetPaginatedLanguageResponsePaginatedList?
      getPaginatedLanguageResponsePaginatedList;
  Future<void> getLanguages(int pageKey) async {
    api_client.GetPaginatedLanguageRequest model =
        api_client.GetPaginatedLanguageRequest();
    model.paginationInput = api_client.PaginationInput();
    model.paginationInput?.count = pageSize;
    model.paginationInput?.currentPage = pageKey;
    model.paginationInput?.takenRows = pageSize;
    model.paginationInput?.getAll = true;

    api_client.LanguageApi api = api_client.LanguageApi();
    try {
      emit(StartLoadingGetLanguagesState());
      getPaginatedLanguageResponsePaginatedList =
          await api.apiLanguageApiGetPaginatedLanguagePost(body: model);

      if (pageKey == 1) {
        getLanguagesPagingController.refresh();
        getLanguagesPagingController.itemList?.clear();
      }

      if (getPaginatedLanguageResponsePaginatedList != null) {
        if (getPaginatedLanguageResponsePaginatedList!.items!.isNotEmpty) {
          languages = getPaginatedLanguageResponsePaginatedList!.items!;
          if (getPaginatedLanguageResponsePaginatedList!.items!.length <
              pageSize) {
            getLanguagesPagingController.appendLastPage(
                getPaginatedLanguageResponsePaginatedList!.items!);
          } else {
            final nextPageKey = pageKey + 1;
            getLanguagesPagingController.appendPage(
                getPaginatedLanguageResponsePaginatedList!.items!, nextPageKey);
          }
        } else {
          // If there are no items, append an empty last page
          getLanguagesPagingController.appendLastPage([]);
        }
        emit(StopLoadingGetLanguagesState());
      }
      emit(StopLoadingGetLanguagesState());
    } on api_client.ApiException catch (e) {
      emit(StopLoadingGetLanguagesState());
      getLanguagesPagingController.error = e;
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingGetLanguagesState());
      getLanguagesPagingController.error = e;
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getAllLanguagesInitialize() async {
    getLanguagesPagingController.addPageRequestListener((pageKey) {
      getLanguages(pageKey);
    });
    getLanguages(1);
  }

  /// *******AssignUserDetails*******

  api_client.UpdateUserResponse? assingUserDetailsReponse;
  Future<void> assignUserDetails(
      {required String langaugeId,
      required int genderType,
      required DateTime dateOfBirth}) async {
    api_client.UpdateUserRequest model = api_client.UpdateUserRequest();
    model.nativeLanagaugeId = langaugeId;
    model.genderTypeId = genderType;
    model.dateOfBirth = dateOfBirth;

    api_client.UserApi api = api_client.UserApi();
    try {
      emit(StartLoadingAssignUserDetailsState());
      assingUserDetailsReponse = await api.apiUserUpdateUserPost(body: model);
      if (assingUserDetailsReponse != null) {
        if (assingUserDetailsReponse!.id != null) {
          emit(StopLoadingAssignUserDetailsState());
          emit(AssignUserDetailsSuccessState());
        }
      }
    } on api_client.ApiException catch (e) {
      emit(StopLoadingAssignUserDetailsState());
      emit(AssignUserDetailsFailureState(
          errorMessage: jsonDecode(e.message!)['errors'][0]));
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      emit(StopLoadingAssignUserDetailsState());
      emit(AssignUserDetailsFailureState(
          errorMessage: globals.appLang == 'en'
              ? "Something went wrong, please try later"
              : "حدث خطأ ما، يرجى المحاولة لاحقًا"));
    }
  }
}
