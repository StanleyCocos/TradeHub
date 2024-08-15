

extension THIterable<T> on Iterable<T> {

  bool containsByComparing(T element, bool Function(T, T) compare) {
    print('containsByComparing');
    for (var e in this) {
      if (compare(e, element)) {
        return true;
      }
    }
    return false;
  }

}