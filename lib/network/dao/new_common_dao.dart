import 'dart:io';

import 'package:common/network/dao/base_dao.dart';
import 'package:common/network/dao/common_dao.dart';
import 'package:common/network/model/attachment.dart';
import 'package:common/network/model/dictionary.dart';
import 'package:common/network/model/response.dart';
import 'package:common/network/network.dart';
import 'package:common/util/util.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';


///
/// 常用请求接口(新版本接口)
/// 某些常用功能接口会分为老版本接口和新版本接口，使用时需主观区分
/// 老版本接口：定制化系统的接口[CommonDao]
/// 新版本接口：功能模块组件化接口
/// @author LiuHe
/// @created at 2021/9/10 10:30

class NewCommonDao extends BaseDao {

  NewCommonDao._();

  static NewCommonDao instance = NewCommonDao._();

  /// 查询字典值
  /// @param type
  Future<MResponse> queryDictionaries({
    @required String type,
    @required Network network,
    Options options,
  }) async {
    String path = 'dictDataMgmt/listDictionarys.do';
    Map<String, dynamic> params = {
      'type': type,
    };
    MResponse response = await network.post(path, data: params, options: options);

    if (response.success) {
      var data = response.data;
      if (data is List && Util.isNotEmpty(data)) {
        List<Dictionary> dictionaries = [];
        data.forEach((element) {
          dictionaries.add(Dictionary.fromJson(element));
        });
        response.data =  dictionaries;
      }
    }

    return response;
  }

  /// 查询附件包内的附件
  /// @param attachmentPacketId
  Future<MResponse> queryAttachments({
    @required int attachmentPacketId,
    @required Network network,
  }) async {
    String path = 'attachMgmt/listAttachments.do';
    Map<String, dynamic> params = {
      'attachmentPacketId': attachmentPacketId
    };

    MResponse response = await network.post(path, data: params,
        options: Options(contentType: Headers.formUrlEncodedContentType));

    if (response.success) {
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
    @required List<File> files,
    int attachmentPacketId = -1,
    String moduleType,
    @required Network network,
  }) async {
    String path = 'attachMgmt/multipleFileUpload.do';
    var formData = FormData();
    for (int i = 0; i < files.length; i++) {
      String imagePath = files[i].path;
      String name =
      imagePath.substring(imagePath.lastIndexOf("/") + 1, imagePath.length);
      var t = await MultipartFile.fromFile(imagePath, filename: name);
      var file = MapEntry('multiFile', t);
      formData.files.add(file);
    }
    formData.fields
      ..add(MapEntry("attachmentPacketId", attachmentPacketId.toString()))
      ..add(MapEntry("moduleType", moduleType));

    MResponse response = await network.post(path, data: formData);
    if (response.success) {
      var data = response.data;
      if (data != null) {
        /// 多文件上传成功后，后台只返回一个附件的信息，而不是上传的附件集合
        /// 无法转换为AttachmentPacket
        response.data = Attachment.fromJson(data);
//        response.data = AttachmentPacket.fromJson(data);
      }
    }

    return response;
  }

  /// 删除附件包内的所有附件
  /// @param attachmentId附件id
  /// @param network 执行本次上传的network，null则使用默认Network
  Future<MResponse> deleteAttachments({
    @required int attachmentPacketId,
    @required Network network,
    Options options
  }) async {
    String path = 'attachMgmt/deleteAttachments.do';
    Map<String, dynamic> params = {
      'attachmentPacketId': attachmentPacketId
    };

    MResponse response = await network.post(path, data: params, options: options);
    return response;
  }

  /// 删除附件
  /// @param dataIds 附件id
  /// @param network 执行本次上传的network，null则使用默认Network
  Future<MResponse> deleteAttachment({
    @required String dataIds,
    @required Network network,
    Options options
  }) async {
    String path = 'attachMgmt/deleteOnlyAttach.do';
    Map<String, dynamic> params = {
      'dataIds': dataIds
    };

    MResponse response = await network.post(path, data: params, options: options);
    return response;
  }

}