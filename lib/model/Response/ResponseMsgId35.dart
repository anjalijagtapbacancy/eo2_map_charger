class ResponseMsgId35 {
  int msgId;
  String devId;
  Properties properties;

  ResponseMsgId35({this.msgId, this.devId, this.properties});

  ResponseMsgId35.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    devId = json['dev_id'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_id'] = this.msgId;
    data['dev_id'] = this.devId;
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
}

class Properties {
  int status;

  Properties({this.status});

  Properties.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}
