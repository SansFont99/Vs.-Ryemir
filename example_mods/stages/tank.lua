-- ALL of this was stolen from a week 7 psych engine port
-- specifically this one https://www.mediafire.com/file/05b9uore2hb684q/The_Week_7_Modpack_%252B_Pause_Script.rar/file
tankX = 400;
tankSpeed = 0;
tankAngle = 0;
finishedGameover = false;
startedPlaying = false;

function onCreate()
	-- background shit
	tankSpeed = getRandomInt(5, 7);
	tankAngle = getRandomInt(-90, 45);
	makeLuaSprite('tankSky', 'backgrounds/tank/tankSky', -400, -400);
	setLuaSpriteScrollFactor('tankSky', 0, 0);

	makeLuaSprite('tankBuildings', 'backgrounds/tank/tankBuildings', -200, 0);
	setLuaSpriteScrollFactor('tankBuildings', 0.3, 0.3);
	scaleObject('tankBuildings', 1.1, 1.1);

	makeLuaSprite('tankRuins', 'backgrounds/tank/tankRuins', -200, 0);
	setLuaSpriteScrollFactor('tankRuins', 0.35, 0.35);
	scaleObject('tankRuins', 1.1, 1.1);

	makeAnimatedLuaSprite('tankWatchtower', 'backgrounds/tank/tankWatchtower', 100, 50);
	luaSpriteAddAnimationByPrefix('tankWatchtower', 'idle', 'watchtower', 24, false);
	setLuaSpriteScrollFactor('tankWatchtower', 0.5, 0.5);

	makeAnimatedLuaSprite('tankRolling', 'backgrounds/tank/tankRolling', 300, 300);
	luaSpriteAddAnimationByPrefix('tankRolling', 'idle', 'BG tank w lighting', 24, true);
	setLuaSpriteScrollFactor('tankRolling', 0.5, 0.5);

	makeLuaSprite('tankGround', 'backgrounds/tank/tankGround', -420, -150);
	scaleObject('tankGround', 1.15, 1.15);
	
	-- those are only loaded if you have Low quality turned off, to decrease loading times and memory
	if not lowQuality then
		makeLuaSprite('tankClouds', 'backgrounds/tank/tankClouds', getRandomInt(-700, -100), getRandomInt(-20, 20));
		setLuaSpriteScrollFactor('tankClouds', 0.1, 0.1);
		setProperty('tankClouds.velocity.x', getRandomInt(5, 15));

		makeLuaSprite('tankMountains', 'backgrounds/tank/tankMountains', -300, -20);
		setLuaSpriteScrollFactor('tankMountains', 0.2, 0.2);
		scaleObject('tankMountains', 1.2, 1.2);

		makeAnimatedLuaSprite('smokeLeft', 'backgrounds/tank/smokeLeft', -200, -100);
		luaSpriteAddAnimationByPrefix('smokeLeft', 'idle', 'SmokeBlurLeft');
		setLuaSpriteScrollFactor('smokeLeft', 0.4, 0.4);

		makeAnimatedLuaSprite('smokeRight', 'backgrounds/tank/smokeRight', 1100, -100);
		luaSpriteAddAnimationByPrefix('smokeRight', 'idle', 'SmokeRight');
		setLuaSpriteScrollFactor('smokeRight', 0.4, 0.4);
	end

	addLuaSprite('tankSky', false);
	addLuaSprite('tankClouds', false);
	addLuaSprite('tankMountains', false);
	addLuaSprite('tankBuildings', false);
	addLuaSprite('tankRuins', false);
	addLuaSprite('smokeLeft', false);
	addLuaSprite('smokeRight', false);
	addLuaSprite('tankWatchtower', false);
	addLuaSprite('tankRolling', false);
	addLuaSprite('tankGround', false);


	-- foreground shit
	makeAnimatedLuaSprite('tank0', 'backgrounds/tank/tank0', -500, 650);
	luaSpriteAddAnimationByPrefix('tank0', 'idle', 'fg', 24, false);
	setLuaSpriteScrollFactor('tank0', 1.7, 1.5);
	
	makeAnimatedLuaSprite('tank2', 'backgrounds/tank/tank2', 450, 940);
	luaSpriteAddAnimationByPrefix('tank2', 'idle', 'foreground', 24, false);
	setLuaSpriteScrollFactor('tank2', 1.5, 1.5);
	
	makeAnimatedLuaSprite('tank5', 'backgrounds/tank/tank5', 1620, 700);
	luaSpriteAddAnimationByPrefix('tank5', 'idle', 'fg', 24, false);
	setLuaSpriteScrollFactor('tank5', 1.5, 1.5);
	
	if not lowQuality then
		makeAnimatedLuaSprite('tank1', 'backgrounds/tank/tank1', -300, 750);
		luaSpriteAddAnimationByPrefix('tank1', 'idle', 'fg', 24, false);
		setLuaSpriteScrollFactor('tank1', 2.0, 0.2);
		
		makeAnimatedLuaSprite('tank4', 'backgrounds/tank/tank4', 1300, 900);
		luaSpriteAddAnimationByPrefix('tank4', 'idle', 'fg', 24, false);
		setLuaSpriteScrollFactor('tank4', 1.5, 1.5);
		
		makeAnimatedLuaSprite('tank3', 'backgrounds/tank/tank3', 1300, 1200);
		luaSpriteAddAnimationByPrefix('tank3', 'idle', 'fg', 24, false);
		setLuaSpriteScrollFactor('tank3', 3.5, 2.5);
	end

	addLuaSprite('tank0', true);
	addLuaSprite('tank1', true);
	addLuaSprite('tank2', true);
	addLuaSprite('tank4', true);
	addLuaSprite('tank5', true);
	addLuaSprite('tank3', true);

	moveTank(0);
	print('finished loading stage successfully')
