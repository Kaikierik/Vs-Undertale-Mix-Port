local tranceMax = 2 --if you wanna change for balancing
local tranceMin = -0.25
local swingTime = 4 -- 4 = normal, 2 = hell mode, can be higher if you want, dont make lower than 2 or an odd number will prob fuck it up
local showImage = true
local playTranceSound = true

function activate()
	active = true 
	reset();
	trance = 0
	playSound('spiderskittering', 0, 'trance')
end

function deactivate()
	active = false 
	reset()
	trance = 0
end

local canHit = false 
local wasHit = false
local drain = true
local trance = 0
local tranceDrain = false
local tranceCanKill = true
local active = false
local skippedFirstPendulum = false

local shadCount = 1
local removedShadCount = 0

function onCreatePost()
	-- end of "create"
	makeLuaSprite('swingy', 'swingy', 0, 0);
	--scaleObject('swingy', 1.3, 1.3);
	setObjectCamera('swingy', 'camHUD');
	setProperty('swingy.origin.x', 65)
	setProperty('swingy.origin.y', -350)
	setProperty('swingy.x', (screenWidth / 2) - (getProperty('swingy.width') / 2))
	setProperty('swingy.y', -200)
	updateHitbox('swingy');
	setProperty('swingy.alpha', 0.7)
	
	
	
	setScrollFactor('swingy', 0, 0);
	setProperty('swingy.antialiasing', true)
	addLuaSprite('swingy', true);

	makeAnimatedLuaSprite('tranceThing', 'webb', 0, 0);
	setGraphicSize('tranceThing', screenWidth, screenHeight)
	updateHitbox('tranceThing');
	--scaleObject('swingy', 1.3, 1.3);
	setObjectCamera('tranceThing', 'camHUD');
	setProperty('tranceThing.alpha', 0)
	addLuaSprite('tranceThing', true);
	objectPlayAnimation('tranceThing','webb swing',true);
    addAnimationByPrefix('tranceThing','dance','webb swing',24,true);
	setBlendMode('tranceThing', 'add')

	playSound('spiderskittering', 0, 'trance')

	
end

function onDestroy()
	-- triggered when the lua file is ended (Song fade out finished)
end

function onSoundFinished(tag)
	if active == true then 
		if tag == 'trance' and playTranceSound == true then 
			playSound('spiderskittering', 0, 'trance') --no looping available so uhh fuck you
		end
	end
end

function onResume()
	if playTranceSound == true and active == true then 
		playSound('spiderskittering', 0, 'trance') --no looping available so uhh fuck you
	end
end
function onPause()
	stopSound('trance')
end

function onUpdatePost(elapsed)

	noteCount = getProperty('notes.length');

	if active then 

		drain = true		
		setProperty('swingy.visible', true)
		
		for i = 0, noteCount-1 do
			if getPropertyFromGroup('notes', i, 'mustPress') and getPropertyFromGroup('notes', i, 'canBeHit') then
				drain = false
			end
		end


		if drain then
			trance = trance - (0.0015 / 1)
		else 
			trance = trance - (0.0015 / 4)
		end

		setProperty('tranceThing.alpha', trance / 2)
		if not showImage then 
			setProperty('tranceThing.alpha', 0)
		end

		if playTranceSound then 
			if trance > 1 then 
				setSoundVolume('trance', trance -1)
			else
				setSoundVolume('trance', 0)
			end
		end


		if trance > tranceMax then 
			trance = tranceMax
			setProperty('health', -10)
		end

		if trance < tranceMin then
			trance = tranceMin
		end

		if getPropertyFromClass('flixel.FlxG', 'keys.justPressed.SPACE') then 
			--debugPrint(trance)
			if canHit then 
				canHit = false
				wasHit = true
				win()
			else 
				lose()
			end
		end

	else 
		setProperty('swingy.visible', false)
		setSoundVolume('trance', 0)
	end
end

