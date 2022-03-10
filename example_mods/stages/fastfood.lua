function onCreate()
	makeLuaSprite('floor', 'backgrounds/fastfood/floor', -550, -200);
	
	if not lowQuality then
		makeLuaSprite('windows', 'backgrounds/fastfood/windows', -550, -200);

		makeLuaSprite('tables', 'backgrounds/fastfood/tables', -600, -50);
	end

	addLuaSprite('floor', false);
	addLuaSprite('windows', false);
	addLuaSprite('tables', true);
	
	close(true);
end