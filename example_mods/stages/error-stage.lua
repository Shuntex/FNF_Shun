function onCreate()

    setPropertyFromClass('ClientPrefs', 'timeBarType', 'Disabled');

	makeLuaSprite('BSOD-sky', 'sky2', -1800, -800);
	setScrollFactor('BSOD-sky', 0, 0);
    addLuaSprite('BSOD-sky', false);

	--makeAnimatedLuaSprite('BSOD-sky','sky', -1800, -800);
	--setScrollFactor('BSOD-sky', 0, 0);
	--addAnimationByPrefix('BSOD-sky', 'Animation', 'SkyAnim', 12, false);
	--objectPlayAnimation('BSOD-sky', 'Animation', false);
	--addLuaSprite('BSOD-sky', false);

	makeLuaSprite('BSOD-back', 'foresky', -1800, -800);
	setScrollFactor('BSOD-back', 0.5, 0.5);
    addLuaSprite('BSOD-back', false);
	
	makeLuaSprite('BSOD-Fore', 'foretrees', -1800, -800);
	setScrollFactor('BSOD-Fore', 0.8, 0.8);
    addLuaSprite('BSOD-Fore', false);

	makeLuaSprite('BSOD-ground', 'ground', -1800, -800);
	setScrollFactor('BSOD-ground', 0.9, 0.9);
	addLuaSprite('BSOD-ground', false);
	close(true);
end