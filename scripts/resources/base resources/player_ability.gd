extends FunctionalResource
class_name Ability
##A class containing common exports between spells and magic items
##Abilities includes both spells and magic items.
@export_group("Technical")
##The second half of the description in menus, unique to each level. this is added to the end of the description
##The part before this is the base description, set in the class itself
@export var level_description:String
##The level of this spell, starting at 1. Important for removing the previous level of spell, and menus
@export_range(1, 20) var level:int  = 1
##The rarity of the ability. The weight given to it is the reciprocal of this * reciprocal of level
@export var rarity:int = 1
##The Image used in the menu
@export var icon:Texture2D
##The ability that will be added to the ability pool when this ability is chosen. If left null there are no more upgrades to this ability
@export var next_upgrade:Ability

#these values should be updated in the _init() of each inherited ability class
##Description of the spell itself, shown in menus
var base_description:String = "Base ability class that others inherit from.
 If you're seeing this, the description of a spell/magic item wasn't set properly"
##Name of the spell in text, shown in menus
var ability_name:String = "Test Ability (why can you see this?)"
