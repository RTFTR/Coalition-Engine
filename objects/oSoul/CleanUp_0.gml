delete Purple;
part_type_destroy(EffectT);
part_system_destroy(EffectS);
part_type_destroy(ShieldParticleType);
part_system_destroy(ShieldParticleSystem);

//Removes itself form the global soul array
var i = 0, n = array_length(BattleSoulList);
repeat n
{
	if BattleSoulList[i] == id
	{
		array_delete(BattleSoulList, i, 1);
		exit;
	}
	++i;
}