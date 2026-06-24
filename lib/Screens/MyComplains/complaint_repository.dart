
import 'package:dartz/dartz.dart';

import '../../Utils/app_base_api_services.dart';
import '../../Utils/app_exceptions.dart';
import '../../Utils/app_failure.dart';
import '../../Utils/app_network_api_services.dart';
import '../../Utils/common_functions.dart';
import '../../Utils/remote_urls.dart';
import '../Auth/technician_model.dart';
import 'complaint_model.dart';

class ComplaintRepository {
  BaseApiService apiService = NetworkAPIService();

  Future<Either<Failure, List<ComplaintModel>>> getOtherAMCList(context) async {
    TechnicianModel technicianModel = await CommonFunctions().getProfileData();
    try {
      var response = await apiService.getGetApiResponse(
          "${RemoteUrls.otherMachineList}${technicianModel.id}", context);

      List<ComplaintModel> complainList = [];

      List data = response['data'];
      // print("ComplaintModel$data");
      complainList = data
          .map((e) => ComplaintModel.fromJson(e, technicianModel.fullName!))
          .toList();
      complainList.removeWhere((element) => element.workRemark == "Work Done");

      complainList = complainList.reversed.toList();

      return Right(complainList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<ComplaintModel>>> getAerotechMachineList(
      context) async {
    TechnicianModel technicianModel = await CommonFunctions().getProfileData();
    try {
      var response = await apiService.getGetApiResponse(
          "${RemoteUrls.aerotechMachineList}${technicianModel.id}", context);

      List<ComplaintModel> complainList = [];

      List data = response['data'];

      complainList = data
          .map((e) => ComplaintModel.fromJson(e, technicianModel.fullName!))
          .toList();
      complainList.removeWhere((element) => element.workRemark == "Work Done");

      complainList = complainList.reversed.toList();

      return Right(complainList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<ComplaintModel>>> getOtherMachineHistoryList(
      context, String fromDate, String uptoDate) async {
    TechnicianModel technicianModel = await CommonFunctions().getProfileData();
    try {
      var response = await apiService.getGetApiResponse(
          "${RemoteUrls.otherMachineHistory}$fromDate&todate=$uptoDate",
          context);

      List<ComplaintModel> complainList = [];

      List data = response['data'];

      complainList = data
          .map((e) => ComplaintModel.fromJson(e, technicianModel.fullName!))
          .toList();

      complainList = complainList.reversed.toList();

      return Right(complainList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, List<ComplaintModel>>> getAeroTechMachineHistoryList(
      context, String fromDate, String uptoDate) async {
    TechnicianModel technicianModel = await CommonFunctions().getProfileData();
    try {
      var response = await apiService.getGetApiResponse(
          "${RemoteUrls.aerotechMachineHistory}$fromDate&todate=$uptoDate",
          context);

      List<ComplaintModel> complainList = [];

      List data = response['data'];

      complainList = data
          .map((e) => ComplaintModel.fromJson(e, technicianModel.fullName!))
          .toList();

      complainList = complainList.reversed.toList();

      return Right(complainList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> addOtherMachineComplain(
      context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.addOtherMachine, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> addAerotechMachineComplain(
      context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.addAerotechMachine, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateOtherCheckin(context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.proceedOtherCheckin, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateCheckOut(context, data) async {
    try {
      var response = await apiService.dioApiResponse(
          RemoteUrls.proceedOtherCheckOut, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateAerotechCheckin(context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.proceedAerotechCheckIn, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateAerotechCheckOut(context, data) async {
    try {
      var response = await apiService.dioApiResponse(
          RemoteUrls.proceedAerotechCheckOut, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateComplain(context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.updateComplain, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateOtherReportType(context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.updateOtherReportType, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateAerotechReportType(
      context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.updateAerotechReportType, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
