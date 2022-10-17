import 'dart:io';

import 'package:firebase_riverpod/core/models/item.dart';
import 'package:firebase_riverpod/ui/providers/loading_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final WriteItemViewModelProvider =
    ChangeNotifierProvider((ref) => WriteItemViewModel(ref.read));

class WriteItemViewModel extends ChangeNotifier {
  final _reader;
  Item initial = Item.empty();

  WriteItemViewModel(this._reader);

  bool get edit => initial.id.isNotEmpty;
  String? get image => initial.image.isEmpty ? null : initial.image;

  String? _title;
  String get title => _title ?? initial.title;

  set title(String title) {
    _title = title;
    notifyListeners();
  }

  String? _description;
  String? get description => _description ?? initial.description;

  set description(String? description) {
    _description = description;
    notifyListeners();
  }

  File? _file;

  File? get file => _file;

  set file(File? file) {
    _file = file;
    notifyListeners();
  }

  Loading get _loading => _reader(loadingProvider);
}
