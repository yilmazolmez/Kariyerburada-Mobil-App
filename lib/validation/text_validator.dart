class TextValidationMixin {
  String Valideozet(String value) {
    if (value.length > 200) {
      return "Max 200 karakter.";
    }
  }
}
