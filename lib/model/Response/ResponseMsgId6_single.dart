class ResponseMsgId6Single {
  int msgId;
  Properties6Single properties;

  ResponseMsgId6Single({this.msgId, this.properties});

  ResponseMsgId6Single.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties6Single.fromJson(json['properties'])
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

class Properties6Single {
  num current;
  num voltage;
  num power;
  num sessionEnergy;
  int status;

  Properties6Single(
      {this.current,
        this.voltage,
        this.power,
        this.sessionEnergy,
        this.status});

  Properties6Single.fromJson(Map<String, dynamic> json) {
    current = json['current'];
    voltage = json['voltage'];
    power = json['power'];
    sessionEnergy = json['session_energy'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current'] = this.current;
    data['voltage'] = this.voltage;
    data['power'] = this.power;
    data['session_energy'] = this.sessionEnergy;
    data['status'] = this.status;
    return data;
  }
}
