function onCreate()

    setProperty('defaultCamZoom', 0.7);

	setPropertyFromClass('ClientPrefs', 'timeBarType', 'Disabled');

	makeLuaSprite('exeSky', 'sky', -600, -800);
	setScrollFactor('exeSky', 0.2, 0.2);
    addLuaSprite('exeSky', false);

	makeLuaSprite('backtree', 'backtrees', -600, -800);
	setScrollFactor('backtree', 0.5, 0.5);
    addLuaSprite('backtree', false);
	
	makeLuaSprite('yepMountains', 'mountains', -600, -800);
	setScrollFactor('yepMountains', 0.8, 0.8);
    addLuaSprite('yepMountains', false);

	makeLuaSprite('exeGround', 'ground', -600, -800);
	setScrollFactor('exeGround', 0.9, 0.9);
	addLuaSprite('exeGround', false);
	close(true);
end