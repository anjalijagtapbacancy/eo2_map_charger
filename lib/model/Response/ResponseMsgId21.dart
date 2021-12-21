class ResponseMsgId21 {
  int msgId;
  Properties21 properties;

  ResponseMsgId21({this.msgId, this.properties});

  ResponseMsgId21.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties21.fromJson(json['properties'])
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

class Properties21 {
  String devId;
  int status;

  Properties21({this.devId, this.status});

  Properties21.fromJson(Map<String, dynamic> json) {
    devId = json['dev_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dev_id'] = this.devId;
    data['status'] = this.status;
    return data;
  }
}
