class Servicemodel {
  int? status;
  String? message;
  List<Payload>? payload;

  Servicemodel({this.status, this.message, this.payload});

  Servicemodel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['payload'] != null) {
      payload = <Payload>[];
      json['payload'].forEach((v) {
        payload!.add(Payload.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (payload != null) {
      data['payload'] = payload!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Payload {
  String? id;
  String? name;
  String? city;
  String? state;
  String? country;
  String? serviceTypeName;
  String? imageHash;

  Payload(
      {this.id,
      this.name,
      this.city,
      this.state,
      this.country,
      this.serviceTypeName,
      this.imageHash});

  Payload.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
    serviceTypeName = json['serviceTypeName'];
    imageHash = json['imageHash'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['city'] = city;
    data['state'] = state;
    data['country'] = country;
    data['serviceTypeName'] = serviceTypeName;
    data['imageHash'] = imageHash;
    return data;
  }
}
