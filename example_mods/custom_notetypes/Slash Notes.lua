function onCreate()
	--Iterate over all notes
	for i = 0, getProperty('unspawnNotes.length')-1 do
		--Check if the note is an Instakill Note
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'Slash Notes' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'Slash Notes'); --Change texture

			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
			
			end
		end
	end
end
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'Slash Notes' then
		if noteData == 0 and noteType == 'Slash Notes' then
			playSound('slash', 1.0)
			characterPlayAnim('dad', 'slashLEFT', true);
			characterPlayAnim('boyfriend', 'dodge', true);
			setProperty('boyfriend.specialAnim', true)
		elseif noteData == 1 and noteType == 'Slash Notes' then
			playSound('slash', 1.0)
			characterPlayAnim('dad', 'slashDOWN', true);
			characterPlayAnim('boyfriend', 'dodge', true);
			setProperty('boyfriend.specialAnim', true)
		elseif noteData == 2 and noteType == 'Slash Notes' then
			playSound('slash', 1.0)
			characterPlayAnim('dad', 'slashUP', true);
			characterPlayAnim('boyfriend', 'dodge', true);
			setProperty('boyfriend.specialAnim', true)
		elseif noteData == 3 and noteType == 'Slash Notes' then
			playSound('slash', 1.0)
			characterPlayAnim('dad', 'slashRIGHT', true);
			characterPlayAnim('boyfriend', 'dodge', true);
			setProperty('boyfriend.specialAnim', true)
		end
	end
end
function noteMiss(id, direction, noteType, isSustainNote)
	if noteType == "Slash Notes" then
		setProperty('health', -0);
	end
end