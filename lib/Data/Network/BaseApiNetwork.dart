abstract class BaseApiNetwork {
  Future<dynamic> _getgetApiService(String url);
  Future<dynamic> _getPostApiService(String url, dynamic body);
}
