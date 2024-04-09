extends TileMap

# Called when the node enters the scene tree for the first time.

const SEASON_FLOOR_TEXTURES = [
	"res://resources/Sprout Lands - Sprites - premium pack/Spring/Grass_Hill_Tiles_v2.png",
	"res://resources/Sprout Lands - Sprites - premium pack/Summer/summerGrassTiles.png",
	"res://resources/Sprout Lands - Sprites - premium pack/Autumn/autumnGrassTile.png",
	"res://resources/Sprout Lands - Sprites - premium pack/Winter/winterGrassTile.png"
]
const SEASON_STAIR_TEXTURES = [
	"res://resources/Sprout Lands - Sprites - premium pack/Spring/Grass_Hill_Tiles_Slopes v.2.png",
	"res://resources/Sprout Lands - Sprites - premium pack/Summer/summerStairs.png",
	"res://resources/Sprout Lands - Sprites - premium pack/Autumn/autumnStairs.png",
	"res://resources/Sprout Lands - Sprites - premium pack/Winter/winterStairs.png"
]

func _ready():
	TimeManager.connect("newSeason",updateTextures)

func updateTextures(season):
	var floorTexture = load(SEASON_FLOOR_TEXTURES[season-1])
	var stairTexture = load(SEASON_STAIR_TEXTURES[season-1])
	self.tile_set.get_source(7).texture = floorTexture
	self.tile_set.get_source(15).texture = stairTexture

func _process(delta):
	pass
