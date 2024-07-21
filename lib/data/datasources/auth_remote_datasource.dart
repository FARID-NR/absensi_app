import 'dart:convert';

import 'package:absensi_app/core/constants/server.dart';
// import 'package:absensi_app/core/extensions/cpu_memory_usage.dart';
import 'package:absensi_app/data/datasources/auth_local_datasource.dart';
import 'package:absensi_app/data/models/response/auth_response_model.dart';
import 'package:absensi_app/data/models/response/user_response_model.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
// import 'package:system_info2/system_info2.dart';

class AuthRemoteDatasource {
  Future<Either<String, AuthResponseModel>> login(String email, String password) async {
    final url = Uri.parse('${Variables.baseUrl}/api/login');
    final startTime = DateTime.now().millisecondsSinceEpoch; // Mulai pengukuran waktu
    // await CpuMemoryUsage().startLogging("Login");

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password
      }),
    );

     // Hitung durasi
     final endTime = DateTime.now().millisecondsSinceEpoch; // Akhir pengukuran waktu
      final duration = endTime - startTime;
      debugPrint('Request data Login took: $duration ms');
    //  await CpuMemoryUsage().stopLogging();
    
    if (response.statusCode == 200) {
      return Right(AuthResponseModel.fromJson(response.body));
    } else {
      return Left(response.body);
    }
  }

  // logout
  Future<Either<String, String>> logout() async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/logout');
    final startTime = DateTime.now().millisecondsSinceEpoch;

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}'
      },
    );

    final endTime = DateTime.now().millisecondsSinceEpoch;
    final duration = endTime - startTime;
    debugPrint('Request data Logout took: $duration ms');

    if (response.statusCode == 200) {
      return const Right('Logout Berhasil');
    } else {
      return Left(response.body);
    }
  }

  Future<Either<String, UserResponseModel>> updateProfileRegisterFace(
    String embedding,
  ) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/update-profile');
    final startTime = DateTime.now().millisecondsSinceEpoch;

    final request = http.MultipartRequest('POST', url)
      ..headers['Authorization'] = 'Bearer ${authData?.token}'
      ..fields['face_embedding'] = embedding;

    final response = await request.send();
    final responseString = await response.stream.bytesToString();

    final endTime = DateTime.now().millisecondsSinceEpoch;
    final duration = endTime - startTime;
    debugPrint('Request data Register took: $duration ms');

    if (response.statusCode == 200) {
      return Right(UserResponseModel.fromJson(responseString));
    } else {
      return const Left('Failed to update profile');
    }
  }

  Future<void> updateFcmToken(String fcmToken) async {
    final authData = await AuthLocalDatasource().getAuthData();
    final url = Uri.parse('${Variables.baseUrl}/api/update-fcm-token');
    await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${authData?.token}',
      },
      body: jsonEncode({
        'fcm_token': fcmToken,
      }),
    );
  }
  
}