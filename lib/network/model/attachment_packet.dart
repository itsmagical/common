

import 'package:common/network/model/attachment.dart';

///
/// 附件包模型
/// @author LiuHe
/// @created at 2021/9/10 15:17

class AttachmentPacket {
  /// 附件包id
  int? attachmentPacketId;
  /// 附件包内附件id
  List<int>? attachIds;
  /// 附件包内附件
  List<Attachment>? attachments;

  AttachmentPacket({this.attachmentPacketId, this.attachIds, this.attachments});

  AttachmentPacket.fromJson(Map<String, dynamic> json) {
    attachmentPacketId = json['attachmentPacketId'];
    attachIds = json['attachIds'].cast<int>();
    // if (json['attachIds'] != null) {
    //   attachIds = new List<int>();
    //   json['attachIds'].forEach((v) {
    //     attachIds.add(v);
    //   });
    // }
    if (json['attachments'] != null) {
      attachments = <Attachment>[];
      json['attachments'].forEach((v) {
        attachments!.add(new Attachment.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['attachmentPacketId'] = this.attachmentPacketId;
    data['attachIds'] = this.attachIds;
    if (this.attachIds != null) {
      data['attachIds'] = this.attachIds!.map((e) => e.toString()).toList();
    }
    if (this.attachments != null) {
      data['attachments'] = this.attachments!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
