class ResponseMsgId10 {
  int msgId;
  String devId;
  Properties10 properties;

  ResponseMsgId10({this.msgId, this.devId, this.properties});

  ResponseMsgId10.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    devId = json['dev_id'];
    properties = json['properties'] != null
        ? new Properties10.fromJson(json['properties'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['msg_id'] = this.msgId;
    data['dev_id'] = this.devId;
    if (this.properties != null) {
      data['properties'] = this.properties.toJson();
    }
    return data;
  }
}

class Properties10 {
  List<Array10> array;
  int status;

  Properties10({this.array, this.status});

  Properties10.fromJson(Map<String, dynamic> json) {
    if (json['array'] != null) {
      array = new List<Array10>();
      json['array'].forEach((v) {
        array.add(new Array10.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.array != null) {
      data['array'] = this.array.map((v) => v.toJson()).toList();
    }
    data['status'] = this.status;
    return data;
  }
}

class Array10 {
  int id;
  int event;
  int time;
  int duration;
  int sessionEnergy;
  int mode;
  String username;

  Array10(
      {this.id,
      this.event,
      this.time,
      this.duration,
      this.sessionEnergy,
      this.mode , this.username});

  Array10.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    event = json['event'];
    time = json['time'];
    duration = json['duration'];
    sessionEnergy = json['session_energy'];
    mode = json['mode'];
    username = json['user_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event'] = this.event;
    data['time'] = this.time;
    data['duration'] = this.duration;
    data['session_energy'] = this.sessionEnergy;
    data['mode'] = this.mode;
    data['user_name'] = this.username;
    return data;
  }
}
