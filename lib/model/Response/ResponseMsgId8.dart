class ResponseMsgId8 {
  int msgId;
  Properties8 properties;

  ResponseMsgId8({this.msgId, this.properties});

  ResponseMsgId8.fromJson(Map<String, dynamic> json) {
    msgId = json['msg_id'];
    properties = json['properties'] != null
        ? new Properties8.fromJson(json['properties'])
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

class Properties8 {
  num sysTime;
  num evConnectionStatus;
  num totalEnergy;
  num evChargingState;
  int status;
  int chargingFaultState;

  Properties8(
      {this.sysTime,
      this.evConnectionStatus,
      this.totalEnergy,
      this.evChargingState,
      this.status,
      this.chargingFaultState});

  Properties8.fromJson(Map<String, dynamic> json) {
    sysTime = json['sys_time'];
    evConnectionStatus = json['ev_connection_status'];
    totalEnergy = json['total_energy'];
    evChargingState = json['ev_charging_state'];
    status = json['status'];
    chargingFaultState = json['ev_error_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sys_time'] = this.sysTime;
    data['ev_connection_status'] = this.evConnectionStatus;
    data['total_energy'] = this.totalEnergy;
    data['ev_charging_state'] = this.evChargingState;
    data['status'] = this.status;
    data['ev_error_code'] = this.chargingFaultState;
    return data;
  }
}
