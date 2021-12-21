class RequestMsgId1 {
  int msgId;
  Properties properties;

  RequestMsgId1({this.msgId, this.properties});

  RequestMsgId1.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId1 setData(int msgId, int time) {
    RequestMsgId1 requestMsgId1 = new RequestMsgId1();
    Properties property = new Properties(sysEpoch: time);
    requestMsgId1.msgId = msgId;
    requestMsgId1.properties = property;
    return requestMsgId1;
  }
}

class Properties {
  int sysEpoch;

  Properties({this.sysEpoch});

  Properties.fromJson(Map<String, dynamic> json) {
    sysEpoch = json['sys_epoch'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sys_epoch'] = this.sysEpoch;
    return data;
  }
}
