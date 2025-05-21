const Map<int, String> milestoneMessages = {
0:
'🎯 Marshal status maintained! '
'Keep exploring to discover even more of the museum’s hidden history.',

1:
'🪖 Welcome, Private! '
'Your first artefact is logged. Keep going, recruit!',

2:
'📌 Two artefacts secured. '
'One more and you’ll earn your stripes as a Sergeant!',

3:
'🎖 Promotion unlocked: Sergeant! '
'Your journey through history intensifies.',

4:
'🗺 Four artefacts collected. '
'One more and Lieutenant rank is within reach!',

5:
'🎖️ Rank up! You’ve become a Lieutenant. '
'Outstanding fieldwork, soldier.',

6:
'🔍 Six artefacts down. '
'Marshal status is almost yours — eyes sharp!',

7:
'🏅 Marshal Unlocked! '
'You’ve conquered the museum’s past like a true commander!',
};



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