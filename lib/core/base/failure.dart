class NetWorkConnection implements Failure {}

class BadRequestError implements Failure {}

class UnAuthorizedError implements Failure {}

class DataNotFoundError implements Failure {}

class UnprocessableErorr implements Failure {}

class InternalServerError implements Failure {}

class ForceUpdateError implements Failure {}

class MaintenanceError implements Failure {}

class ServerError implements Failure {}

class AppError implements Failure {
  final String message;

  AppError(this.message);
}

sealed class Failure implements Exception {
  factory Failure.networkConnection() = NetWorkConnection;
  factory Failure.badRequestError() = BadRequestError;
  factory Failure.unAuthorizedError() = UnAuthorizedError;
  factory Failure.dataNotFoundError() = DataNotFoundError;
  factory Failure.unprocessableErorr() = UnprocessableErorr;
  factory Failure.internalServerError() = InternalServerError;
  factory Failure.forceUpdateError() = ForceUpdateError;
  factory Failure.maintenanceError() = MaintenanceError;
  factory Failure.serverError() = ServerError;
  factory Failure.error(String msg) = AppError;
}
