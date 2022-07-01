class RequestMsgId32 {
  int msgId;
  Properties properties;

  RequestMsgId32({this.msgId, this.properties});

  RequestMsgId32.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
        : null;
  }

  static RequestMsgId32 setData(int msgId, int action) {
    RequestMsgId32 requestMsgId32 = new RequestMsgId32();
    Properties properties = new Properties(action: action);
    requestMsgId32.msgId = msgId;
    requestMsgId32.properties = properties;
    return requestMsgId32;
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

class Properties {
  int action;

  Properties({this.action});

  Properties.fromJson(Map<String, dynamic> json) {
    action = json['action'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    return data;
  }
}
