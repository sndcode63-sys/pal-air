import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:pal_air/Screens/Auth/technician_model.dart';

import '../../Utils/app_base_api_services.dart';
import '../../Utils/app_exceptions.dart';
import '../../Utils/app_failure.dart';
import '../../Utils/app_network_api_services.dart';
import '../../Utils/common_functions.dart';
import '../../Utils/local_shared_preferences.dart';
import '../../Utils/remote_urls.dart';

class AuthRepository {
  BaseApiService apiService = NetworkAPIService();
  Future<Either<Failure, dynamic>> loginUser(data, context) async {
    try {
      var response = await apiService.loginRegisterApiResponse(
          RemoteUrls.loginUrl, data, context);
      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, TechnicianModel>> getProfile(context) async {
    TechnicianModel technicianModel = await CommonFunctions().getProfileData();
    try {
      var response = await apiService.getGetApiResponse(
          "${RemoteUrls.getProfile}?fe_id=${technicianModel.id}", context);
      String profileData = jsonEncode(response['data'][0]);
      await LocalPreferences().setProfileData(profileData);

      return right(TechnicianModel.fromJson(response['data'][0]));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateProfile(context, data) async {
    try {
      var response = await apiService.dioApiResponse(
          RemoteUrls.updateProfile, data, context);

      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<TechnicianListModel>>> getTechnicianList({
    required BuildContext context,
  }) async {
    try {
      final response = await apiService.getGetApiResponse(
          RemoteUrls.technicianList, context);

      List<TechnicianListModel> technicianList = [];

      technicianList = response["data"]
          .map<TechnicianListModel>(
            (e) => TechnicianListModel.fromJson(
              e,
            ),
          )
          .toList();

      return right(technicianList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, EmployeeAttendanceModel>> getEmployeeAttendence(
      {required BuildContext context, required String id}) async {
    try {
      final response = await apiService.getGetApiResponse(
          "${RemoteUrls.employeeAttendance}$id", context);

      EmployeeAttendanceModel employeeAttendanceModel =
          EmployeeAttendanceModel();

      if (response['response'] == false) {
        employeeAttendanceModel = EmployeeAttendanceModel(checkInTime: "");
      } else {
        employeeAttendanceModel =
            EmployeeAttendanceModel.fromJson(response['data']);
      }

      return right(employeeAttendanceModel);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> checkIn(context, data) async {
    try {
      var response = await apiService.dioApiResponse(
          RemoteUrls.checkInTime, data, context);

      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> checkOut(context, data) async {
    try {
      var response = await apiService.dioApiResponse(
          RemoteUrls.checkOutTime, data, context);

      return right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
