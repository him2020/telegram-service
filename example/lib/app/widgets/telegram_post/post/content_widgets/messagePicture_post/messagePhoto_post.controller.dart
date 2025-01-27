import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:id_mvc_app_framework/framework.dart';
import 'package:telegram_service_example/app/model/message_info.dart';
import 'package:telegram_service/td_api.dart' as tdapi;
import 'dart:convert';

class MessagePhotoPostContentController extends MvcController {
  static const int IMAGE_READY_STATE = MvcController.NORMAL_STATE;
  static const int IMAGE_LOADING_STATE = MvcController.LOADING_STATE;
  static const int IMAGE_NOT_LOADED_STATE = -MvcController.LOADING_STATE;

  final TelegramChannelMessageInfo messsageInfo;

  Uint8List thumbnailBytes;

  tdapi.MessagePhoto get messageContent =>
      (messsageInfo.content as tdapi.MessagePhoto);

  MessagePhotoPostContentController(this.messsageInfo)
      : assert(messsageInfo.content is tdapi.MessagePhoto),
        super(startingState: IMAGE_NOT_LOADED_STATE);

  String get postText => messageContent.caption.text;

  double get aspectRatio => picWidth / picHeight;

  double get picWidth => messageContent.photo.minithumbnail.width.toDouble();
  double get picHeight => messageContent.photo.minithumbnail.height.toDouble();

  MemoryImage get minithumbnail {
    if (thumbnailBytes == null) {
      final thumbnailData = messageContent.photo.minithumbnail.data;
      thumbnailBytes = base64Decode(thumbnailData);
    }

    return MemoryImage(thumbnailBytes);
  }
}
