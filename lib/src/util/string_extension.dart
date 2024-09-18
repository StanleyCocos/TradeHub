
extension StringOption on String? {
  /*
  * 是否为null
  * */
  bool get isNull => this == null;

  /*
  * 是否为null或者空
  * */
  bool get isEmptyOrNull {
    if (isNull) return true;
    if (this!.isEmpty) return true;
    return false;
  }
}