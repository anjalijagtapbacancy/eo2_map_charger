class ResponseMsgId27 {
  int msgId;
  Properties27 properties;

  ResponseMsgId27({this.msgId, this.properties});

  ResponseMsgId27.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties27.fromJson(json['properties'])
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

class Properties27 {
  String chargerName;
  int connectionType;
  int chargerCapacity;
  int chargerType;
  int status;

  Properties27(
      {this.chargerName,
        this.connectionType,
        this.chargerCapacity,
        this.chargerType,
        this.status});

  Properties27.fromJson(Map<String, dynamic> json) {
    chargerName = json['charger_name'];
    connectionType = json['connection_type'];
    chargerCapacity = json['charger_capacity'];
    chargerType = json['charger_type'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charger_name'] = this.chargerName;
    data['connection_type'] = this.connectionType;
    data['charger_capacity'] = this.chargerCapacity;
    data['charger_type'] = this.chargerType;
    data['status'] = this.status;
    return data;
  }
}
