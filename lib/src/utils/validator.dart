class Validator {
  String? validateField({required String field}) {
    if (field.isEmpty) {
      return 'Field tidak boleh kosong';
    }

    return null;
  }
}
