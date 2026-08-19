// dejar el strength bonito para mostrar
//
// VERY STRONG
// pasa a
// Very Strong
String prettyStrength(String value) {
  if (value.trim().isEmpty) {
    return '';
  }

  return value.toLowerCase().split(' ').map((word) {
    if (word.isEmpty) {
      return word;
    }

    return word[0].toUpperCase() + word.substring(1);
  }).join(' ');
}
