class RequestMsgId35 {
  int msgId;
  String devId;
  Properties properties;

  RequestMsgId35({this.msgId, this.devId, this.properties});

  RequestMsgId35.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    devId = json['dev_id'];
    properties = json['properties'] != null
        ? new Properties.fromJson(json['properties'])
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

  static RequestMsgId35 setData(int msgId, int action , String idTag , String devId) {
    RequestMsgId35 requestMsgId35 = new RequestMsgId35();
    Properties properties = new Properties(action: action , idTag: idTag);
    requestMsgId35.msgId = msgId;
    requestMsgId35.devId = devId;
    requestMsgId35.properties = properties;
    return requestMsgId35;
  }

}

class Properties {
  int action;
  String idTag;

  Properties({this.action, this.idTag});

  Properties.fromJson(Map<String, dynamic> json) {
    action = json['action'];
    idTag = json['id_tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['action'] = this.action;
    data['id_tag'] = this.idTag;
    return data;
  }
}
