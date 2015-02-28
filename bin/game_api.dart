library game_store.server.game_api;

import 'dart:async';
import 'package:gcloud/db.dart';
import 'package:appengine/appengine.dart';
import '../lib/models.dart';
import 'package:appengine/appengine.dart';

DatastoreDB db = context.services.db;

class GameStoreService {
  
  //Future<List<Game>> getAll() => new Future.value(games.values.toList());
  Future<List<Game>> getAll() => db.query(Game).run().toList();
  
  //Future<Game> getById(int id) => new Future.value(games[id]);
  
  Future<Game> save(Game game) => db.commit(inserts: [game]).then((_) => game);
  
  //Future<Game> delete(int gameId) => new Future.value(games.remove(gameId));
}

final GameStoreService gameStoreService = new GameStoreService();
