enum TaskStatus { ongoing, completed }

extension TaskStatusExtension on TaskStatus {
  String get statusText {
    switch (this) {
      case TaskStatus.completed:
        return "Đã hoàn thành";
      case TaskStatus.ongoing:
        return "Chưa hoàn thành";
    }
  }
}
