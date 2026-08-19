// numero romano de las casas
String romanNumeral(int number) {
  const values = {
    1: 'I',
    2: 'II',
    3: 'III',
    4: 'IV',
    5: 'V',
    6: 'VI',
    7: 'VII',
    8: 'VIII',
    9: 'IX',
    10: 'X',
    11: 'XI',
    12: 'XII',
  };

  return values[number] ?? number.toString();
}

// simbolos de los planetas
String planetSymbol(String planet) {
  switch (planet.trim().toLowerCase()) {
    case 'sun':
      return '☉';

    case 'moon':
      return '☾';

    case 'mercury':
      return '☿';

    case 'venus':
      return '♀';

    case 'mars':
      return '♂';

    case 'jupiter':
      return '♃';

    case 'saturn':
      return '♄';

    case 'uranus':
      return '♅';

    case 'neptune':
      return '♆';

    case 'pluto':
      return '♇';

    case 'node':
    case 'north node':
      return '☊';

    case 'chiron':
      return '⚷';

    case 'part of fortune':
      return '⊗';

    case 'lilith':
      return '⚸';

    case 'ascendant':
      return '↑';

    case 'midheaven':
      return 'MC';

    default:
      return '•';
  }
}

// simbolos de aspectos
String aspectSymbol(String type) {
  switch (type.trim().toLowerCase()) {
    case 'conjunction':
      return '☌';

    case 'opposition':
      return '☍';

    case 'square':
      return '□';

    case 'trine':
      return '△';

    case 'sextile':
      return '✶';

    default:
      return '·';
  }
}

// nombres de aspectos
String aspectName(String type) {
  switch (type.trim().toLowerCase()) {
    case 'conjunction':
      return 'conjunction';

    case 'opposition':
      return 'opposition';

    case 'square':
      return 'square';

    case 'trine':
      return 'trine';

    case 'sextile':
      return 'sextile';

    default:
      return type;
  }
}
