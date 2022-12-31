abstract class IRouteManager {
  Future<dynamic> page(String routeName, {Object? argument});
  Future<dynamic> pageAndReplace(String routeName, {Object? argument});
  Future<dynamic> pageAndRemoveUntil(String routeName, {Object? argument});
  dynamic back({Object? argument});
}
