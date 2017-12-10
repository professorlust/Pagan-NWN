// Ultima 8 Remake
// Character Devon OnUserDefined
//
// Enable user defined scripts in OnSpawn by saving a copy and uncommenting the SetSpawnInCondition line near the bottom.
// Then uncomment any OnXXXX events that are needed.

/*
Areas where active:
- Docks
- West Tenebrae
- Central Tenebrae Castle (indoor)
- Central Tenebrae Prison
*/

#include "u8_constants"
#include "u8_lib"

// Game state enum.
const int U8_DEVON_GAMESTATE_FISHERMAN = 0;
const int U8_DEVON_GAMESTATE_PRISON = 1;
const int U8_DEVON_GAMESTATE_EXECUTION = 2;
const int U8_DEVON_GAMESTATE_TEMPEST = 3;

// State local var name.
const string U8_DEVON_VARNAME_GAMESTATE = "nGameState";
const string U8_DEVON_VARNAME_METPC = "bMetPC";

// TODO: Scripting tutorials seem to do script inputs before main.
// Its like setting up the params that main() should be taking but doesn't (probably for script format simplicity reasons).
// So HERE is where the OnUserDefined event var should be declared and set.
// Other local vars can be done in the function that needs it.

// Function prototypes.
void DoOnHeartbeat();
void DoOnPerceive();
void DoIdleAtBeach();

void main()
{
	// TODO: Switch on user defined event id...
	// Call a local handler function to keep things tidy.

	int nOnEvent = GetUserDefinedEventNumber();
	switch (nOnEvent)
	{
		case U8_USEREVENT_ONHEARTBEAT: DoOnHeartbeat(); break;
		case U8_USEREVENT_ONPERCEPTION: DoOnPerception(); break;
		default: U8DebugUnhandledUserDefinedEventNumber(nOnEvent, OBJECT_SELF); break;
	}
}

void DoOnHeartbeat()
{
	// Idle actions?
	// Maybe comment to self rarely. If PC is stealth this will make the NPC seem more alive and a part of the world.

	
	int nGameState = GetLocalInt(OBJECT_SELF, U8_DEVON_VARNAME_GAMESTATE);
	if (nGameState == U8_DEVON_GAMESTATE_FISHERMAN)
	{
		// TODO: check area/time of day.
		// string sAreaTag = GetMyArea(OBJECT_SELF);
		DoIdleAtBeach();
	}
}

void DoOnPerception()
{
	// TODO:
	// if idle state and see's someone, say a generic greeting.
	// else if idle state and hear's anything, say a generic think out loud comment.


	object oPerceived = GetLastPerceived();

	// Idle chatter/reaction as bubble text.
	if (GetIsPC(oPerceived) && GetLastPerceptionSeen())
	{
		// TODO: May want to limit this animation to happen only if hasn't seen PC in a day or so.
		ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING);
		ActionSpeakString("Greetings, friend.");
	}
	else if (GetLastPerceptionHeard())
	{
		ActionSpeakString("What was that noise?", TALKVOLUME_WHISPER);

		// Look towards the location of the sound. The default NWN scripts might do this already?
		if (GetIsObjectVaild(oPerceived)) {
			// SetFacingObject() will be too precise, so offset the direction slightly after that.
			ActionDoCommand(
				SetFacingObject(GetPosition(oPerceived))
			);
			float fRandomOffset = IntToFloat(Random(20) - 10);
			ActionDoCommand(
				SetFacing(GetFacing(OBJECT_SELF) + fRandomOffset)
			);
		}

		ActionSpeakString("Is someone there?");
	}
}

void DoIdleAtBeach()
{
	int bMetPC = GetLocalInt(OBJECT_SELF, U8_DEVON_VARNAME_METPC);

	// TODO: If not yet talked to PC (start of game), then start a conversation.
	// This might be done with some trigger box entry though? Then just handle some trigger event instead...
	// something like:
	if (!bMetPC)
	{
		object oNearestPC = GetNearestPC();
		ActionMoveToObject(oNearestPC);
		ActionStartConversation(oNearestPC, "u8_conv_devon_meet", TRUE);
	}
}
