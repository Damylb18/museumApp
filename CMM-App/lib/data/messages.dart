/// This message pops up on the Artefact details screen when an artefact has been scanned
const Map<int, String> milestoneMessages = {
  0:
      'Excellent work! Keep going',

  1:
      '🪖 Welcome, Private!\n\n'
      'Your first artefact is logged. Keep going, recruit!',

  2:
      '📌 Two artefacts secured.\n\n'
      'One more and you’ll earn your stripes as a Sergeant!',

  3:
      '🎖 Promotion unlocked: Sergeant!\n\n'
      'Your journey through history intensifies.',

  4:
      '🗺 Four artefacts collected.\n\n'
      'One more and Lieutenant rank is within reach!',

  5:
      '🎖️ Rank up! You’ve become a Lieutenant.\n\n'
      'Outstanding fieldwork, soldier.',

  6:
      '🔍 Six artefacts down.\n\n'
      'Marshal status is almost yours — eyes sharp!',

  7:
      '🏅 Marshal Unlocked!\n\n'
      'You’ve conquered the museum’s past like a true commander!',
};

/// This message displays on the medals page, telling the user the medals they have (if any) and prompting them to go for more.
String getProgressMessage(int scanned) {
  if (scanned == 0) {
    return 'No medals yet. Scan artefacts to begin your mission!';
  } else if (scanned >= 1 && scanned < 3) {
    return 'Keep scanning to become a Sergeant!';
  } else if (scanned >= 3 && scanned < 5) {
    return 'Great job! You\'re a Sergeant. Aim for Lieutenant!';
  } else if (scanned >= 5 && scanned < 7) {
    return 'Lieutenant rank unlocked! Keep pushing for Marshal!';
  } else if (scanned >= 7 && scanned < 9) {
    return 'You\'ve reached Marshal! Outstanding work, keep it up!';
  } else {
    return 'You\'ve surpassed expectations, soldier! True museum hero!';
  }
}
