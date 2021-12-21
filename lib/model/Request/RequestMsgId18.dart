class RequestMsgId18 {
  int msgId;
  Properties properties;

  RequestMsgId18({this.msgId, this.properties});

  RequestMsgId18.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId18 setData(int msgId, int automode) {
    RequestMsgId18 requestMsgId18 = new RequestMsgId18();
    Properties properties = new Properties(automode: automode);
    requestMsgId18.msgId = msgId;
    requestMsgId18.properties = properties;
    return requestMsgId18;
  }
}

class Properties {
  int automode;

  Properties({this.automode});

  Properties.fromJson(Map<String, dynamic> json) {
    automode = json['automode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['automode'] = this.automode;
    return data;
  }
}
