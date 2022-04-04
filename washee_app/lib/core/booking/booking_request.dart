class BookingRequestParams {
  final int page;
  final int pageSize;

  const BookingRequestParams({
    this.page = 1,
    this.pageSize = 20,
  });
}

// Made from: https://devmuaz.medium.com/flutter-clean-architecture-series-part-2-bcdf9d38fe41
// Suggests Dio, but please use http instead!