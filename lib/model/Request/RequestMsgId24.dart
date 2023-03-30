class RequestMsgId24 {
  int msgId;
  Properties properties;

  RequestMsgId24({this.msgId, this.properties});

  RequestMsgId24.fromJson(Map<String, dynamic> json) {
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

  static RequestMsgId24 setData(
      int msgId,
      String ssid,
      String pwd,
      String iType,
      String appMode,
      String security,
      String apn,
      String gsmPass,
      String gsmType,
      String networkswitchmode) {
    RequestMsgId24 requestMsgId24 = new RequestMsgId24();
    Properties properties = new Properties(
        ssid: ssid,
        pwd: pwd,
        iType: iType=="WIFI"?"1":"2",
        appMode: appMode,
        security: security,
        apn: apn,
        gsmPass: gsmPass,
        gsmType: gsmType,
        networkswitchmode: networkswitchmode);
    requestMsgId24.msgId = msgId;
    requestMsgId24.properties = properties;
    return requestMsgId24;
  }
}

class Properties {
  String ssid;
  String pwd;
  String iType;
  String appMode;
  String security;
  String apn;
  String gsmPass;
  String gsmType;
  String networkswitchmode;

  Properties(
      {this.ssid,
      this.pwd,
      this.iType,
      this.appMode,
      this.security,
      this.apn,
      this.gsmPass,
      this.networkswitchmode,
      this.gsmType});

  Properties.fromJson(Map<String, dynamic> json) {
    ssid = json['ssid'];
    pwd = json['pwd'];
    iType = json['i_type'];
    appMode = json['app_mode'];
    security = json['security'];
    apn = json['apn'];
    gsmPass = json['gsm_pass'];
    gsmType = json['gsm_type'];
    networkswitchmode = json['network_switching'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ssid'] = this.ssid;
    data['pwd'] = this.pwd;
    data['i_type'] = this.iType;
    data['app_mode'] = this.appMode;
    data['security'] = this.security;
    data['apn'] = this.apn;
    data['gsm_pass'] = this.gsmPass;
    data['gsm_type'] = this.gsmType;
    data['network_switching'] = this.networkswitchmode;
    return data;
  }
}