end

function onUpdate(elapsed)
	moveTank(elapsed);
	
	if inGameOver and not startedPlaying and not finishedGameover then
		setPropertyFromClass('flixel.FlxG', 'sound.music.volume', 0.2);
	end
      if not finishedGameover and getProperty('boyfriend.animation.curAnim.name') == 'deathLoop' and not startedPlaying then
            math.randomseed(curBeat * 4)
            soundName = string.format('ryemirGameover%i', getRandomInt(1, 4))
            playSound(soundName, 1, 'voiceJeff')
            startedPlaying = true
      end
end

function moveTank(elapsed)
	if not inCutscene then
		tankAngle = tankAngle + (elapsed * tankSpeed);
		setProperty('tankRolling.angle', tankAngle - 90 + 15);
		setProperty('tankRolling.x', tankX + (1500 * math.cos(math.pi / 180 * (1 * tankAngle + 180))));
		setProperty('tankRolling.y', 1300 + (1100 * math.sin(math.pi / 180 * (1 * tankAngle + 180))));
	end
end

-- Gameplay/Song interactions
function onBeatHit()
	-- triggered 2 times per section
      if curBeat % 2 == 0 then
	      objectPlayAnimation('tankWatchtower', 'idle', true);
	      objectPlayAnimation('tank0', 'idle', true);
	      objectPlayAnimation('tank1', 'idle', true);
	      objectPlayAnimation('tank2', 'idle', true);
	      objectPlayAnimation('tank3', 'idle', true);
	      objectPlayAnimation('tank4', 'idle', true);
	      objectPlayAnimation('tank5', 'idle', true);
      end
end

function onSongStart()
      objectPlayAnimation('tankWatchtower', 'idle', true);
	objectPlayAnimation('tank0', 'idle', true);
	objectPlayAnimation('tank1', 'idle', true);
	objectPlayAnimation('tank2', 'idle', true);
	objectPlayAnimation('tank3', 'idle', true);
	objectPlayAnimation('tank4', 'idle', true);
	objectPlayAnimation('tank5', 'idle', true);
end

function onGameOverConfirm(reset)
	finishedGameover = true;
end

function onSoundFinished(tag)
	if tag == 'voiceJeff' and not finishedGameover then
		soundFadeIn(nil, 4, 0.2, 1);
	end
end