class Datsmodel {
  String? orgServiceItemId;
  String? userId;
  String? signature;
  int? validityUpto;
  String? orderId;

  Datsmodel(
      {this.orgServiceItemId,
      this.userId,
      this.signature,
      this.validityUpto,
      this.orderId});

  Datsmodel.fromJson(Map<String, dynamic> json) {
    orgServiceItemId = json['orgServiceItemId'];
    userId = json['userId'];
    signature = json['signature'];
    validityUpto = json['validityUpto'];
    orderId = json['orderId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['orgServiceItemId'] = orgServiceItemId;
    data['userId'] = userId;
    data['signature'] = signature;
    data['validityUpto'] = validityUpto;
    data['orderId'] = orderId;
    return data;
  }
}
