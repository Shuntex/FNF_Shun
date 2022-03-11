function onCreate()
	-- background shit
	makeLuaSprite('temple1', 'temple1', -600, -300);
	setLuaSpriteScrollFactor('temple1', 0.9, 0.9);

	addLuaSprite('temple1', false);
	
	makeLuaSprite('introchar', 'Char', 100, 0);
	setObjectCamera('introcircle', 'other');
	addLuaSprite('introcircle', true);

	makeLuaSprite('introtext', 'TextSako', -100, 0);
	setObjectCamera('introtext', 'other');
	addLuaSprite('introtext', true);

	makeAnimatedLuaSprite('Static', 'screenstatic', 0, 0);
	setObjectCamera('Static', 'other');
	addAnimationByPrefix('Static', 'tssssssss', 'screenSTATIC', 24, true)
	objectPlayAnimation('Static', 'tssssssss', false)
	setProperty('Static.visible', false)
	addLuaSprite('Static',true)
	
	makeLuaSprite('TBC', 'to_be_cont', 0, 0);
	scaleObject('TBC', 6.0, 6.0);
	setObjectCamera('TBC', 'other');
	setProperty('TBC.visible', false)
	addLuaSprite('TBC',true)
end
function onUpdate(elapsed)
	if getProperty('curBeat') == 256 then
		setProperty('TBC.visible', true)
	end
end