function onCreate()
	makeAnimatedLuaSprite('Static', 'screenstatic', 0, 0);
	setObjectCamera('Static', 'other');
	addAnimationByPrefix('Static', 'tssssssss', 'screenSTATIC', 30, true)
	objectPlayAnimation('Static', 'tssssssss', false)
	setProperty('Static.visible', false)
	addLuaSprite('Static',true)
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an CRASH_NOTES
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'CRASH_NOTES' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'CRASH_NOTES'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '-500'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '500'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'HyperNote-Splash');

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', true); --Miss has no penalties
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'CRASH_NOTES' then
		
	end
end

-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen
function noteMiss(id, noteData, noteType, isSustainNote, tag, loops, loopsleft)
	if noteType == 'CRASH_NOTES' then
		playSound('hyperNote', 0.5)
		setProperty('Static.visible', true)
		playSound('staticBUZZ', 1, 'bruuuuh')
		runTimer('wait', '0.3');
	end
end
function onTimerCompleted(tag, loops, loopsleft)
	if tag == 'wait' then
		setProperty('Static.visible', false)
		stopSound('bruuuuh')
	end
end