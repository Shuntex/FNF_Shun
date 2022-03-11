function onCreate()
	-- background shit
	makeLuaSprite('calamity', 'calamity', -600, -300);
	setLuaSpriteScrollFactor('calamity]', 0.9, 0.9);

	addLuaSprite('calamity', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end