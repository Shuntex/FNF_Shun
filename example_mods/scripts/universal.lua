local ffi = require("ffi")  -- LuaJIT Extension
local user32 = ffi.load("user32")   -- LuaJIT User32 DLL Handler Function

ffi.cdef([[
enum{
    MB_OK = 0x00000000L,
	MB_OKCANCEL = 0x00000001L,
    MB_ABORTRETRYIGNORE = 0x00000002L,
    MB_YESNOCANCEL = 0x00000003L,
    MB_YESNO = 0x00000004L,
    MB_RETRYCANCEL = 0x00000005L,
    MB_CANCELTRYCONTINUE = 0x00000006L,
    MB_ICONINFORMATION = 0x00000040L,
	MB_ICONWARNING = 0x00000030L,
	MB_ICONASTERISK = 0x00000040L,
	MB_ICONHAND = 0x00000010L,
};

typedef void* HANDLE;
typedef HANDLE HWND;
typedef const char* LPCSTR;
typedef unsigned UINT;

int MessageBoxA(HWND, LPCSTR, LPCSTR, UINT);
int MessageBoxW(HWND, LPCSTR, LPCSTR, UINT);
]])

--HP POISON
local doDrain = false;
local healthDrainPoison = 0.025;
local poisonStacks = 0;
--HP POISON

local hitsToDeath = 0;

allowPause = false;
isCrashing = true;
hpProhibit = false;

sway = true;
local angleshit = 1.5;
local anglevar = 1.5;

local notesUntilCure = 0;

logArray = {"","","","","","","","","","","","","","","","","","","",""}

function onCreate()
	health = getProperty('health')
	setPropertyFromClass('ClientPrefs', 'timeBarType', 'Disabled');
	
	
	makeLuaSprite('CRASH', 'ERR', 0, 0);
	setProperty('CRASH.alpha', 0);
	setObjectCamera('CRASH', 'other')
	setProperty('CrashScreen.visible', false)
	addLuaSprite('CRASH', true);
	
	makeLuaSprite('HP', 'HP_PROHIBIT_SCREEN', 0, 0);
	setProperty('HP.alpha', 0);
	setObjectCamera('HP', 'other')
	setProperty('HpProh.visible', true)
	addLuaSprite('HP', true);
	
	makeAnimatedLuaSprite('Crash', 'HUD_Break', 0, 0);
	setObjectCamera('Crash', 'other');
	addAnimationByPrefix('Crash', 'glitching', 'HUD_GLITCH', 45, true)
	objectPlayAnimation('Crash', 'glitching', false)
	setProperty('Crash.visible', false)
	addLuaSprite('Crash',true)
	
	--setProperty('health', health+ 2.0);
end




function onMoveCamera(focus)
    --if focus == 'boyfriend' then
        --setProperty ('defaultCamZoom', 0.6)
    --elseif focus == 'dad' then
        --setProperty ('defaultCamZoom', 0.7)
    --end
end

function onDestroy()
	-- triggered when the lua file is ended (Song fade out finished)
end

function onCountdownTick(counter)
	-- counter = 0 -> "Three"
	-- counter = 1 -> "Two"
	-- counter = 2 -> "One"
	-- counter = 3 -> "Go!"
	-- counter = 4 -> Nothing happens lol, tho it is triggered at the same time as onSongStart i think
end


function noteMiss(id, noteData, noteType, isSustainNote, tag, loops, loopsleft)
	if noteType == 'Sako_Note' then
		poisonStacks = poisonStacks + 1;
	end
	if noteType == 'Fallen Note' then
	--H E L L
		hpProhibit = true;
		doTweenAlpha('HpAlpha', 'HP', 0.6, 0.8, 'quintOut');
	--H E L L
	end
	
	if noteType == 'CRASH_NOTES' then
		if isCrashing == true then
			playMusic('red-alertCrash', 1, true)
			cameraShake("camHUD", 999999.0, 999999.0);
			setProperty('Crash.visible', true)
			
			isCrashing = false;
			playSound('glitchSound', 2, 'glitch')
			runTimer('crashPre', 2.1);
			runTimer('crash', 3.5);
			runTimer('crashPost', 3.8);
		end
	end
end
function goodNoteHit()
	if noteType == 'Sako_Note' then
		poisonStacks = poisonStacks - poisonStacks;
		hpProhibit = false;
	end
	health = getProperty('health')
    if getProperty('health') > 0.1 then
        setProperty('health', health+ 0.05);
    end
	--H E L L
	if hpProhibit == true then
		if getProperty('health') > 0.1 then
        setProperty('health', health- 0.023);
    end
		notesUntilCure = notesUntilCure + 1
	end
	--H E L L
