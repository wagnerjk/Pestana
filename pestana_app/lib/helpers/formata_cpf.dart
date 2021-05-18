
class FormataCpf{

  static String formatCPF(String cpf) {
    var regExp = RegExp(r'^(\d{3})(\d{3})(\d{3})(\d{2})$');

    return strip(cpf).replaceAllMapped(
        regExp, (Match m) => '${m[1]}.${m[2]}.${m[3]}-${m[4]}');
  }

  static const STRIP_REGEX = r'[^\d]';

  static String strip(String cpf) {
    var regExp = RegExp(STRIP_REGEX);
    cpf = cpf ?? '';

    return cpf.replaceAll(regExp, '');
  }

}