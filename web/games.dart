import 'dart:html';
import 'package:polymer/polymer.dart';
import 'package:game_store/models.dart';
import 'services.dart';

@CustomTag('x-games')
class XGames extends PolymerElement {
  // Whether styles from the document apply to the contents of the component
  bool get applyAuthorStyles => true;
  XGames.created() : super.created() {
    loadGames();
  }

  @observable List<Game> games = [];
  @observable String search = "";
  @observable String sortField = "";
  @observable bool sortAscending = true;
  @observable bool isCompact = false;

  String stars(int count) => new List.generate(count, (i) => "★").join("");
  
  filterSearch(String search) => (Iterable games) => games.where((e) => e.contains(search));

  sort(Event e, var detail, Element target) {
    var field = target.dataset['field'];
    sortAscending = field == sortField ? !sortAscending : true;
    sortField = field;
  }

  sortBy(String field, bool ascending) => (Iterable games) {
    var list = games.toList()..sort(Game.getComparator(field));
    return ascending ? list : list.reversed;
  };

  compact(Event e, var detail, Element target) => isCompact = !isCompact;
  
  delete(Event e, Game game, Element target) => gameStoreService.delete(game.id).then((_) => loadGames());
  loadGames() => gameStoreService.getAll().then((result) => games = result);
}