function win()

	trance = trance - 0.02;

	shadName = 'shad'..shadCount
	makeLuaSprite(shadName, 'swingy', xpos, ypos);
	updateHitbox(shadName);
	--scaleObject('swingy', 1.3, 1.3);
	setObjectCamera(shadName, 'camHUD');
	setProperty(shadName..'.origin.x', 65)
	setProperty(shadName..'.origin.y', 0)
	setProperty(shadName..'.x', (screenWidth / 2) - (getProperty('swingy.width') / 2))
	setProperty(shadName..'.y', -200)
	setProperty(shadName..'.angle', getProperty('swingy.angle'))
	setProperty(shadName..'.alpha', 0.2)
	setProperty(shadName..'.antialiasing', true)
	addLuaSprite(shadName, false);
	runTimer('shad'..shadCount, stepCrochet / 1000, 1)
	shadCount = shadCount + 1

end

function lose()

	if drain then 
		trance = trance + (0.2 / 1)
	else 
		trance = trance + (0.2 / 4)
	end
	

end

function reset()

	cancelTween('pend0')
	cancelTween('pend1')
	cancelTween('pend2')
	cancelTween('pend3')
	setProperty('swingy.angle', 0)
	doTweenAngle('pend1', 'swingy', getProperty('swingy.angle') + 30, (stepCrochet / 1000) * swingTime, 'quadOut')
end

function onStepHit()
	-- triggered 16 times per section

	if active then 
		sectionStep = curStep % (swingTime * 4)
		if sectionStep == math.floor(7 * (swingTime / 4)) or sectionStep == math.floor(15 * (swingTime / 4)) then 
			canHit = true
		elseif sectionStep == math.floor(10 * (swingTime / 4)) or sectionStep == math.floor(2 * (swingTime / 4)) then 
			canHit = false
			if not wasHit then 
				if skippedFirstPendulum then
					lose();
				else
					skippedFirstPendulum = true
				end
			else 
				wasHit = false
			end
		end
	end
end

function onBeatHit()
	-- triggered 4 times per section
	if curBeat % swingTime == 0 then 
		reset();
	end
end


function onTimerCompleted(tag, loops, loopsLeft)

	if string.find(tag, 'shad') then 
		doTweenAlpha(tag, tag, 0, stepCrochet / 1000, 'linear')
	end

end

-- Tween/Timer hooks
function onTweenCompleted(tag)
	-- A tween you called has been completed, value "tag" is it's tag

	if tag == 'pend0' then 
		doTweenAngle('pend1', 'swingy', getProperty('swingy.angle') + 30, (stepCrochet / 1000) * swingTime, 'quadOut')
	elseif tag == 'pend1' then 
		doTweenAngle('pend2', 'swingy', getProperty('swingy.angle') - 30, (stepCrochet / 1000) * swingTime, 'quadIn')
	elseif tag == 'pend2' then 
		doTweenAngle('pend3', 'swingy', getProperty('swingy.angle') - 30, (stepCrochet / 1000) * swingTime, 'quadOut')
	elseif tag == 'pend3' then 
		doTweenAngle('pend0', 'swingy', getProperty('swingy.angle') + 30, (stepCrochet / 1000) * swingTime, 'quadIn')
	end

	if string.find(tag, 'shad') then 
		removeLuaSprite(tag, false);
	end
end

function onSongStart()
	-- Inst and Vocals start playing, songPosition = 0
	doTweenAngle('pend1', 'swingy', getProperty('swingy.angle') + 30, (stepCrochet / 1000) * 4, 'quadOut')
	
end


function onEvent(name, value1, value2)

	if name == 'Enable Pendulumn' then
		--debugPrint('hi') 
		active = true 
		reset();
		trance = 0
		playSound('spiderskittering', 0, 'spiderskittering')
	elseif name == 'Disable Pendulumn' then 
		active = false 
		reset()
		trance = 0
	elseif name == 'Set Swing Time' then 
		swingTime = value1
	elseif name == 'Set Min Trance Time' then 
		tranceMin = value1
	elseif name == 'Set Max Trance Time' then 
		tranceMax = value1
	end

end



