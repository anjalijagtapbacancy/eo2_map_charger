class ResponseMsgId34 {
  int msgId;
  Properties34 properties;

  ResponseMsgId34({this.msgId, this.properties});

  ResponseMsgId34.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties34.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_id'] = this.msgId;
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
}

class Properties34 {
  int status;
  int errorcode;
  String rFID;

  Properties34({this.errorcode, this.rFID, this.status});

  Properties34.fromJson(Map<String, dynamic> json) {
    errorcode = json['errorcode'];
    rFID = json['RFID'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['errorcode'] = this.errorcode;
    data['RFID'] = this.rFID;
    data['status'] = this.status;
    return data;
  }
}
