
///
/// 附件模型
/// @author LiuHe
/// @created at 2021/9/10 15:10

class Attachment {
  /// 附加id
  int? dataId;
  /// 附件名称
  String? fileName;
  /// 附件路径
  String? storePath;
  /// 附件类型
  int? type;
  /// 附件大小
  int? size;
  /// 单位
  String? unit;
  /// 附件包id
  int? attachmentPacketId;
  String? fixedPath;

  Attachment(
      {this.dataId,
        this.fileName,
        this.storePath,
        this.type,
        this.size,
        this.unit,
        this.attachmentPacketId,
        this.fixedPath});

  Attachment.fromJson(Map<String, dynamic> json) {
    dataId = json['dataId'];
    fileName = json['fileName'];
    storePath = json['storePath'];
    type = json['type'];
    size = json['size'];
    unit = json['unit'];
    attachmentPacketId = json['attachmentPacketId'];
    fixedPath = json['fixedPath'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dataId'] = this.dataId;
    data['fileName'] = this.fileName;
    data['storePath'] = this.storePath;
    data['type'] = this.type;
    data['size'] = this.size;
    data['unit'] = this.unit;
    data['attachmentPacketId'] = this.attachmentPacketId;
    data['fixedPath'] = this.fixedPath;
    return data;
  }
}
