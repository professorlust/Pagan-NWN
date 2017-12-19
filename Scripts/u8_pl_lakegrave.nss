// Ultima 8 Remake
// Placeable Grave Kalen's Beloved OnXXXXX
//
// When spell "open gound" is cast on this grave, activate game state Hydros free.
// Flood the lake area and start the global rainy weather and fog.

// TODO:
// - Might need to put this script as the OnDamaged handler and detect which spell was cast on it.
//   Something like GetLastWeaponUsed() but for spells, is there a GetLastSpellUsed() ?
// - Below is the prototype test code using a trigger. Prepare it for the actual game.

#include "x2_inc_toollib"

void main()
{
	// TODO: This was the test with a Trigger OnEnter.
    object oPC = GetEnteringObject();
    if (GetIsPC(oPC))
    {
        AssignCommand(
            oPC,
            ActionSpeakString("I entered the trigger! " + GetTag(OBJECT_SELF))
        );

        object oArea = GetArea(OBJECT_SELF);
        if (GetLocalInt(oArea, "TILEMAGIC_APPLIED") == FALSE)
        {
            TLChangeAreaGroundTilesEx(oArea, X2_TL_GROUNDTILE_WATER, 1.5);

            // Set a variable to indicate the tilemagic exists.
            SetLocalInt(oArea, "TILEMAGIC_APPLIED", TRUE);
        }
    }
}