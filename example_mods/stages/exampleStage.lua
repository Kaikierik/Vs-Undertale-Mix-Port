local shadersEnabled = true
function onCreate()
	-- background shit

	setProperty('defaultCamZoom', 0.8)

	makeLuaSprite('stageback', 'back', -300, -300);
	setScrollFactor('stageback', 0, 0);

	makeLuaSprite('stageback2', 'back2', -100, -100);
	setScrollFactor('stageback2', 0.2, 0.2);
	scaleObject('stageback2', 0.8,0.8)
	
	makeLuaSprite('stagefront', 'ground', -650, 750);
	setScrollFactor('stagefront', 1, 1);
	scaleObject('stagefront', 1.1, 1.1);

	makeLuaSprite('stagefront2', 'ground2', -550, -200);
	setScrollFactor('stagefront2', 0.8, 0.8);
	scaleObject('stagefront2', 1.1, 1.1);

	makeLuaSprite('stagecurtains', 'blurl', -500, -200);
	setScrollFactor('stagecurtains', 1.3, 1.3);
	scaleObject('stagecurtains', 1, 1);

	makeLuaSprite('stagecurtains2', 'blurr', 700, -200);
	setScrollFactor('stagecurtains2', 1.3, 1.3);
	scaleObject('stagecurtains2', 1, 1);

	makeLuaSprite('web1', 'web1', -500, -200);
	setScrollFactor('web1', 0.7, 0.7);
	scaleObject('web1', 1, 1);

	makeLuaSprite('web2', 'web2', -500, -200);
	setScrollFactor('web2', 0.8, 0.8);
	scaleObject('web2', 1, 1);

	makeLuaSprite('web3', 'web3', -200, -200);
	setScrollFactor('web3', 0.9, 0.9);
	scaleObject('web3', 0.9, 0.9);

	makeLuaSprite('black', 'black', -200, -200);
	setScrollFactor('black', 0, 0);
	scaleObject('black', 2, 2);

	addLuaSprite('stageback', false);
	addLuaSprite('stageback2', false);
	addLuaSprite('stagefront2', false);
	addLuaSprite('stagefront', false);
	addLuaSprite('stagelight_left', false);
	addLuaSprite('stagelight_right', false);
	addLuaSprite('web1', false);
	addLuaSprite('web2', false);
	addLuaSprite('web3', false);
	addLuaSprite('stagecurtains', true);
	addLuaSprite('stagecurtains2', true);
	addLuaSprite('black', true);
	
	close(true); --For performance reasons, close this script once the stage is fully loaded, as this script won't be used anymore after loading the stage
end