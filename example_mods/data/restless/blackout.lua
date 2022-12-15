function onCreate()
	setProperty('black.alpha', 0);
end

function onBeatHit()
	if curBeat > 75 then
        setProperty('black.alpha', 1);
    end

    if curBeat > 79 then
        setProperty('black.alpha', 0);
    end

end