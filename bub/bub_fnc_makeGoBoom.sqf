if (!isServer) exitWith {};

[] spawn 
{
	_bombs = missionNamespace getVariable "bombs";
	
	{
		_isDefused = _x getVariable "defused";
		
		if (isNil "_isDefused" or {!_isDefused}) then 
		{
			[getPos _x, 600] call RHS_fnc_ss21_nuke; 
			
			_bigNode = _x getVariable "bigNode";
			_bigNode setVariable ["Cre8ive_RN_Strength", 180, true];
			
			_hugeNode = _x getVariable "hugeNode";
			[_hugeNode] spawn 
			{
				params ["_hugeNode"];
				for "_rads" from 0 to 32 step 0.2 do
				{
					_hugeNode setVariable ["Cre8ive_RN_Strength", _rads, true];
					sleep 1;
				}
				
			};
			
			_bombsExploded = missionNamespace getVariable "bombsExploded";
			if (isNil "_bombsExploded") then {_bombsExploded = 0;};
			missionNamespace setVariable ["bombsExploded", _bombsExploded + 1];
			
			[_x] call bub_fnc_explosionCleanup;
			
			_marker = _x getVariable "marker_text";
			_circle = _x getVariable "marker_circle";
			_gz_text = _x getVariable "groundzero_text";
			_gz_circle = _x getVariable "groundzero_circle";
			
			_marker setMarkerAlpha 0;
			_circle setMarkerAlpha 0;
			_gz_text setMarkerAlpha 1;
			_gz_circle setMarkerAlpha 1;
			
			sleep (20 + random 10);
		};		
		
	} foreach _bombs;
	
};