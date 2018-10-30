//---------------------------------------------------------------------------------------
//  FILE:   X2Item_ModExample_Weapon.uc
//  AUTHOR:  Ryan McFall
//           
//	Template classes define new game mechanics & items. In this example a weapon template
//  is created that can be used to add a new type of weapon to the XCom arsenal
//  
//---------------------------------------------------------------------------------------
//  Copyright (c) 2016 Firaxis Games, Inc. All rights reserved.
//---------------------------------------------------------------------------------------
class X2Item_UnrestrainedClothes extends X2Item; 

//Template classes are searched for by the game when it starts. Any derived classes have their CreateTemplates function called
//on the class default object. The game expects CreateTemplates to return a list of templates that it will add to the manager
//reponsible for those types of templates. Later, these templates will be automatically picked up by the game mechanics and systems.
static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Items;

	Items.AddItem(CreateUnrestrainedClothes());

	return Items;
}

//Template creation functions form the bulk of a template class. This one builds our custom weapon.
static function X2DataTemplate CreateUnrestrainedClothes()
{
	local X2ArmorTemplate Template;

	`CREATE_X2TEMPLATE(class'X2ArmorTemplate', Template, 'UnrestrainedClothes');
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Kevlar_Armor";
	Template.bAddsUtilitySlot = true;
	Template.StartingItem = true;
	Template.CanBeBuilt = false;
	Template.bInfiniteItem = class'X2Ability_UnrestrainedClothes'.default.UNLIMITED_AMOUNT;
	if (class'X2Ability_UnrestrainedClothes'.default.ENABLE_JUMP)
	{
		Template.Abilities.AddItem('WalkerServosJump');
	}
	Template.Abilities.AddItem('UnrestrainedClothesArmorStats');
	Template.ArmorTechCat = 'conventional';
	Template.ArmorClass = 'basic';
	Template.Tier = 0;
	Template.AkAudioSoldierArmorSwitch = 'Conventional';
	Template.EquipSound = "StrategyUI_Armor_Equip_Conventional";

	Template.SetUIStatMarkup(class'XLocalizedData'.default.HealthLabel, 
		eStat_HP, class'X2Ability_UnrestrainedClothes'.default.HEALTH_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.MobilityLabel, 
		eStat_Mobility, class'X2Ability_UnrestrainedClothes'.default.MOBILITY_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DefenseLabel, 
		eStat_Defense, class'X2Ability_UnrestrainedClothes'.default.DEFENSE_BONUS, true);
	Template.SetUIStatMarkup(class'XLocalizedData'.default.DodgeLabel, 
		eStat_Dodge, class'X2Ability_UnrestrainedClothes'.default.DODGE_BONUS, true);

	return Template;
}