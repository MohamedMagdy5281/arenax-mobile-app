import 'package:arenax_mobile_app/core/utils/cashe_helper.dart';
import 'package:arenax_mobile_app/core/utils/functions/success_failure_alert.dart';
import 'package:arenax_mobile_app/core/utils/l10n/app_localizations.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/edit_profile_view.dart';
import 'package:arenax_mobile_app/features/Profile/presentation/views/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dart:io';
import 'package:arenax_mobile_app/core/utils/globals.dart' as globals;

part 'edit_profile_notifier_provider.g.dart';

class EditProfileState {
  final bool isPageLoading;
  final File? selectedImage;
  final bool cameraPermission;
  final bool galleryPermission;
  final String? profilePictureId;

  const EditProfileState({
    this.isPageLoading = false,
    this.selectedImage,
    this.cameraPermission = false,
    this.galleryPermission = false,
    this.profilePictureId,
  });

  EditProfileState copyWith({
    bool? isPageLoading,
    File? selectedImage,
    bool? cameraPermission,
    bool? galleryPermission,
    String? profilePictureId,
  }) {
    return EditProfileState(
      isPageLoading: isPageLoading ?? this.isPageLoading,
      selectedImage: selectedImage ?? this.selectedImage,
      cameraPermission: cameraPermission ?? this.cameraPermission,
      galleryPermission: galleryPermission ?? this.galleryPermission,
      profilePictureId: profilePictureId ?? this.profilePictureId,
    );
  }
}

@riverpod
class EditProfileNotifier extends _$EditProfileNotifier {
  @override
  EditProfileState build() {
    return EditProfileState(
      selectedImage: CasheHelper.selectedImage,
    );
  }

  void setPageLoading(bool isLoading) {
    state = state.copyWith(isPageLoading: isLoading);
  }

  // api_client.AddAttachmentResponse? createAttachmentResponse;

  // Future<void> uploadImage({
  //   required File image,
  // }) async {
  //   setPageLoading(true);

  //   try {
  //     createAttachmentResponse = await uploadAttachment(image);

  //     if (createAttachmentResponse != null) {
  //       state = state.copyWith(
  //         profilePictureId: createAttachmentResponse!.id,
  //       );

  //       CasheHelper.user!.profilePictureId = createAttachmentResponse!.id;

  //       await assignProfilePicture(
  //         createAttachmentResponse!.id!,
  //       );

  //       globals.isHomePicUpdate = true;
  //       globals.isProfilePicUpdate = true;
  //     }
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }

  //   setPageLoading(false);
  // }

  // api_client.UpdateUserResponse? response;

  // Future<void> assignProfilePicture(String imageId) async {
  //   final model = api_client.UpdateUserRequest()..profilePictureId = imageId;

  //   final api = api_client.UserApi();

  //   try {
  //     response = await api.apiUserUpdateUserPost(
  //       body: model,
  //     );
  //   } catch (e) {
  //     if (kDebugMode) {
  //       print(e);
  //     }
  //   }
  // }

  Future<void> getCameraPermission(
    BuildContext context,
  ) async {
    final status = await Permission.camera.status;

    if (status.isDenied || status.isRestricted || status.isPermanentlyDenied) {
      final result = await Permission.camera.request();

      if (result.isGranted) {
        state = state.copyWith(
          cameraPermission: true,
        );
      } else if (result.isPermanentlyDenied) {
        _showCameraAppSettingsDialog(context);
      } else {
        successFailureAlert(
          context,
          message: AppLocalizations.of(context)!.qrPermissionError,
          isError: true,
        );
      }
    } else {
      state = state.copyWith(
        cameraPermission: true,
      );
    }
  }

  Future<void> pickCameraImage(
    BuildContext context,
  ) async {
    await getCameraPermission(context);

    if (!state.cameraPermission) return;

    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.camera,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 100,
      maxHeight: 480,
      maxWidth: 640,
    );

    if (pickedImage == null) return;

    setPageLoading(true);

    final appDir = await getApplicationDocumentsDirectory();

    final savedImage = await File(
      pickedImage.path,
    ).copy(
      '${appDir.path}/${pickedImage.name}',
    );

    state = state.copyWith(
      selectedImage: savedImage,
    );

    // await uploadImage(
    //   image: savedImage,
    // );

    setPageLoading(false);
  }

  Future<void> pickGalleryImage(
    BuildContext context,
  ) async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage == null) return;

    setPageLoading(true);

    final appDir = await getApplicationDocumentsDirectory();

    final savedImage = await File(
      pickedImage.path,
    ).copy(
      '${appDir.path}/${pickedImage.name}',
    );

    state = state.copyWith(
      selectedImage: savedImage,
    );

    // await uploadImage(
    //   image: savedImage,
    // );

    setPageLoading(false);
  }

  Future<void> removeImage(
    BuildContext context,
  ) async {
    state = EditProfileState(
      isPageLoading: state.isPageLoading,
      cameraPermission: state.cameraPermission,
      galleryPermission: state.galleryPermission,
      profilePictureId: state.profilePictureId,
      selectedImage: null,
    );

    // await uploadImage(
    //   image: savedImage,
    // );

    setPageLoading(false);
  }

  void _showCameraAppSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.permissionRequired),
        content: Text(AppLocalizations.of(context)!.cameraPermissionSettings),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close the bottom sheet
            },
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          TextButton(
            onPressed: () async {
              await openAppSettings();
              globals.navigatorKey.currentState!
                  .pushReplacementNamed(EditProfileView.id);
            },
            child: Text(AppLocalizations.of(context)!.settings),
          ),
        ],
      ),
    );
  }

  void resetChanges() {
    state = state.copyWith(
      selectedImage: CasheHelper.selectedImage,
    );
  }

  // Future<void> clearCache() async {
  //   if (globals.isProfilePicUpdate) {
  //     imageCache.clear();
  //     imageCache.clearLiveImages();

  //     globals.isProfilePicUpdate = false;
  //   }
  // }
}
