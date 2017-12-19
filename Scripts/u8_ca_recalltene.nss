// Ultima 8 Remake
// Conversation Action Recall Gem Teleport to Tenebrae.

#include "u8_constants"
#include "u8_lib"
#include "u8_lib_recallgem"

void main()
{
	object oPC = GetPCSpeaker();
	if (GetIsPC(oPC))
	{
		U8ActionRecallToPortal(oPC, U8_WP_PORTAL_TENEBRAE);
	}

	// Or instead, do it for all Players?
	//object oPC = GetFirstPC();
	//while (GetIsObjectValid(oPC))
	//{
	//	U8ActionRecallToPortal(oPC, U8_WP_PORTAL_TENEBRAE);
	//	oPC = GetNextPC();
	//}
}
