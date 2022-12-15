function onCreate()
	-- background shit

	setProperty('defaultCamZoom', 0.8)

	makeLuaSprite('stageback', 'snowback', -500, -200);
	setScrollFactor('stageback', 1, 1);
	scaleObject('stageback', 0.9, 0.9)

	makeLuaSprite('back', 'placeholda', -250, -200);
	setScrollFactor('back', 1, 1);
	scaleObject('back', 0.7, 0.6)

	makeLuaSprite('fog', 'fog', -200, -100);
	setScrollFactor('fog', 0, 0);
	scaleObject('fog', 0.9, 0.9)

	makeLuaSprite('fog2', 'snowback', -200, -100);
	setScrollFactor('fog2', 0, 0);
	scaleObject('fog2', 0.9, 0.9)

	makeLuaSprite('black', 'black', -200, -200);
	setScrollFactor('black', 0, 0);
	scaleObject('black', 2, 2);

	makeLuaSprite('jumpscare', 'jumpscare', -280, -200);
	setScrollFactor('jumpscare', 0, 0);
	scaleObject('jumpscare', 0.8, 0.8);

	addLuaSprite('stageback', false);
	addLuaSprite('back', false);
	addLuaSprite('fog', true);
	addLuaSprite('fog2', true);
	addLuaSprite('black', true);
	addLuaSprite('jumpscare', true);
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end