library game_store.server.game_api;

import 'dart:async';
import 'dart:math';
import '../lib/models.dart';

class GameStoreService {
  final Map<int, Game> games = new Map.fromIterable([
    new Game(1, "Darts", "Pub game", 'Darts is ...', "darts.jpg", 5),                    
    new Game(2, "Chess", "Board game", 'Chess is ...', "chess.jpg", 4),                    
    new Game(3, "Dices", "Random game", 'Dice are ...', "dice.jpg", 3),                    
    new Game(4, "Go", "Board game", 'Go is ...', "go.jpg", 2),
    new Game(5, "Poker", "Card game", 'Poker is ..', "poker.jpg", 4),
    new Game(6, "Pool", "Pub game", 'Pool is ..', "pool.jpg", 3),
    new Game(7, "Bingo", "Boring game", 'Bingo is ..', "bingo.jpg", 1)
  ], key: (g) => g.id);
  
  Future<List<Game>> getAll() => new Future.value(games.values.toList());
  Future<Game> getById(int id) => new Future.value(games[id]);
  Future<Game> save(Game game) => new Future(() {
    if(game.id == null) {
      game.id = games.values.map((g) => g.id).fold(0, max) + 1;
    }
    games[game.id] = game;
    return game;
  });
  Future<Game> delete(int gameId) => new Future.value(games.remove(gameId));
}

final GameStoreService gameStoreService = new GameStoreService();
