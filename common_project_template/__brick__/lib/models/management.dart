class Returner<T> {
  T data;
  ViewStatus viewStatus;
  String? errorMessage;
  Returner({required this.data, required this.viewStatus,this.errorMessage});

  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    return other is Returner &&
        this.data == other.data &&
        this.viewStatus == other.viewStatus;
  }

  @override
  int get hashCode => data.hashCode ^ viewStatus.hashCode;
}

enum ViewStatus {
  stateInitial,
  stateLoading,
  stateNoData,
  stateLoaded,
  stateError,
  stateConnectionError,
  stateUnauthorized,
  stateCanceled,
}
