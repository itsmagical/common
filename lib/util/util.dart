class Util {

  /// @return true 集合不为空
  static bool isNotEmpty(Iterable iterable) {
    return null != iterable && iterable.length > 0;
  }

  /// @return true object is not null
  static bool isNotNull(Object value) {
    return null != value;
  }

  /// @return true object is null
  static bool isNull(Object value) {
    return null == value;
  }

  static bool isEmpty(dynamic value) {
    if (value == null) {
      return true;
    }
    if (value is String) {
      return value == null || value.isEmpty;
    }
    if (value is Iterable) {
      return null == value || value.length == 0;
    }
  }

  /// @return true 字符串不为空
  static bool isNotEmptyText(String text) {
    return text != null && text != '';
  }
}
