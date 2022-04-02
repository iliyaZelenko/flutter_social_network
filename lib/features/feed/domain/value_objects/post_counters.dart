class PostCounters {
  final int viewed, comments, marks;

  PostCounters({
    required this.viewed,
    required this.comments,
    required this.marks,
  }) : assert(viewed >= 0 && comments >= 0 && marks >= 0);
}
