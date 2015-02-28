import 'dart:async';
import 'package:shelf/shelf.dart';
import 'package:shelf_appengine/shelf_appengine.dart';
import 'package:shelf_route/shelf_route.dart';
import 'package:appengine/appengine.dart';
import 'package:uri/uri.dart';
import 'package:game_store/models.dart';

import 'game_api.dart';

final gameApiUrl = new UriParser(new UriTemplate(r'/api/games/{gameId}'));
final gamesApiUrl = new UriParser(new UriTemplate('/api/games'));

Logging logger = context.services.logging;

void main() {

  var routes = router()
        ..get(gamesApiUrl, listGames)
        ..get(gameApiUrl, getGameById);
   
  var cascade = new Cascade()
        .add(routes.handler)
        .add(assetHandler(directoryIndexServeMode: DirectoryIndexServeMode.REDIRECT));
  
  serve(cascade.handler);
  
  if(context.isDevelopmentEnvironment){
    final games = [
       new Game("Darts", "Pub game", 'Darts is ...', "darts.jpg", 5),                    
       new Game("Chess", "Board game", 'Chess is ...', "chess.jpg", 4),                    
       new Game("Dices", "Random game", 'Dice are ...', "dice.jpg", 3),                    
       new Game("Go", "Board game", 'Go is ...', "go.jpg", 2),
       new Game("Poker", "Card game", 'Poker is ..', "poker.jpg", 4),
       new Game("Pool", "Pub game", 'Pool is ..', "pool.jpg", 3),
       new Game("Bingo", "Boring game", 'Bingo is ..', "bingo.jpg", 1)
    ];
    // Insert dev data
    games.forEach(gameStoreService.save);
  }
  
  //logger.info("Server started with routes : $routes");
}

Future listGames(Request request) => gameStoreService.getAll().then((games) => new Response.ok(("All games")));

Future getGameById(Request request) {
  final gameId = int.parse(getPathParameter(request, 'gameId'));
  return /*gameStoreService.getById(gameId).then((game) =>*/new Future.value(new Response.ok("Only game $gameId"));
}

// Json

/*class EventEncoder extends Converter<Object, Map> {
  const EventEncoder();
  Map convert(Object input) => {
    'event': '${input.runtimeType}',
    'data': _MORPH.serialize(input)
  };
}*/


