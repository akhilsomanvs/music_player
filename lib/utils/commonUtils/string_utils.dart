extension StringSanityCheck on String {
  bool isNull() {
    return this == null;
  }

  bool isNullOrEmpty() {
    return (this == null || this.isEmpty);
  }

  String returnEmptyIfNull() {
    if (this.isNullOrEmpty()) {
      return "";
    }
    return this;
  }

  String? getDifferenceFrom(String secondString) {
    if (this.isNullOrEmpty() || secondString.isNullOrEmpty()) {
      return null;
    }

    int? index = this.getIndexOfDifference(secondString);
    if (index == null) {
      return null;
    }
    return this.substring(index);
  }

  int? getIndexOfDifference(String secondString) {
    if (this == secondString) {
      return null;
    }

    if (this.isNullOrEmpty() || secondString.isNullOrEmpty()) {
      return 0;
    }

    int i = 0;
    for (i = 0; i < this.length && i < secondString.length; i++) {
      if (this.getCharAt(i) != secondString.getCharAt(i)) {
        break;
      }
    }
    if (i < this.length || i < secondString.length) {
      return i;
    }
    return null;
  }

  String getCharAt(int index) {
    return this.substring(index, index + 1);
  }

  bool isValidEmail() {
    if (this == null || this.isEmpty) {
      return false;
    }
    return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }

  bool isValidPassword() {
    if (this == null || this.length == 0 || this.isNullOrEmpty()) {
      return false;
    }
    return true;
   /* String pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = new RegExp(pattern);
    return regExp.hasMatch(this);*/
  }

  bool isValidPersonName() {
    /*if(this==null || this.isEmpty){
      return false;
    }
    String pattern = r"^[\\p{L} .'-]+$";
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(this);*/
    return true;
  }
}
