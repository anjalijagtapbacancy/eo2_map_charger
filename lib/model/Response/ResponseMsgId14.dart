class ResponseMsgId14 {
  int msgId;
  Properties14 properties;

  ResponseMsgId14({this.msgId, this.properties});

  ResponseMsgId14.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties14.fromJson(json['properties'])
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

class Properties14 {
  int maxCurrent;
  int status;

  Properties14({this.maxCurrent, this.status});

  Properties14.fromJson(Map<String, dynamic> json) {
    maxCurrent = json['max_current'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max_current'] = this.maxCurrent;
    data['status'] = this.status;
    return data;
  }
}
