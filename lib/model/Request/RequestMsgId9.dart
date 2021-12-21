class RequestMsgId9 {
  int msgId;
  Properties properties;

  RequestMsgId9({this.msgId, this.properties});

  RequestMsgId9.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId9 setData(int msgId, int resetEnergy) {
    RequestMsgId9 requestMsgId9 = new RequestMsgId9();
    Properties properties = requestMsgId9.properties;
    properties.resetEnergy = resetEnergy;
    requestMsgId9.msgId = msgId;
    requestMsgId9.properties = properties;
    return requestMsgId9;
  }
}

class Properties {
  int resetEnergy;

  Properties({this.resetEnergy});

  Properties.fromJson(Map<String, dynamic> json) {
    resetEnergy = json['reset_energy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['reset_energy'] = this.resetEnergy;
    return data;
  }
}
