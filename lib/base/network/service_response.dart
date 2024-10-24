class ServiceResponse {
  final Status status;
  final dynamic data;
  final Exception? exception;

  const ServiceResponse.success(this.data, { this.exception})
      : status = Status.success;
  const ServiceResponse.error(this.data, { this.exception})
      : status = Status.error;
}

enum Status { success, error }
