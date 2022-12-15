function onEvent(tag,v1,v2)
if tag=='Hud_AlphaChange'then
    
    AlphaTween(tonumber(v1),tonumber(v2))
end
end
function AlphaTween(alpha,time)

    doTweenAlpha('timeTxtAlpha', 'timeTxt',alpha,time, 'Linear')
    doTweenAlpha('timeBarAlpha', 'timeBar',alpha,time, 'Linear')
    doTweenAlpha('scoreTxtAlpha', 'scoreTxt',alpha,time, 'Linear')
    doTweenAlpha('healthBarAlpha', 'healthBar',alpha,time, 'Linear')
    doTweenAlpha('iconP1Alpha', 'iconP1',alpha,time, 'Linear')
    doTweenAlpha('iconP2Alpha', 'iconP2',alpha,time, 'Linear')

    --doTweenAlpha('piss2', 'piss2',alpha,time, 'Linear')
    doTweenAlpha('piss', 'piss',alpha,time, 'Linear')
    doTweenAlpha('bun', 'bun',alpha,time, 'Linear')
    doTweenAlpha('bun2', 'bun2',alpha,time, 'Linear')
    doTweenAlpha('fill', 'fill',alpha,time, 'Linear')
    doTweenAlpha('border', 'border',alpha,time, 'Linear')
    doTweenAlpha('foodCount', 'foodCount',alpha,time, 'Linear')

    for i=0,8 do
        noteTweenAlpha(i..'note', i,alpha,time, 'Linear')
    end
    
end