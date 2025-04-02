// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/02
// Description: 
// -------------------------------------------------------------------
enum Role { player1, player2, spectator }

String getMyPlayerIdFromRole(Role role) {
  switch (role) {
    case Role.player1:
      return 'p1';
    case Role.player2:
      return 'p2';
    case Role.spectator:
    default:
      return 'spectator';
  }
}