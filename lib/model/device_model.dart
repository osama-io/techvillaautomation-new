class DeviceData {
  int? r1;
  int? r2;
  int? r3;
  int? r4;
  int? r5;
  int? r6;
  int? r7;
  int? fan;
  int? power;

  DeviceData(
      {this.r1,
        this.r2,
        this.r3,
        this.r4,
        this.r5,
        this.r6,
        this.r7,
        this.fan,
        this.power});

  DeviceData.fromJson(Map<String, dynamic> json) {
    r1 = json['R1'];
    r2 = json['R2'];
    r3 = json['R3'];
    r4 = json['R4'];
    r5 = json['R5'];
    r6 = json['R6'];
    r7 = json['R7'];
    fan = json['fan'];
    power = json['power'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['R1'] = this.r1;
    data['R2'] = this.r2;
    data['R3'] = this.r3;
    data['R4'] = this.r4;
    data['R5'] = this.r5;
    data['R6'] = this.r6;
    data['R7'] = this.r7;
    data['fan'] = this.fan;
    data['power'] = this.power;
    return data;
  }
}
