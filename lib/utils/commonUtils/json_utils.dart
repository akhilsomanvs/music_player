extension JsonCheck on Map<String, dynamic> {
  checkAndReturn(String key) {
    if (this == null) return null;
    if (this.containsKey(key)) {
      return this[key];
    } else {
      return null;
    }
  }
}
