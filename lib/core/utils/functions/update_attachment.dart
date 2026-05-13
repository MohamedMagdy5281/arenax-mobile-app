import 'dart:convert';
import 'dart:io';
import 'package:praktika_clone_app/client/api.dart';
import 'package:praktika_clone_app/core/utils/cashe_helper.dart';
import 'package:praktika_clone_app/core/utils/globals.dart' as globals;
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:path/path.dart';
import 'package:praktika_clone_app/client/api.dart' as api_client;

Future<UpdateAttachmentResponse?> updateAttachment(
    File imageFile, String attachmentId) async {
  try {
    // Open a byteStream
    var stream = http.ByteStream(imageFile.openRead());
    stream.cast();
    // Get file length
    var length = await imageFile.length();

    // String to URI
    var uri = Uri.parse(
        "https://befluent.trust2s.com/api/Attachments/update-attachment");
    // Create multipart request
    var request = http.MultipartRequest("POST", uri);

    // Multipart that takes file
    var multipartFile = http.MultipartFile('file', stream, length,
        filename: basename(imageFile.path));

    // Add file to multipart
    // Add authorization token to headers
    request.files.add(multipartFile);
    request.fields['AttachmentId'] = attachmentId;
    var headers = {
      'Authorization': "Bearer ${CasheHelper.token ?? ""}",
      //'Accept-Language' : globals.appLang == 'en' ? "en-US" : "ar-SA",
    };
    request.headers.addAll(headers);
    // Send request
    var r = await request.send();
    Response response = await Response.fromStream(r);
    // Check response status code
    if (kDebugMode) {
      print('Response status code: ${response.statusCode}');
    }

    if (response.statusCode == 401) {
      api_client.CreateRefreshTokenRequest tokenRequestDto =
          CreateRefreshTokenRequest();
      tokenRequestDto.userId = CasheHelper.user?.id;
      tokenRequestDto.refreshToken = CasheHelper.refreshToken;
      tokenRequestDto.os = globals.os;
      tokenRequestDto.version = globals.version;
      AuthenticationApi authenticationApi = AuthenticationApi();
      CreateRefreshTokenResponse? tokenResponse = await authenticationApi
          .apiAuthenticationRefreshTokenPost(body: tokenRequestDto);

      final context = globals.navigatorKey.currentContext;

      if (tokenResponse?.needUpdate == true) {
        globals.showUpdateDialog(context!, tokenResponse.updateUrl!);
      } else {
        CasheHelper.token = tokenResponse.accessToken!;
        CasheHelper.refreshToken = tokenResponse.refreshToken!;
        CasheHelper.addStringToSS('token', tokenResponse.accessToken);
        CasheHelper.addStringToSS('refreshToken', tokenResponse.refreshToken);

        // ✅ Access instance members, not class

        updateAttachment(imageFile, attachmentId);
      }
    }
    if (response.statusCode >= 400) {
      throw ApiException(response.statusCode, response.body);
    } else {
      var decodedJson = json.decode(response.body);
      return UpdateAttachmentResponse.fromJson(decodedJson);
    }
  } catch (e) {
    // Handle exceptions
    if (kDebugMode) {
      print(e);
    }
    return null;
  }
}
