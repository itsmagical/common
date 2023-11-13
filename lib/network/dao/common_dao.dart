import 'dart:io';

import 'package:common/network/dao/base_dao.dart';
import 'package:common/network/model/attachment.dart';
import 'package:common/network/model/attachment_packet.dart';
import 'package:common/network/model/dictionary.dart';
import 'package:common/network/model/response.dart';
import 'package:common/network/network.dart';
import 'package:common/util/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


///
/// 老版本常用请求接口
/// 某些常用功能接口会分为老版本接口和新版本接口，使用时需主观区分
/// 老版本接口：定制化系统的接口
/// 新版本接口：功能模块组件化接口[NewCommonDao]
/// @author LiuHe
/// @created at 2021/9/10 10:30

class CommonDao extends BaseDao {

  CommonDao._();

  static CommonDao instance = CommonDao._();

  /// 查询字典值
  Future<MResponse> queryDictionaries({
    required String tabName,
    required String attribute,
    required Network network,
    Options? options
  }) async {
    String path = 'mobileAppBasicMgmt/deleteAttachment.do';
    Map<String, dynamic> params = getRequestJsonMap({
      'tableName': tabName,
      'attribute': attribute,
    });
    MResponse response = await network.post(path, data: params, options: options);

    if (response.success ?? false) {
      var data = response.data;
      if (data is List && Util.isNotEmpty(data)) {
        List<Dictionary> dictionaries = [];
        data.forEach((element) {
          dictionaries.add(Dictionary.fromJson(element));
        });
        response.data = dictionaries;
      }
    }

    return response;
  }

  /// 查询附件
  Future<MResponse> queryAttachments({
    required int attachmentPacketId,
    required Network network,
    Options? options
  }) async {
    String path = 'mobileAppBasicMgmt/listAttachments.do';
    Map<String, dynamic> params = getRequestJsonMap({
      'attachmentPacketId': attachmentPacketId
    });

    MResponse response = await network.post(path, data: params, options: options);

    if (response.success ?? false) {
      var data = response.data;
      if (data is List && Util.isNotEmpty(data)) {
        List<Attachment> attachments = [];
        data.forEach((element) {
          attachments.add(Attachment.fromJson(element));
        });
        response.data = attachments;
      }
    }

    return response;
  }

  /// 上传文件
  /// @param files 需上传的文件
  /// @param attachmentPacketId 附件包id，默认-1
  /// @param moduleType 文件所属功能模块类型
  /// @param network 执行本次上传的network，null则使用默认Network
  Future<MResponse> uploadFiles({
    required List<File> files,
    String? attachmentPacketId = '-1',
    required String moduleType,
    required Network network,
  }) async {
    String path = 'mobileAppBasicMgmt/uploadAttachments.do';
    var formData = FormData();
    for (int i = 0; i < files.length; i++) {
      String imagePath = files[i].path;
      String name =
      imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.length);
      var t = await MultipartFile.fromFile(imagePath, filename: name);
      var file = MapEntry('file', t);
      formData.files.add(file);
    }
    formData.fields
      ..add(MapEntry("attachmentPacketId", attachmentPacketId.toString()))
      ..add(MapEntry("moduleType", moduleType));

    MResponse response = await network.post(path, data: formData);
    if (response.success ?? false) {
      var data = response.data;
      if (data != null) {
        response.data = AttachmentPacket.fromJson(data);
      }
    }

    return response;
  }

  /// 删除附件
  /// @param attachmentId附件id
  /// @param network 执行本次上传的network，null则使用默认Network
  Future<MResponse> deleteAttachment({
    required int attachmentId,
    required Network network,
    Options? options
  }) async {
    String path = 'mobileAppBasicMgmt/deleteAttachment.do';
    Map<String, dynamic> params = getRequestJsonMap({
      'attachmentId': attachmentId
    });

    MResponse response = await network.post(path, data: params, options: options);
    return response;
  }

}