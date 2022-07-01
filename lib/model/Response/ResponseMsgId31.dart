class ResponseMsgId31 {
  int msgId;
  Properties31 properties;

  ResponseMsgId31({this.msgId, this.properties});

  ResponseMsgId31.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties31.fromJson(json['properties'])
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

class Properties31 {
  int heartbeat;

  Properties31({this.heartbeat});

  Properties31.fromJson(Map<String, dynamic> json) {
    heartbeat = json['heartbeat'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['heartbeat'] = this.heartbeat;
    return data;
  }
}
