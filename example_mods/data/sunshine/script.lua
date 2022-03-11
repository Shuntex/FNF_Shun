local turn = 10
local turn2 = 20
local y = 0;
local x = 0;
local canBob = true
local Strums = 'opponentStrums'

local xx = 350;
local yy = 350;
local xx2 = 820;
local yy2 = 450;
local ofs = 30;
local followchars = true;
local del = 0;
local del2 = 0;
local defaultNotePos = {};
local spin = false;
local arrowMoveX = 30;
local arrowMoveY = 30;

--function onCreatePost()

--addChromaticAbberationEffect('camHUD', 0.003)
--addChromaticAbberationEffect('dad', 0.003)
--addChromaticAbberationEffect('bf', 0.003)

--end



function onCreate()
	makeAnimatedLuaSprite('NoPause', 'DANGER', 0, 0);
	setObjectCamera('NoPause', 'other');
	addAnimationByPrefix('NoPause', 'STOP', 'DANGER', 24, true)
	objectPlayAnimation('NoPause', 'STOP', false)
	setProperty('NoPause.visible', false)
	addLuaSprite('NoPause',true)
	--[[for i=0,4,1 do
		setPropertyFromGroup('opponentStrums', i, 'texture', 'Fallen Notes')
		--setPropertyFromGroup('unspawnNotes', i, 'texture', 'Fallen Notes')
	end
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if not getPropertyFromGroup('unspawnNotes', i, 'mustPress') then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Fallen Notes'); --Change texture
		end
	end]]
	addPulseffect('place',0.85,2,0.5,1)
end

prevent = false;
--function onPause()
	--if prevent == false then
	--	prevent = true
	--	if allowPause == false then
	--		makeAnimatedLuaSprite('NoPause', 'DANGER', 0, 0);
	--		setObjectCamera('NoPause', 'other');
	--		addAnimationByPrefix('NoPause', 'STOP', 'DANGER', 24, false)
	--		objectPlayAnimation('NoPause', 'STOP', false)
	--		setProperty('NoPause.visible', true)
	--		addLuaSprite('NoPause',true)
	--		prevent = true
	--	end
	--	
	--	runTimer('unPause', '2');
		
	--end
	--return Function_Stop;
	-- Called when you press Pause while not on a cutscene/etc
	-- return Function_Stop if you want to stop the player from pausing the game	
--end

local allowCountdown = false
function onStartCountdown()
	-- Block the first countdown and start a timer of 0.8 seconds to play the dialogue
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end

function onEndSong()
	if not allowCountdown and isStoryMode and not seenCutscene then
		setProperty('inCutscene', true);
		runTimer('startFinalDialogue', 0.8);
		allowCountdown = true;
		return Function_Stop;
	end
	return Function_Continue;
end



function onSongStart()
	for i = 0,7 do 
        x = getPropertyFromGroup('strumLineNotes', i, 'x')
 
        y = getPropertyFromGroup('strumLineNotes', i, 'y')
 
        table.insert(defaultNotePos, {x,y})
    end
end
function coolresetStrums(time)
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear")
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], time, "linear")
        noteTweenAngle("movementAngle " .. i, i, 360, time, "linear")
    end
end


local hurt = 0.006;
local shake = 0.01;
local shakeTime = 0.08;


function onStepHit()
	
end



function onMoveCamera(focus)
    if focus == 'boyfriend' then
        setProperty ('defaultCamZoom', 0.5)
    elseif focus == 'dad' then
        setProperty ('defaultCamZoom', 0.65)
    end
end

-- Dialogue (When a dialogue is finished, it calls startCountdown again)
function onNextDialogue(count)
	-- triggered when the next dialogue line starts, 'line' starts with 1
end

function onSkipDialogue(count)
	-- triggered when you press Enter and skip a dialogue line that was still being typed, dialogue line starts with 1
end

function onUpdate(elapsed)
	for i = 0, 7, 1 do
        noteTweenAngle('tween'.. i, i, 360, 1, 'linear');
    end
-- =============================================  
	if del > 0 then
		del = del - 1
	end
	if del2 > 0 then
		del2 = del2 - 1
	end
    if followchars == true then
        if mustHitSection == false then
            if getProperty('dad.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singLEFT-alt' then
                triggerEvent('Camera Follow Pos',xx-ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singRIGHT-alt' then
                triggerEvent('Camera Follow Pos',xx+ofs,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'singUP-alt' then
                triggerEvent('Camera Follow Pos',xx,yy-ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'singDOWN-alt' then
                triggerEvent('Camera Follow Pos',xx,yy+ofs)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle-alt' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
            if getProperty('dad.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx,yy)
            end
        else

            if getProperty('boyfriend.animation.curAnim.name') == 'singLEFT' then
                triggerEvent('Camera Follow Pos',xx2-ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singRIGHT' then
                triggerEvent('Camera Follow Pos',xx2+ofs,yy2)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singUP' then
                triggerEvent('Camera Follow Pos',xx2,yy2-ofs)
            end
            if getProperty('boyfriend.animation.curAnim.name') == 'singDOWN' then
                triggerEvent('Camera Follow Pos',xx2,yy2+ofs)
            end
	    if getProperty('boyfriend.animation.curAnim.name') == 'idle' then
                triggerEvent('Camera Follow Pos',xx2,yy2)
            end
        end
    else
        triggerEvent('Camera Follow Pos','','')
    end
	
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue');
	end
	if tag == 'startFinalDialogue' then -- Timer completed, play dialogue
		startDialogue('final');
	end
	if tag == 'unPause' then
		removeLuaSprite('NoPause', true)
		prevent = false
	end
end


function opponentNoteHit()
    --health = getProperty('health')
    --if getProperty('health') > 0.1 then
    --    setProperty('health', health- 0.008);
    --end
	cameraShake("game", 0.02, 0.014);
end