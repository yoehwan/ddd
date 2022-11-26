import 'package:equatable/equatable.dart';

class Size extends Equatable {
  Size(this.width, this.height);
  final int width;
  final int height;

  @override
  List<Object?> get props => [width, height];
}
