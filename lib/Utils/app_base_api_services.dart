import 'package:flutter/material.dart';

abstract class BaseApiService {
  Future<dynamic> getGetApiResponse(String url, BuildContext context);

  Future<dynamic> getPostApiResponse(
      String url, dynamic data, BuildContext context);

  Future<dynamic> getDeleteApiResponse(String url, BuildContext context);

  Future<dynamic> getPutApiResponse(
      String url, dynamic data, BuildContext context);
  // --------------------------------------------------------

  Future<dynamic> loginRegisterApiResponse(
      String url, dynamic data, BuildContext context);
  // --------------------------------------------------------
  Future<dynamic> dioApiResponse(
      String url, dynamic formData, BuildContext context);
  // --------------------------------------------------------
  Future<dynamic> dioPutApiResponse(
      String url, dynamic formData, BuildContext context);
}
