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
local arrowMoveX = 32;
local arrowMoveY = 32;



local allowCountdown = false
function onCreate()
	for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 0)
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
end
function coolresetStrums(time)
    for i = 0,7 do
        noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear")
        noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], time, "linear")
        noteTweenAngle("movementAngle " .. i, i, 360, time, "linear")
    end
end
function onBeatHit()
	if getProperty('curBeat') == 5 then
		
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


function onUpdate(elapsed, time)
	if getProperty('health') < 0.2 then
		for i = 0,7 do
			noteTweenX("movementX " .. i, i, defaultNotePos[i + 1][1], time, "linear")
			noteTweenY("movementY " .. i, i, defaultNotePos[i + 1][2], time, "linear")
			noteTweenAngle("movementAngle " .. i, i, 360, time, "linear")
		end
	end

	songPos = getPropertyFromClass('Conductor', 'songPosition');
 
    currentBeat = (songPos / 1000) * (bpm / 90)
 
    if spin == true then 
        for i = 0,7 do 
            setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + arrowMoveX * math.sin((currentBeat + i*0.25) * math.pi))
            setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + arrowMoveY * math.cos((currentBeat + i*0.25) * math.pi))
        end
    end 
	

	for i = 0,3 do
        setPropertyFromGroup('strumLineNotes', i, 'alpha', 1)
    end

	if curStep == 641 then
		spin = true;
		for i = 0, 7, 1 do
			noteTweenAngle('tween'.. i, i, 360, 0.5, 'linear');
		end
	end
	if curStep == 1024 then
		for i=0,3 do
			setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0.25) * math.pi) + 0, i)
			setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
		for i=4,7 do
			setPropertyFromGroup('strumLineNotes', i, 'x', defaultNotePos[i + 1][1] + 32 * math.sin((currentBeat + i*0.25) * math.pi) + 0, i)
			setPropertyFromGroup('strumLineNotes', i, 'y', defaultNotePos[i + 1][2] + 32 * math.cos((currentBeat + i*0.25) * math.pi), i)
		end
		arrowMoveX = 25;
		arrowMoveY = 25;
		for i = 0, 7, 1 do
			noteTweenAngle('tween'.. i, i, 900, 0.5, 'linear');
		end
	end
	if curStep == 1025 then
		arrowMoveX = 20;
		arrowMoveY = 20;
	end
	if curStep == 1026 then
		arrowMoveX = 15;
		arrowMoveY = 15;
	end
	if curStep == 1027 then
		arrowMoveX = 10;
		arrowMoveY = 10;
	end
	if curStep == 1028 then
		arrowMoveX = 5;
		arrowMoveY = 5;
	end
	if curStep == 1029 then
		arrowMoveX = 0;
		arrowMoveY = 0;
	end
	if curStep == 1280 then
		for i = 0, 7, 1 do
			noteTweenAngle('tween'.. i, i, 1440, 0.5, 'linear');
		end
	end
	
songPos = getSongPosition()
local currentBeat = (songPos/5000)*(curBpm/30)
local currentMove = (songPos/3000)*(curBpm/60)
doTweenX('poopscale', 'poop.scale', 0 - 50*math.sin((currentBeat+1*0.1)*math.pi), 6)
doTweenY('poopscaley', 'poop.scale', 0 - 31*math.sin((currentBeat+1*1)*math.pi), 6)
doTweenX('yeah2', 'yeah2.scale', 0 - 50*math.sin((currentBeat+1*0.1)*math.pi), 6)
doTweenY('yeah2y', 'yeah2.scale', 0 - 31*math.sin((currentBeat+1*1)*math.pi), 6)
doTweenX('hi2', 'hi2.scale', 0 - 50*math.sin((currentBeat+1*0.1)*math.pi), 6)
doTweenY('hi2y', 'hi2.scale', 0 - 31*math.sin((currentBeat+1*1)*math.pi), 6)
doTweenX('opponentmove2', 'sandu', 600 - 3300*math.sin((currentBeat+12*12)*math.pi), 2)
	if started == true then
		noteTweenY('player1', 4, defaultPlayerStrumY3 - 1000*math.sin((currentBeat+8*0.1)*math.pi), 9)
		noteTweenY('player2', 5, defaultPlayerStrumY1 + 1000*math.sin((currentBeat+8*0.1)*math.pi), 9)
		noteTweenY('player3', 6, defaultPlayerStrumY0 - 1000*math.sin((currentBeat+8*0.1)*math.pi), 9)
		noteTweenY('player4', 7, defaultPlayerStrumY2 +	1000*math.sin((currentBeat+8*0.1)*math.pi), 9)
		noteTweenY('opponent1', 0, defaultOpponentStrumY3 + 1000*math.sin((currentBeat+8*0.1)*math.pi), 9)
		noteTweenY('opponent2', 1, defaultOpponentStrumY1 - 1000*math.sin((currentBeat+8*0.1)*math.pi), 9)
		noteTweenY('opponent3', 2, defaultOpponentStrumY0 + 1000*math.sin((currentBeat+8*0.1)*math.pi), 9)
		noteTweenY('opponent4', 3, defaultOpponentStrumY2 - 1000*math.sin((currentBeat+8*0.1)*math.pi), 9)
		noteTweenX('playerx1', 4, defaultPlayerStrumX0 - 1000*math.sin((currentMove+8*0.1)*math.pi), 8)
		noteTweenX('playerx2', 5, defaultPlayerStrumX1 + 1000*math.sin((currentMove+8*0.1)*math.pi), 8)
		noteTweenX('playerx3', 6, defaultPlayerStrumX2 - 1000*math.sin((currentMove+8*0.1)*math.pi), 8)
		noteTweenX('playerx4', 7, defaultPlayerStrumX3 + 1000*math.sin((currentMove+8*0.1)*math.pi), 8)
		noteTweenX('opponentx1', 0, defaultOpponentStrumX0 + 1000*math.sin((currentMove+8*0.1)*math.pi), 8)
		noteTweenX('opponentx2', 1, defaultOpponentStrumX1 - 1000*math.sin((currentMove+8*0.1)*math.pi), 8)
		noteTweenX('opponentx3', 2, defaultOpponentStrumX2 + 1000*math.sin((currentMove+8*0.1)*math.pi), 8)
		noteTweenX('opponentx4', 3, defaultOpponentStrumX3 - 1000*math.sin((currentMove+8*0.1)*math.pi), 8)
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
function opponentNoteHit()
	
end