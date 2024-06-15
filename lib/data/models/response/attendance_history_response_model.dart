import 'dart:convert';

class AttendanceHistoryResponseModel {
    final String? message;
    final List<Attendance>? data;

    AttendanceHistoryResponseModel({
        this.message,
        this.data,
    });

    factory AttendanceHistoryResponseModel.fromJson(String str) => AttendanceHistoryResponseModel.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory AttendanceHistoryResponseModel.fromMap(Map<String, dynamic> json) => AttendanceHistoryResponseModel(
        message: json["message"],
        data: json["data"] == null ? [] : List<Attendance>.from(json["data"]!.map((x) => Attendance.fromMap(x))),
    );

    Map<String, dynamic> toMap() => {
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toMap())),
    };
}

class Attendance {
    final int? id;
    final int? userId;
    final DateTime? date;
    final String? timeIn;
    final dynamic timeOut;
    final String? latlonIn;
    final dynamic latlonOut;
    final DateTime? createdAt;
    final DateTime? updatedAt;

    Attendance({
        this.id,
        this.userId,
        this.date,
        this.timeIn,
        this.timeOut,
        this.latlonIn,
        this.latlonOut,
        this.createdAt,
        this.updatedAt,
    });

    factory Attendance.fromJson(String str) => Attendance.fromMap(json.decode(str));

    String toJson() => json.encode(toMap());

    factory Attendance.fromMap(Map<String, dynamic> json) => Attendance(
        id: json["id"],
        userId: json["user_id"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        timeIn: json["time_in"],
        timeOut: json["time_out"],
        latlonIn: json["latlon_in"],
        latlonOut: json["latlon_out"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "user_id": userId,
        "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "time_in": timeIn,
        "time_out": timeOut,
        "latlon_in": latlonIn,
        "latlon_out": latlonOut,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
