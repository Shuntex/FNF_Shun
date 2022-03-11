function onCreate()
	makeAnimatedLuaSprite('Static', 'screenstatic', 0, 0);
	setObjectCamera('Static', 'other');
	addAnimationByPrefix('Static', 'tssssssss', 'screenSTATIC', 30, true)
	objectPlayAnimation('Static', 'tssssssss', false)
	setProperty('Static.visible', false)
	addLuaSprite('Static',true)
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Fallen Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Fallen Note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Fallen Notes'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.023, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '0'); --Default value is: 0.0475, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', true);
			setPropertyFromGroup('unspawnNotes', i, 'noteSplashTexture', 'FallenNotes_Splash');

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
	if noteType == 'Fallen Note' then
		playSound('hyperNote', 0.5)
	end
end

-- Called after the note miss calculations
-- Player missed a note by letting it go offscreen
function noteMiss(id, noteData, noteType, isSustainNote, tag, loops, loopsleft)
	if noteType == 'Hyper Note' then
		playSound('hyperNote', 0.5)
	end
end
function onTimerCompleted(tag, loops, loopsleft)
	
end