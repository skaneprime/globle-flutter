//@dart=2.12

import 'core.dart';

abstract class PathBuilder {
  const PathBuilder();

  static const empty = EmptyPathBuilder();

  List<ZPathCommand> buildPath();

  bool shouldRebuildPath(covariant PathBuilder oldPathBuilder) {
    return true;
  }
}

class SimplePathBuilder extends PathBuilder {
  const SimplePathBuilder(this.commands);
  final List<ZPathCommand> commands;

  @override
  List<ZPathCommand> buildPath() => commands;
}

class EmptyPathBuilder extends PathBuilder {
  const EmptyPathBuilder();

  @override
  List<ZPathCommand> buildPath() => [];

  @override
  bool shouldRebuildPath(covariant PathBuilder oldPathBuilder) {
    return (oldPathBuilder is! EmptyPathBuilder);
  }
}
