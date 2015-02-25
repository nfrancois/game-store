import 'dart:async';
import 'package:shelf/shelf.dart';
import 'package:shelf_appengine/shelf_appengine.dart';
import 'package:shelf_route/shelf_route.dart';
import 'package:uri/uri.dart';

import 'game_api.dart';

final gameApiUrl = new UriParser(new UriTemplate(r'/api/games/{gameId}'));
final gamesApiUrl = new UriParser(new UriTemplate('/api/games'));

void main() {
  
  var appRouter = router()
        ..get(gamesApiUrl, listGames)
        ..get(gameApiUrl, getGameById);
   
  var cascade = new Cascade()
        .add(appRouter.handler)
        .add(assetHandler(directoryIndexServeMode: DirectoryIndexServeMode.REDIRECT));
  
  serve(cascade.handler);
}

Future listGames(Request request) => gameStoreService.getAll().then((games) => new Response.ok(("All games")));

Future getGameById(Request request) {
  final gameId = int.parse(getPathParameter(request, 'gameId'));
  return gameStoreService.getById(gameId).then((game) => new Response.ok("Only game $gameId"));
}