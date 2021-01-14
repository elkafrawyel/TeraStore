abstract class DataResource {}

class Success implements DataResource {
  final dynamic data;

  Success({this.data});
}

class Failure implements DataResource {
  final String errorMessage;

  Failure({this.errorMessage = ''});
}

// to compile it run
// flutter packages pub run build_runner build --delete-conflicting-outputs
