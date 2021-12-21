class RequestMsgId10 {
  int msgId;
  Properties properties;

  RequestMsgId10({this.msgId, this.properties});

  RequestMsgId10.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId10 setData(int msgId, int startNumber, int endNumber) {
    RequestMsgId10 requestMsgId10 = new RequestMsgId10();
    Properties properties =
        new Properties(startNumber: startNumber, endNumber: endNumber);
    requestMsgId10.msgId = msgId;
    requestMsgId10.properties = properties;
    return requestMsgId10;
  }
}

class Properties {
  int startNumber;
  int endNumber;

  Properties({this.startNumber, this.endNumber});

  Properties.fromJson(Map<String, dynamic> json) {
    startNumber = json['start_number'];
    endNumber = json['end_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['start_number'] = this.startNumber;
    data['end_number'] = this.endNumber;
    return data;
  }
}
