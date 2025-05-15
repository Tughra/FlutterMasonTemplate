
abstract class BaseAutoCompleteModel<T>{
  final String? name;
  final T? code;

  BaseAutoCompleteModel(this.name, this.code);
  Map<String,dynamic>toJson();
  @override
  bool operator ==(other) {
    if (identical(this, other)) return true;
    return other is BaseAutoCompleteModel &&
        name == other.name &&
        code == other.code;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode;
}