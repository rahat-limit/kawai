import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

var uuid = const Uuid();

// ignore: must_be_immutable
class WallPaper extends Equatable {
  final String id;
  final String path;
  int favourite;
  // 0 - false
  // 1 - true
  WallPaper({String? id, required this.path, this.favourite = 0})
      : id = id ?? uuid.v4();
  @override
  List<Object> get props => [id, path];
  factory WallPaper.fromJson(Map<String, dynamic> data) {
    return WallPaper(path: data['img']);
  }
}
