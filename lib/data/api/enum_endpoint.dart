enum ApiEndpoint { list, detail, search, review }

extension ApiEndpointExtension on ApiEndpoint {
  String path([String? idOrQuery]) {
    switch (this) {
      case ApiEndpoint.list:
        return '/list';
      case ApiEndpoint.detail:
        return '/detail/${idOrQuery ?? ""}';
      case ApiEndpoint.search:
        return '/search?q=${idOrQuery ?? ""}';
      case ApiEndpoint.review:
        return '/review';
    }
  }
}
