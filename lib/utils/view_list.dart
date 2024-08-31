import 'dart:collection';

class ViewList<E> extends ListBase<E> {
  final List<E> _raw;
  List<E> _data = [];
  ViewList(this._raw) {
    _data = _raw;
  }

  @override
  set length(int newLength) {
    _data.length = newLength;
  }

  @override
  int get length => _data.length;
  @override
  E operator [](int index) => _data[index];

  @override
  void operator []=(int index, E value) {
    _data[index] = value;
  }

  @override
  void add(E element) {
    _data.add(element);
  }

  void reset() {
    _data = _raw.toList();
  }

  void filter(List<E> Function(List<E>) list) {
    reset();
    _data = list.call(_data);
  }
}
