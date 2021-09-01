import 'dart:io';
import 'package:http/io_client.dart';

IOClient getHttp() {
  bool trustSelfSigned = true;
  HttpClient httpClient = HttpClient()
    ..badCertificateCallback =
        ((X509Certificate cert, String host, int port) => trustSelfSigned);
  IOClient ioClient = new IOClient(httpClient);
  return ioClient;
}
