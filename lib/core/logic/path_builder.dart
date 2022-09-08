import 'core.dart';

abstract class PathBuilder {
  const PathBuilder();

  static const empty = EmptyPathBuilder();

  List<SSPathCommand> buildPath();

  bool shouldRebuildPath(covariant PathBuilder oldPathBuilder) {
    return true;
  }
}

class SimplePathBuilder extends PathBuilder {
  const SimplePathBuilder(this.commands);
  final List<SSPathCommand> commands;

  @override
  List<SSPathCommand> buildPath() => commands;
}

class EmptyPathBuilder extends PathBuilder {
  const EmptyPathBuilder();

  @override
  List<SSPathCommand> buildPath() => [];

  @override
  bool shouldRebuildPath(covariant PathBuilder oldPathBuilder) {
    return (oldPathBuilder is! EmptyPathBuilder);
  }
}
