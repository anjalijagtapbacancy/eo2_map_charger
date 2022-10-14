class RequestMsgId28 {
  int msgId;
  Properties properties;

  RequestMsgId28({this.msgId, this.properties});

  RequestMsgId28.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId28 setData(int msgId, String url) {
    RequestMsgId28 requestMsgId28 = new RequestMsgId28();
    Properties properties = new Properties(url: url);
    requestMsgId28.msgId = msgId;
    requestMsgId28.properties = properties;
    return requestMsgId28;
  }

}

class Properties {
  String url;

  Properties({this.url});

  Properties.fromJson(Map<String, dynamic> json) {
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    return data;
  }
}