end
function onUpdate(elapsed)
	health = getProperty('health')
	
	if getProperty('health') > 0.05 then
        setProperty('health', health- healthDrainPoison * poisonStacks * elapsed);
    end
	--H E L L
	--H E L L
	
	if notesUntilCure == 30 then
		hpProhibit = false;
	end
	if hpProhibit == false then
		doTweenAlpha('HpAlpha', 'HP', 0.0, 0.8, 'quintOut');
		notesUntilCure = notesUntilCure - notesUntilCure;
	end
	--H E L L
	--H E L L
end

function opponentNoteHit(id, direction, noteData, noteType, isSustainNote, tag, loops, loopsleft)
	if noteType == 'Fallen Note' then
		setProperty('health', health- 0.03);
	end
	if hpProhibit == true then
		setProperty('health', health- 0.02);
	end	
	if curBeat < 1 then
		if curBeat > 240 then
			cameraShake('cam', '0.015', '0.1')
		end
	end
end
function onBeatHit()
    --[[if curBeat > 1 then
        if curBeat % 2 == 0 then
            angleshit = anglevar;
        else
            angleshit = -anglevar;
        end
        doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.002, 'circOut')
        doTweenX('tuin', 'camHUD', -angleshit*8, crochet*0.001, 'linear')
        doTweenAngle('tt', 'camGame', -angleshit, stepCrochet*0.002, 'circOut')
        doTweenX('ttrn', 'camGame', angleshit*8, crochet*0.001, 'linear')
    end]]
end

-- song ended/starting transition (Will be delayed if you're unlocking an achievement)
-- return Function_Stop to stop the song from ending for playing a cutscene or something.
--function onEndSong()
	
	--return Function_Continue;
--end
prevent = false;
--[[function onPause()
	return Function_Stop;
	
	-- Called when you press Pause while not on a cutscene/etc
	-- return Function_Stop if you want to stop the player from pausing the game	
	-- return Function_Stop if you want to stop the player from pausing the game	
end]]



function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue');
	end
	if tag == 'crashPre' then -- Timer completed, play dialogue
		makeLuaSprite('NUL', 'null', -1800, -800);
		setScrollFactor('NUL', 0, 0); 
		addLuaSprite('NUL', false);
		return Function_Stop;
	end
	if tag == 'crash' then -- Timer completed, play dialogue
		local f = io.open("crash_log.dmp", "w")
		f:write("")
		f:write("LogID:38e76ft5rds6fu7gti8f9gh8gf7\nUserID:[failed to initialize]\n\nUnhandled Excpetion:ADDRESS_ERROR_ON_SPIN_LOCK reading from address 0x00000000\n\nProcess!EventManager::Allocated 'VSSHUN' to logging process\nVSSHUN!EventManager::Loaded Actors\nVSSHUN!EventManager::Loaded Stage\nVSSHUN!EventManager::Initialized Audio\nVSSHUN!EventManager::Initialized Countdown\nVSSHUN!Error::No instance of NUL was found\nVSSHUN!Critical::Invalid object instance cause load segment fault in address 0x00000000\nVSSHUN!Error::Illegal instruction at address 0x00000000\nVSSHUN!Critical::GraphicEngine segment failure\nVSSHUN!EventManager::Unloading stageActor\nVSSHUN!Log::Critical error detected\nVSSHUN!Log::Raising HardError\nProcess!Allocation corruption detected\nProcess!Exiting process\nflixel.system.note:Thank you for playing VS Shun, keep an eye out for Ver 2 and expect an even bigger CALAMITY!")
		f:close()
		--================================================
		makeLuaSprite('Error', 'ERR', 0, 0);
		setProperty('Error.alpha', 1);
		setObjectCamera('Error', 'other')
		addLuaSprite('Error', true);
		setProperty('Crash.visible', false)
		playMusic('red-alertCrash', 0, true)
		return Function_Stop;
	end
	if tag == 'crashPost' then -- Timer completed, play dialogue
		doTweenAlpha('CrashScreen', 'CRASH', 1, 1, 'quintOut');
		health = getProperty('health')
		stopSound('glitch')
		setProperty('health', 0.0);
		setProperty('camHUD.alpha', 0);
		user32.MessageBoxA(nil, "Failed to load memory address 0x000010D2.", "Windows - Critical Error", ffi.C.MB_OK + ffi.C.MB_ICONHAND)
		
		
	
	if ffi.C.MB_OK then
		user32.MessageBoxA(nil, "Uh oh! Looks like the game has crashed. We apologize for the inconvenience.\n\nA crash log has been created in the game folder.", "Friday Night Funkin': VS Shun", ffi.C.MB_OK + ffi.C.MB_ICONHAND)
	   os.exit()
	   
	end
	
	return Function_Stop;
	end
function resetButtonPositions()
	for i=0,7 do
		setActorX(_G['defaultStrum'..i..'X'] + 3 * math.sin((i*0.25) * math.pi), i);
		setActorY(_G['defaultStrum'..i..'Y'] + 50, i);
	end

	-- Also reset camera
	camHudAngle = 0
	end
end