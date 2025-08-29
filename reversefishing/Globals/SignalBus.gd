extends Node

@warning_ignore("unused_signal") signal interact
@warning_ignore("unused_signal") signal addPreserver

## Map Stuff ##
@warning_ignore("unused_signal") signal sendRowboatCoordinate(coordinate : Vector2)

## Monster rawr :3 ##
@warning_ignore("unused_signal") signal eatThatGuy
@warning_ignore("unused_signal") signal spawnMonster(preserver)
@warning_ignore("unused_signal") signal callEatToHappen

## Radio ##
@warning_ignore("unused_signal") signal emitBoatCoordinate(coordinate : Vector2)
@warning_ignore("unused_signal") signal popBoatCoord(coordinate : Vector2i)
