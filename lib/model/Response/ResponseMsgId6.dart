class ResponseMsgId6 {
  int msgId;
  Properties6 properties;

  ResponseMsgId6({this.msgId, this.properties});

  ResponseMsgId6.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties6.fromJson(json['properties'])
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

class Properties6 {
  num current;
  num voltage;
  num power;
  num sessionEnergy;
  int status;

  Properties6(
      {this.current,
      this.voltage,
      this.power,
      this.sessionEnergy,
      this.status});

  Properties6.fromJson(Map<String, dynamic> json) {
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
