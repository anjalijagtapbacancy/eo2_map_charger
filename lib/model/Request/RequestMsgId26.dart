class RequestMsgId26 {
  int msgId;
  Properties properties;

  RequestMsgId26({this.msgId, this.properties});

  RequestMsgId26.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId26 setData(int msgId, String chargername, String chargertype, String chargercapacity, String connectiontype) {
    RequestMsgId26 requestMsgId26 = new RequestMsgId26();
    Properties properties = new Properties(
        chargerName: chargername,
        chargerType: chargertype=="Single Phase"?1:3,
        chargerCapacity: chargercapacity=="16 A"?16:32,
        connectionType: connectiontype=="Socket"?1:2,);
    requestMsgId26.msgId = msgId;
    requestMsgId26.properties = properties;
    return requestMsgId26;
  }
}

class Properties {
  String chargerName;
  int connectionType;
  int chargerCapacity;
  int chargerType;

  Properties(
      {this.chargerName,
        this.connectionType,
        this.chargerCapacity,
        this.chargerType});

  Properties.fromJson(Map<String, dynamic> json) {
    chargerName = json['charger_name'];
    connectionType = json['connection_type'];
    chargerCapacity = json['charger_capacity'];
    chargerType = json['charger_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['charger_name'] = this.chargerName;
    data['connection_type'] = this.connectionType;
    data['charger_capacity'] = this.chargerCapacity;
    data['charger_type'] = this.chargerType;
    return data;
  }
}
