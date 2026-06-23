import 'package:airo_tech/Screens/Installation/installation_model.dart';
import 'package:airo_tech/Utils/app_base_api_services.dart';
import 'package:airo_tech/Utils/app_exceptions.dart';
import 'package:airo_tech/Utils/app_failure.dart';
import 'package:airo_tech/Utils/app_network_api_services.dart';
import 'package:airo_tech/Utils/remote_urls.dart';
import 'package:dartz/dartz.dart';

class MachineDispatchRepository {
  BaseApiService apiService = NetworkAPIService();

  Future<Either<Failure, List<InstallationModel>>> getMachineDipatchList(
      context) async {
    try {
      var response = await apiService.getGetApiResponse(
          RemoteUrls.machineDispatchList, context);

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

  Future<Either<Failure, dynamic>> sendInstallation(context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.sendInstallationForm, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  Future<Either<Failure, dynamic>> submitAndDispatch(context, data) async {
    try {
      var response = await apiService.getPostApiResponse(
          RemoteUrls.addMachineDispatch, data, context);

      return Right(response);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}
