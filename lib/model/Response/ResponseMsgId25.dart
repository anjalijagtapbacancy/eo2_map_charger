class ResponseMsgId25 {
  int msgId;
  Properties25 properties;

  ResponseMsgId25({this.msgId,this.properties});

  ResponseMsgId25.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties25.fromJson(json['properties'])
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

class Properties25 {
  String ssid;
  String pwd;
  String iType;
  String appMode;
  String security;
  String apn;
  String gsmPass;
  String gsmType;
  String networkswitchmode;
  int status;

  Properties25(
      {this.ssid,
        this.pwd,
        this.iType,
        this.appMode,
        this.security,
        this.apn,
        this.gsmPass,
        this.gsmType,
        this.networkswitchmode,
        this.status});

  Properties25.fromJson(Map<String, dynamic> json) {
    ssid = json['ssid'];
    pwd = json['pwd'];
    iType = json['i_type'];
    appMode = json['app_mode'];
    security = json['security'];
    apn = json['apn'];
    gsmPass = json['gsm_pass'];
    gsmType = json['gsm_type'];
    networkswitchmode = json['network_switch_mode'];
    status = json['status'];
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
    data['network_switch_mode'] = this.networkswitchmode;
    data['status'] = this.status;
    return data;
  }
}
