function onCreate()
	-- background shit
	makeLuaSprite('temple3', 'temple3', -600, -300);
	setLuaSpriteScrollFactor('temple3', 0.9, 0.9);

	addLuaSprite('temple3', false);

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end