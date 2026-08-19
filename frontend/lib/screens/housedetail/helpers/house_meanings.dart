// significado base de las casas
//
// esto sirve mientras backend mande meaning vacío.
String defaultHouseMeaning(int house) {
  switch (house) {
    case 1:
      return 'The First House represents identity, appearance, '
          'first impressions and the instinctive way you approach life.';

    case 2:
      return 'The Second House represents money, possessions, '
          'personal values, security and self-worth.';

    case 3:
      return 'The Third House represents communication, learning, '
          'thinking, siblings and your immediate environment.';

    case 4:
      return 'The Fourth House represents home, family, roots, '
          'privacy and your emotional foundations.';

    case 5:
      return 'The Fifth House represents creativity, romance, '
          'pleasure, self-expression and the things that bring joy.';

    case 6:
      return 'The Sixth House represents routines, daily work, '
          'habits, service and personal well-being.';

    case 7:
      return 'The Seventh House represents relationships, partnerships, '
          'commitment and the way you meet other people as equals.';

    case 8:
      return 'The Eighth House represents intimacy, trust, shared resources, '
          'vulnerability, crisis and transformation.';

    case 9:
      return 'The Ninth House represents beliefs, philosophy, '
          'higher learning, travel and the search for meaning.';

    case 10:
      return 'The Tenth House represents career, reputation, public life, '
          'ambition and the direction you build over time.';

    case 11:
      return 'The Eleventh House represents friendships, community, '
          'networks, collective projects and future goals.';

    case 12:
      return 'The Twelfth House represents the inner world, solitude, '
          'the subconscious, hidden emotions and what is processed privately.';

    default:
      return 'This house represents a specific area of life '
          'within the natal chart.';
  }
}
