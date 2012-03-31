/// Builder class for defining [ItemType]s.
class ItemBuilder extends ContentBuilder {
  ItemBuilder(Content content) : super(content);

  void build() {
    // From Angband:
    // !   A potion (or flask)    /   A pole-arm
    // ?   A scroll (or book)     |   An edged weapon
    // ,   A mushroom (or food)   \   A hafted weapon
    // -   A wand or rod          }   A sling, bow, or x-bow
    // _   A staff                {   A shot, arrow, or bolt
    // =   A ring                 (   Soft armour (cloak, robes, leather armor)
    // "   An amulet              [   Hard armour (metal armor)
    // $   Gold or gems           ]   Misc. armour (gloves, helm, boots)
    // ~   Lites, Tools           )   A shield
    // &   Chests, Containers

    item('stick', brown('/'));
    item('empty bottle', lightBlue('!'));
    item('crusty loaf of bread', lightBrown(','), use: useFood(300));
  }

  ItemUse useFood(int amount) {
    return (Game game, Action action) {
      final hero = action.hero;

      if (hero.hunger < amount) {
        game.log.add('{1} [are|is] stuffed.', hero);
        hero.hunger = 0;
      } else {
        hero.hunger -= amount;
        game.log.add('{1} feel[s] less hungry.', hero);
      }
    };
  }

  ItemType item(String name, Glyph appearance, [ItemUse use]) {
    final itemType = new ItemType(name, appearance, use);
    content.itemTypes.add(itemType);
    return itemType;
  }
}