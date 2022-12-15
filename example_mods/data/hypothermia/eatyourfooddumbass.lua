canFreeze = false
yourtriallife = 10
youcaneat = false

function onStepHit()
	if curStep == 64 then
		canFreeze = true
		youcaneat = true
	elseif curStep == 1344 then
		canFreeze = false
		youcaneat = false
		 doTweenAlpha('pissAlpha', 'piss',0,1, 'Linear')
    	doTweenAlpha('bunAlpha', 'bun',0,1, 'Linear')
    	doTweenAlpha('bun2Alpha', 'bun2',0,1, 'Linear')
    	doTweenAlpha('fillAlpha', 'fill',0,1, 'Linear')
    	doTweenAlpha('borderAlpha', 'border',0,1, 'Linear')
    	doTweenAlpha('foodCountAlpha', 'foodCount',0,1, 'Linear')
    end
end

function  onCreatePost()
	makeLuaSprite('border', nil,50, 120)
	makeGraphic('border',50,400, '000000')
	addLuaSprite('border')

	makeLuaSprite('fill', nil,60, 130)
	makeGraphic('fill',30,380, 'fe0000')
	addLuaSprite('fill')

	makeLuaSprite('piss', nil, 40, 508)
	makeGraphic('piss',30,380, 'ffff00')
	setProperty('piss.origin.x', 25)
	setProperty('piss.origin.y', 1)
	setProperty('piss.angle', 180)
	addLuaSprite('piss')

	makeLuaSprite('piss2', nil, 200, 130)
	makeGraphic('piss2',30,380, 'ffff00')
	scaleObject('piss2',1,0)
	addLuaSprite('piss2')
	setProperty('piss2.alpha',0)

	makeAnimatedLuaSprite('bun', 'bun', 35, 45);
    addAnimationByPrefix('bun', 'idle1','bun full', 24, true);
    addAnimationByPrefix('bun', 'idle2','bun bite', 24, true);
    addAnimationByPrefix('bun', 'idle3','bun half', 24, true);
    addAnimationByPrefix('bun', 'idle4','bun almost',24,true);
    addAnimationByPrefix('bun', 'idle5','bun done', 24, true);
    objectPlayAnimation('bun','idle1',true)

    makeAnimatedLuaSprite('bun2', 'bun', 31, 42);
    addAnimationByPrefix('bun2', 'idle1','bun full', 24, true);
    addAnimationByPrefix('bun2', 'idle2','bun bite', 24, true);
    addAnimationByPrefix('bun2', 'idle3','bun half', 24, true);
    addAnimationByPrefix('bun2', 'idle4','bun almost',24,true);
    addAnimationByPrefix('bun2', 'idle5','bun done', 24, true);
    objectPlayAnimation('bun2','idle1',true)
    setProperty('bun2.color','000000')
    scaleObject('bun2',1.1,1.1)


    addLuaSprite('bun2')
    addLuaSprite('bun')

	makeLuaText('foodCount', 'x'..yourtriallife, 300, -10, 70)
	addLuaText('foodCount')
	setTextSize('foodCount',25)

	if downscroll == false then
		setProperty('foodCount.y',616)
		setProperty('bun.y', 586)
    	setProperty('bun2.y', 583)
    	setProperty('piss.y',580)
		setProperty('fill.y', 202)
    	setProperty('border.y', 190)
	end

	setObjectCamera('border','hud')
	setObjectCamera('fill','hud')
	setObjectCamera('piss','hud')
	setObjectCamera('piss2','hud')
	setObjectCamera('bun','hud')
	setObjectCamera('bun2','hud')
	setObjectCamera('foodCount','hud')

	--makeLuaText('healthText', 'Health: ' .. (getProperty("piss.scale.y")), 300, screenWidth / 2 - 300 / 2, screenHeight / 2 - 300 / 1.5) -- Debug Stuff
    --addLuaText('healthText')
  	--setTextSize('healthText', 30);
  	--makeLuaText('healthText2', 'Y: ' .. (getProperty("piss.y")), 300, 500, 500) -- Debug Stuff
    --addLuaText('healthText2')
  	--setTextSize('healthText2', 30);

end

function onBeatHit()
    if canFreeze == true then
		setProperty('piss.scale.y',getProperty('piss.scale.y')-0.01)
		setProperty('piss2.scale.y',getProperty('piss2.scale.y')+0.01)
    end
end

function onUpdate(elapsed)
	if getProperty('piss.scale.y') < 0	then 
		setProperty('health', 0)
	end
	setTextString('foodCount', 'x'..yourtriallife)
	--setTextString('healthText', 'Health: ' .. (getProperty("piss.scale.y"))) -- Debug Stuff 2
	--setTextString('healthText2', 'Y: ' .. (getProperty("piss.y"))) -- Debug Stuff 2
end



function opponentNoteHit()
	health = getProperty('health')
	if health > 0.1 then
		setProperty('health', health-0.03 * getProperty('piss2.scale.y'))
	end
end

function onUpdatePost(elapsed)
	if keyJustPressed('space') and yourtriallife > 0 and youcaneat == true then 
		characterPlayAnim('boyfriend', 'eat', true)
		setProperty('boyfriend.specialAnim', true);
		yourtriallife = yourtriallife - 1
		playSound('eat')
		canFreeze = false
		runTimer('invinc',0.5)
		if getProperty('piss.scale.y') == 0.75 or getProperty('piss.scale.y') > 0.75 then
			setProperty('piss.scale.y',1)
		else
			setProperty('piss.scale.y',getProperty('piss.scale.y') + 0.25)
		end
		if getProperty('piss2.scale.y') == 0.25 or getProperty('piss2.scale.y') < 0.25 then
			setProperty('piss2.scale.y',0)
		else
			setProperty('piss2.scale.y',getProperty('piss2.scale.y') - 0.25)
		end
		if yourtriallife > 7 then
			objectPlayAnimation('bun','idle1',true)
			objectPlayAnimation('bun2','idle1',true)
		elseif yourtriallife > 5  and yourtriallife < 8 then
			objectPlayAnimation('bun','idle2',true)
			objectPlayAnimation('bun2','idle2',true)
		elseif yourtriallife > 2 and yourtriallife < 6 then
			objectPlayAnimation('bun','idle3',true)
			objectPlayAnimation('bun2','idle3',true)
		elseif yourtriallife > 0 and yourtriallife < 3  then
			objectPlayAnimation('bun','idle4',true)
			objectPlayAnimation('bun2','idle4',true)
		elseif yourtriallife == 0 then
			objectPlayAnimation('bun','idle5',true)
			objectPlayAnimation('bun2','idle5',true)
		end

	end
end 

function onTimerCompleted(tag)
	if tag == "invinc" then
		canFreeze = true
	end
end