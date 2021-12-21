class ResponseMsgId19 {
  int msgId;
  Properties19 properties;

  ResponseMsgId19({this.msgId, this.properties});

  ResponseMsgId19.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties19.fromJson(json['properties'])
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

class Properties19 {
  int automode;
  int status;

  Properties19({this.automode, this.status});

  Properties19.fromJson(Map<String, dynamic> json) {
    automode = json['automode'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['automode'] = this.automode;
    data['status'] = this.status;
    return data;
  }
}
