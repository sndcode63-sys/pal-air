class RemoteUrls {
  static const baseUrl = "https://airotech.webvisionsoftech.com/mobileAppApi";
  static String imageUrl = "https://airotech.webvisionsoftech.com";

  static String loginUrl = "$baseUrl/login";
  static String getProfile = "$baseUrl/field-engineer-list";
  static String updateProfile = "$baseUrl/profile-update";
  static String otherMachineList = "$baseUrl/other-machine-amc-list?id=";
  static String aerotechMachineList = "$baseUrl/airotech-machine-amc-list?id=";
  static String otherMachineHistory =
      "$baseUrl/other-machine-amc-history?fromdate=";
  static String aerotechMachineHistory =
      "$baseUrl/airotech-machine-amc-history?fromdate=";

  static String machineInstallationList = "$baseUrl/machine-installation-list";
  static String machineDispatchList = "$baseUrl/machine-dispatch-list";
  static String technicianList = "$baseUrl/technician-list";
  static String addOtherMachine = "$baseUrl/add-other-machine-amc";
  static String addAerotechMachine = "$baseUrl/add-airotech-machine-amc";
  static String proceedOtherCheckin = "$baseUrl/proceed-other-checkin";
  static String proceedOtherCheckOut = "$baseUrl/proceed-other-checkout";
  static String updateOtherReportType = "$baseUrl/other-service-report-type";
  static String proceedAerotechCheckIn = "$baseUrl/proceed-airotech-checkin";
  static String proceedAerotechCheckOut = "$baseUrl/proceed-airotech-checkout";
  static String updateAerotechReportType =
      "$baseUrl/airotech-service-report-type";
  static String updateComplain = "$baseUrl/proceed-airotech-checkout";
  static String holdingInstallationStatus =
      "$baseUrl/holding-installation-status";

  static String installationDoneStatus = "$baseUrl/installation-done";
  static String sendInstallationForm = "$baseUrl/send-installation-form";
  static String addMachineDispatch = "$baseUrl/add-machine-dispatch";

  static String employeeAttendance = "$baseUrl/employee-attendance?empId=";
  static String checkInTime = "$baseUrl/check-in-time";
  static String checkOutTime = "$baseUrl/check-out-time";
}
