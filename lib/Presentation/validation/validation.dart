class InputValidationMixin {
  bool isPasswordValid(String password) => password.length >= 6;

  bool isEmailValid(String email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(email);
  }

  bool isDateValid(String date) {
    String pattern =
        r'^(?:(?:31(\/|-|\.)(?:0?[13578]|1[02]))\1|(?:(?:29|30)(\/|-|\.)(?:0?[13-9]|1[0-2])\2))(?:(?:1[6-9]|[2-9]\d)?\d{2})$|^(?:29(\/|-|\.)0?2\3(?:(?:(?:1[6-9]|[2-9]\d)?(?:0[48]|[2468][048]|[13579][26])|(?:(?:16|[2468][048]|[3579][26])00))))$|^(?:0?[1-9]|1\d|2[0-8])(\/|-|\.)(?:(?:0?[1-9])|(?:1[0-2]))\4(?:(?:1[6-9]|[2-9]\d)?\d{2})$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(date);
  }

  bool isValidName(String name) {
    String pattern = r'\b([A-ZÀ-ÿ][-,a-z. ]+[ ]*)+';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(name);
  }

  bool isValidphoneNumber(String phone) {
    String pattern = r'^(\+\d{1,2}\s)?\(?\d{3}\)?[\s.-]\d{3}[\s.-]\d{4}$';
    RegExp regex = new RegExp(pattern);
    return regex.hasMatch(phone);
  }
}
