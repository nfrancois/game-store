library game_store.utils;

import 'dart:async';
import 'dart:html';
import 'package:polymer_expressions/filter.dart';

typedef V TypedFilter<T, V>(T v);

class GenericTransformer<T, V> extends Transformer<T, V> {
  final TypedFilter<V, T> _forward;
  final TypedFilter<T, V> _reverse;

  GenericTransformer(this._forward, this._reverse);
  
  T forward(V v) => _forward(v);
  V reverse(T t) => _reverse(t);
}

gotoPath(url) => new Future(() => window.location.assign(url));