extends Ability
class_name MagicItem

##Base Class for magic items
##Different magic items can have different effects, generally done through different functions
##These should only be implemented if they are used by the magic item
##They should take a single value, if to be used in run_through_magic_items
##Any functions of this kind will start with affect_
##affect_incoming_damage(prior_damage:float) -> float: - affects damage done to the player
##affect_outgoing_damage(prior_damage:float -> float: - affects damage outgoing from a spell or projectile
##Others should be self explanatory, or be implemented as the magic item is designed

@export var application_order:int = 1
