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
local spin = true;
local arrowMoveX = 2;
local arrowMoveY = 2;

local isCrashing = false;
--function onCreatePost()

--addChromaticAbberationEffect('camHUD', 0.003)
--addChromaticAbberationEffect('dad', 0.003)
--addChromaticAbberationEffect('bf', 0.003)

--end



function onCreate()
	makeLuaSprite('HP', 'HP_PROHIBIT_SCREEN', 0, 0);
	setProperty('HP.alpha', 0);
	setObjectCamera('HP', 'other')
	setProperty('HpProh.visible', true)
	addLuaSprite('HP', true);

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
	cameraFlash(camHUD, white, 0.4,'true')
	cameraFlash(game, white, 0.4,'true')

	cameraShake("HUD", 0.06, 0.5);
	cameraShake("other", 0.06, 0.5);
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

function onBeatHit()
	--[[health = getProperty('health')
    if getProperty('health') > 0.1 then
		setProperty('health', health- 0.016);
    end]]
end
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
	if isCrashing == false then
		if keyJustPressed('accept') then
			runTimer('noPause', 0.8);
			setProperty('NoPause.visible', true)
			objectPlayAnimation('NoPause.visible', 'DANGER', true)
		end
	end

	doTweenAlpha('HpAlpha', 'HP', 0.6, 0.8, 'quintOut');
	--[[for i = 0, 7, 1 do
        noteTweenAngle('tween'.. i, i, 360, 1, 'linear');
    end]]
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
	--[[for i=0,3 do
		-- Alpha is 0 (0 being invisible)
		noteTweenAlpha(i+16, i, math.floor(curStep/9999), 0.3)
	end]]
	if getProperty('health') < 0.2 then
		for i = 0,7 do
			noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear")
			noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], time, "linear")
			noteTweenAngle("movementAngle " .. i, i, 360, time, "linear")
		end
	end

	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 1000) * (bpm / 8)
 
    if spin == true then 
        for i = 0,7 do 
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + arrowMoveX * math.sin((currentBeat + i*0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + arrowMoveY * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end 
	
	if curStep > 121 then
		health = getProperty('health')
		if getProperty('health') > 0.05 then
			setProperty('health', health- '0.06'  * elapsed);
		end
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
	if tag == 'noPause' then
		setProperty('NoPause.visible', false)
		objectPlayAnimation('NoPause.visible', 'DANGER', true)
	end
end

function goodNoteHit()
	setProperty('health', health+ '0.1');
end

function opponentNoteHit(id, direction, noteData, noteType, isSustainNote, tag, loops, loopsleft)
    --[[health = getProperty('health')
    if getProperty('health') > 0.1 then
		if getProperty('!isSustainNote') then
			setProperty('health', health- 0.025);
		end
    end]]
	if curStep > 176 then
		health = getProperty('health')
		if getProperty('health') > 0.05 then
			setProperty('health', health- '0.02');
		end
	end
	
	cameraShake("game", 0.03, 0.017);
	if noteType == 'Fallen Note' then
		setProperty('health', health- 0.03);
	end
end