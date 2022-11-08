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

  static RequestMsgId3 setData(int msg_id, int chargingStartStop ,String userName) {
    RequestMsgId3 requestMsgId3 = new RequestMsgId3();
    Properties properties =
        new Properties(chargingStartStop: chargingStartStop , username: userName);
    requestMsgId3.msgId = msg_id;
    requestMsgId3.properties = properties;
    return requestMsgId3;
  }
}

class Properties {
  int chargingStartStop;
  String username;

  Properties({this.chargingStartStop, this.username});

  Properties.fromJson(Map<String, dynamic> json) {
    chargingStartStop = json['charging_start_stop'];
    username = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charging_start_stop'] = this.chargingStartStop;
    data['user_name'] = this.username;
    return data;
  }
}
