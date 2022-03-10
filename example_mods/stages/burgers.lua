function onCreate()
	if not lowQuality then
		makeLuaSprite('burgers', 'backgrounds/burgers/burgers', 175, -102);
	end

	addLuaSprite('burgers', false);
	
	close(true);
end
