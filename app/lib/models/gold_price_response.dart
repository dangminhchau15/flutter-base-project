// To parse this JSON data, do
//
//     final goldPriceResponse = goldPriceResponseFromJson(jsonString);

import 'dart:convert';

GoldPriceResponse goldPriceResponseFromJson(String str) => GoldPriceResponse.fromJson(json.decode(str));

String goldPriceResponseToJson(GoldPriceResponse data) => json.encode(data.toJson());

class GoldPriceResponse {
    GoldPriceResponse({
        this.data,
        this.error,
        this.success,
    });

    List<Datum> data;
    dynamic error;
    bool success;

    factory GoldPriceResponse.fromJson(Map<String, dynamic> json) => GoldPriceResponse(
        data: json["data"] == null ? null : List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        error: json["error"],
        success: json["success"] == null ? null : json["success"],
    );

    Map<String, dynamic> toJson() => {
        "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
        "error": error,
        "success": success == null ? null : success,
    };
}

class Datum {
    Datum({
        this.type,
        this.name,
        this.city,
        this.buyPrice,
        this.sellPrice,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
    });

    Type type;
    String name;
    String city;
    int buyPrice;
    int sellPrice;
    DateTime createdAt;
    DateTime updatedAt;
    dynamic deletedAt;

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        type: json["Type"] == null ? null : typeValues.map[json["Type"]],
        name: json["Name"] == null ? null : json["Name"],
        city: json["City"] == null ? null : json["City"],
        buyPrice: json["BuyPrice"] == null ? null : json["BuyPrice"],
        sellPrice: json["SellPrice"] == null ? null : json["SellPrice"],
        createdAt: json["CreatedAt"] == null ? null : DateTime.parse(json["CreatedAt"]),
        updatedAt: json["UpdatedAt"] == null ? null : DateTime.parse(json["UpdatedAt"]),
        deletedAt: json["DeletedAt"],
    );

    Map<String, dynamic> toJson() => {
        "Type": type == null ? null : typeValues.reverse[type],
        "Name": name == null ? null : name,
        "City": city == null ? null : city,
        "BuyPrice": buyPrice == null ? null : buyPrice,
        "SellPrice": sellPrice == null ? null : sellPrice,
        "CreatedAt": createdAt == null ? null : createdAt.toIso8601String(),
        "UpdatedAt": updatedAt == null ? null : updatedAt.toIso8601String(),
        "DeletedAt": deletedAt,
    };
}

enum Type { SJC, DOJI, PNJ, BO_TN_MINH_CHU, PH_QU }

final typeValues = EnumValues({
    "bảo tín minh châu": Type.BO_TN_MINH_CHU,
    "doji": Type.DOJI,
    "phú quý": Type.PH_QU,
    "pnj": Type.PNJ,
    "sjc": Type.SJC
});

class EnumValues<T> {
    Map<String, T> map;
    Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        if (reverseMap == null) {
            reverseMap = map.map((k, v) => new MapEntry(v, k));
        }
        return reverseMap;
    }
}
