extends Resource
class_name Character

##Name of this chararacter, shown to the player
@export var name:String
##Description of this character. should include flavour text and a gameplay explanation
@export var description:String
##The pool of abilites that this character begins with. Should include the level after of the starting spell
##If a spell is not in here for a character, that character can never obtain it
@export var starting_ability_pool:AbilityPool
##The spell this character begins with
@export var starting_spell:Spell
##The magic item this character begins with
@export var starting_magic_item:MagicItem
##The sprite/animations for this character
@export var animations:SpriteFrames
##The icon on the character select button. preferably 300x300 pixels
@export var icon:Texture2D
