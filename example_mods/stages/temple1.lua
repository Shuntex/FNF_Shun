function onCreate()
	-- background shit
	makeLuaSprite('temple1', 'temple1', -700, -400);
	setLuaSpriteScrollFactor('temple1', 0.9, 0.9);

	addLuaSprite('temple1', false);
	
	

	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end