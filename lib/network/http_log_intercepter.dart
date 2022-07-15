import 'package:http_interceptor/http_interceptor.dart';
import 'package:intl/intl.dart';
import '../utils/print.dart';

class HttpLoggerInterceptor implements InterceptorContract {
  DateFormat dateFormat = DateFormat('HH:mm:ss.sss');
  bool isShowLog = true;

  String getTime() {
    return dateFormat.format(DateTime.now());
  }

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    if (isShowLog) {
      if (isShowLog) {
        Print.i("<<<<<<<<<<<<<<  Request  >>>>>>>>>>>>>>>>>>>>>>>");
        Print.api("Request Url: ${data.url}");
        Print.api("Request header: ${data.headers}");
        Print.api("Request Body: ${data.body}");
        Print.i("-------------------------------------- ");
      }
    }
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    if (isShowLog) {
      Print.ii(">>>>>>>>>>>>>>>>>> Response <<<<<<<<<<<<<<<<<<<<<<<<");
      Print.api2("Response Url: (${data.statusCode}) ${data.url}");
      Print.api2("Response data: ${data.body.toString()}");
      Print.ii("-------------------------------------- ");
    }

    return data;
  }
}
