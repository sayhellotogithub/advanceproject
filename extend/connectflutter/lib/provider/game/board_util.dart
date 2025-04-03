// -------------------------------------------------------------------
// Author: WANG JUN
// Date: 2025/04/03
// Description:
// -------------------------------------------------------------------
import '../../model/game/piece/index.dart';

List<Piece> createInitialChessPieces() {
  final List<Piece> pieces = [];

  // p1: 下側（白）
  pieces.addAll([
    Rook('r1', 'p1', 0, 7),
    Knight('n1', 'p1', 1, 7),
    Bishop('b1', 'p1', 2, 7),
    Queen('q1', 'p1', 3, 7),
    King('k1', 'p1', 4, 7),
    Bishop('b2', 'p1', 5, 7),
    Knight('n2', 'p1', 6, 7),
    Rook('r2', 'p1', 7, 7),
  ]);
  for (int i = 0; i < 8; i++) {
    pieces.add(Pawn('p${i + 1}', 'p1', i, 6));
  }

  // p2: 上側（黒）
  pieces.addAll([
    Rook('R1', 'p2', 0, 0),
    Knight('N1', 'p2', 1, 0),
    Bishop('B1', 'p2', 2, 0),
    Queen('Q1', 'p2', 3, 0),
    King('K1', 'p2', 4, 0),
    Bishop('B2', 'p2', 5, 0),
    Knight('N2', 'p2', 6, 0),
    Rook('R2', 'p2', 7, 0),
  ]);
  for (int i = 0; i < 8; i++) {
    pieces.add(Pawn('P${i + 1}', 'p2', i, 1));
  }

  return pieces;
}

String? checkWinner(List<Piece> pieces) {
  final hasP1King = pieces.any((p) => p.owner == 'p1' && p.type == 'king');
  final hasP2King = pieces.any((p) => p.owner == 'p2' && p.type == 'king');

  if (!hasP1King && hasP2King) return 'p2';
  if (!hasP2King && hasP1King) return 'p1';
  if (!hasP1King && !hasP2King) return 'draw';
  return null; // 勝敗未確定
}

String getUnicodeSymbol(Piece piece) {
  final isWhite = piece.owner == 'p1';
  switch (piece.type.toLowerCase()) {
    case 'king':
      return isWhite ? '♔' : '♚';
    case 'queen':
      return isWhite ? '♕' : '♛';
    case 'rook':
      return isWhite ? '♖' : '♜';
    case 'bishop':
      return isWhite ? '♗' : '♝';
    case 'knight':
      return isWhite ? '♘' : '♞';
    case 'pawn':
      return isWhite ? '♙' : '♟';
    default:
      return '?';
  }
}

String? getGameOverMessage(List<Piece> pieces) {
  final winner = checkWinner(pieces);
  if (winner == 'p1') return '白の勝ち！';
  if (winner == 'p2') return '黒の勝ち！';
  if (winner == 'draw') return '引き分け';
  return null;
}
