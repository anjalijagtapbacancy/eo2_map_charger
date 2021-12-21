class RequestMsgId3 {
  int msgId;
  Properties properties;

  RequestMsgId3({this.msgId, this.properties});

  RequestMsgId3.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId3 setData(int msg_id, int chargingStartStop) {
    RequestMsgId3 requestMsgId3 = new RequestMsgId3();
    Properties properties =
        new Properties(chargingStartStop: chargingStartStop);
    requestMsgId3.msgId = msg_id;
    requestMsgId3.properties = properties;
    return requestMsgId3;
  }
}

class Properties {
  int chargingStartStop;

  Properties({this.chargingStartStop});

  Properties.fromJson(Map<String, dynamic> json) {
    chargingStartStop = json['charging_start_stop'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charging_start_stop'] = this.chargingStartStop;
    return data;
  }
}
