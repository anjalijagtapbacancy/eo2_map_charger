class RequestMsgId12 {
  int msgId;
  Properties properties;

  RequestMsgId12({this.msgId, this.properties});

  RequestMsgId12.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId12 setData(int msgId, int type) {
    RequestMsgId12 requestMsgId12 = new RequestMsgId12();
    Properties properties = new Properties(type: type);
    requestMsgId12.msgId = msgId;
    requestMsgId12.properties = properties;
    return requestMsgId12;
  }
}

class Properties {
  int type;

  Properties({this.type});

  Properties.fromJson(Map<String, dynamic> json) {
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    return data;
  }
}
