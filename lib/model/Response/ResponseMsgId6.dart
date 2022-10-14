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
  int status;
  List<Array6> array;

  Properties6({this.status, this.array});

  Properties6.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['array'] != null) {
      array = <Array6>[];
      json['array'].forEach((v) {
        array.add(new Array6.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.array != null) {
      data['array'] = this.array.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Array6 {
  String phase;
  num voltage;
  num current;
  num power;
  num sessionEnergy;

  Array6(
      {this.phase, this.voltage, this.current, this.power, this.sessionEnergy});

  Array6.fromJson(Map<String, dynamic> json) {
    phase = json['Phase '];
    voltage = json['voltage'];
    current = json['current'];
    power = json['power'];
    sessionEnergy = json['session_energy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Phase '] = this.phase;
    data['voltage'] = this.voltage;
    data['current'] = this.current;
    data['power'] = this.power;
    data['session_energy'] = this.sessionEnergy;
    return data;
  }
}
