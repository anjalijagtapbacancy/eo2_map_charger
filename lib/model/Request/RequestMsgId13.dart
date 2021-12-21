class RequestMsgId13 {
  int msgId;
  Properties properties;

  RequestMsgId13({this.msgId, this.properties});

  RequestMsgId13.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
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

  static RequestMsgId13 setData(int msgId, int maxCurrent) {
    RequestMsgId13 requestMsgId13 = new RequestMsgId13();
    Properties properties = new Properties(maxCurrent: maxCurrent);
    requestMsgId13.msgId = msgId;
    requestMsgId13.properties = properties;
    return requestMsgId13;
  }
}

class Properties {
  int maxCurrent;

  Properties({this.maxCurrent});

  Properties.fromJson(Map<String, dynamic> json) {
    maxCurrent = json['max_current'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['max_current'] = this.maxCurrent;
    return data;
  }
}
