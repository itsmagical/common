class Util {

  /// @return true 集合不为空
  static bool isNotEmpty(Iterable iterable) {
    return null != iterable && iterable.length > 0;
  }

  /// @return true object is not null
  static bool isNotNull(Object value) {
    return null != value;
  }

  /// @return true 字符串不为空
  static bool isNotEmptyText(String text) {
    return text != null && text != '';
  }
}