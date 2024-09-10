

extension THIterable<T> on Iterable<T> {

  bool containsByComparing(T element, bool Function(T, T) compare) {
    for (var e in this) {
      if (compare(e, element)) {
        return true;
      }
    }
    return false;
  }

  /// 返回满足给定条件的第一个元素，或者如果没有元素满足条件，则返回“null”。
  T? adFirstWhereOrNull(bool Function(T element) test, {T Function()? orElse}) {
    for (T element in this) {
      if (test(element)) return element;
    }
    if (orElse != null) return orElse();
    return null;
  }

}

extension THList<T> on List<T> {

  /// 根据 [keySelector] 函数从列表中的每个元素中提取键，并将元素按键分组。
  ///
  /// 返回一个 [Map]，其中键是 [keySelector] 函数返回的键，值是包含具有相同键的所有元素的列表。
  ///
  /// 示例：
  ///
  /// ```dart
  /// List<int> numbers = [1, 2, 3, 4, 5, 6, 7, 8, 9];
  /// Map<int, List<int>> evenOdd = numbers.groupBy<int>((number) => number % 2);
  /// print(evenOdd); // 输出：{0: [2, 4, 6, 8], 1: [1, 3, 5, 7, 9]}
  /// ```
  Map<E, List<T>> groupBy<E>(E Function(T) keySelector) {
    var groupedItems = <E, List<T>>{};

    for (var item in this) {
      var key = keySelector(item);
      if (groupedItems[key] == null) {
        groupedItems[key] = [];
      }
      groupedItems[key]!.add(item);
    }

    return groupedItems;
  }

}