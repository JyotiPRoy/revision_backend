import 'package:revision_backend/revision_backend.dart';

class Result<T> {
  final T? data;
  final String? errorMessage;

  Result({this.data, this.errorMessage})
    : assert(data != null || errorMessage != null);

  bool get hasError => data == null;

  Response asResponse({dynamic formattedData}) {
    final errorMap = { "error": errorMessage };

    if(!hasError) {
      return Response.ok(formattedData ?? data);
    }else {
      return Response.serverError(body: errorMap);
    }
  }
}
