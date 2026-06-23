import 'package:airo_tech/Utils/app_base_api_services.dart';
import 'package:airo_tech/Utils/app_exceptions.dart';
import 'package:airo_tech/Utils/app_failure.dart';
import 'package:airo_tech/Utils/app_network_api_services.dart';
import 'package:airo_tech/Utils/remote_urls.dart';
import 'package:dartz/dartz.dart';

import 'installation_model.dart';

class InstallationRepository {
  BaseApiService apiService = NetworkAPIService();

  Future<Either<Failure, List<InstallationModel>>> getInstallationList(
      context) async {
    try {
      var response = await apiService.getGetApiResponse(
          RemoteUrls.machineInstallationList, context);

      List<InstallationModel> installationList = [];

      List data = response['data'];

      installationList =
          data.map((e) => InstallationModel.fromJson(e)).toList();

      installationList
          .removeWhere((element) => element.status == "Installation Done");

      installationList = installationList.reversed.toList();

      return Right(installationList);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateHoldingStatus(context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.holdingInstallationStatus, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> updateInstallationStatus(
      context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.installationDoneStatus, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
