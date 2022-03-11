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
local arrowMoveX = 60;
local arrowMoveY = 0;

local angleshit = 1.5;
local anglevar = 1.5;

local speen = 270;
 
local allowCountdown = false
function onCreate()
	for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
    end
	
	makeLuaSprite('Continue', 'Cont', 0, 0);
	setProperty('Continue.alpha', 0);
	setObjectCamera('Continue', 'other')
	addLuaSprite('Continue', true);
	
	
end

function onMoveCamera(focus)
	if focus == 'boyfriend' then
		-- called when the camera focus on boyfriend
		setProperty('defaultCamZoom', 0.6);
	elseif focus == 'dad' then
		-- called when the camera focus on dad
		setProperty('defaultCamZoom', 0.35);
	end
end

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
function onSongStart()
	for i = 0,7 do 
        x = getPropertyFromGroup('strumLineNotes', i, 'x')
 
        y = getPropertyFromGroup('strumLineNotes', i, 'y')
 
        table.insert(defaultNotePos, {x,y})
    end
	for i = 0, 7, 1 do
		noteTweenAngle('tween'.. i, i, speen, 0.2, 'circOut');
	end
end
function coolresetStrums(time)
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear")
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], time, "linear")
        noteTweenAngle("movementAngle " .. i, i, 360, time, "linear")
    end
end

function onBeatHit()
	
		
	if curBeat > 124 then
        --if spin == false then
			if curBeat % 2 == 0 then
            angleshit = anglevar;
			else
				angleshit = -anglevar;
			end
			 setProperty('camHUD.angle',angleshit*0)
        --setProperty('camGame.angle',angleshit*3)
        doTweenAngle('turn', 'camHUD', angleshit, stepCrochet*0.000, 'circOut')
        doTweenX('tuin', 'camHUD', -angleshit*20, crochet*0.001, 'linear')
        --doTweenAngle('tt', 'camGame', angleshit, stepCrochet*0.002, 'circOut')
        --doTweenX('ttrn', 'camGame', -angleshit*8, crochet*0.001, 'linear')
		--end
    end
	
	if curBeat > 384 then
        doTweenAlpha('ContinueAlpha', 'Continue', 1.0, 1.0, 'quintOut');
    end
end

function onTimerCompleted(tag, loops, loopsLeft)
	if tag == 'startDialogue' then -- Timer completed, play dialogue
		startDialogue('dialogue');
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
	if getProperty('health') < 0.2 then
		for i = 0,7 do
			noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear")
			noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], time, "linear")
			noteTweenAngle("movementAngle " .. i, i, 360, time, "linear")
		end
	end

	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 1000) * (bpm / 80)
 
    if spin == true then 
        for i = 0,7 do 
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + arrowMoveX * math.sin((currentBeat + i*0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + arrowMoveY * math.cos((currentBeat + i*0.25) * math.pi))
        end
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
    for i=0,3 do
		-- Alpha is 0 (0 being invisible)
		noteTweenAlpha(i+16, i, math.floor(curStep/9999), 0.3)
	end
end
function opponentNoteHit()
	cameraShake("game", 0.01, 0.08);
    speen = speen + 270
    for i = 0, 7, 1 do
		noteTweenAngle('tween'.. i, i, speen, 0.00001, 'linear');
	end
end
function onPause()
	return Function_Stop;
	
	-- Called when you press Pause while not on a cutscene/etc
	-- return Function_Stop if you want to stop the player from pausing the game	
	-- return Function_Stop if you want to stop the player from pausing the game	
end