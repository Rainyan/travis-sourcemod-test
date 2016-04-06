#include <sourcemod>

public Plugin:myinfo = {
	name = "Test",
	description = "",
	author = "",
	version = "",
	url = ""
};

public OnPluginStart()
{
	PrintToServer("foo");
}