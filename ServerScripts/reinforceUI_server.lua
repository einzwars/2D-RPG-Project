Server.GetTopic("무기목록").Add(function()

    local myItems = unit.player.GetItems()
    local myItemsT = {}             -- 빈 테이블
    local ingredient1 = unit.CountItem(11)  -- 강화재료1
    local ingredient2 = unit.CountItem(23)  -- 강화재료2
    local ingredient3 = unit.CountItem(34)  -- 강화재료3
    local ingredient4 = unit.CountItem(25)  -- 특별 강화재료
    local ingredient5 = unit.CountItem(36)  -- 전설 강화재료
    local money = unit.gameMoney            -- 플레이어 골드

    for i, v in pairs(myItems) do
        if Server.GetItem(myItems[i].dataID).type == 2 or Server.GetItem(myItems[i].dataID).type == 1 or Server.GetItem(myItems[i].dataID).type == 4 then
            myItemsT["_"..i] = {myItems[i].id, myItems[i].dataID, myItems[i].count, ingredient1, ingredient2, ingredient3, ingredient4, ingredient5, money}     -- 9
        end
    end

    unit.FireEvent("무목", Utility.JSONSerialize(myItemsT))

end)

Server.GetTopic("강화요청").Add(function(itemID, dataID)
    if itemID == "" or itemID == nil then
        unit.SendCenterLabel("강화할 장비를 선택해주세요")
        return
    end

    local id = tonumber(itemID)
    if unit.player.GetItem(id) == nil then
        unit.SendCenterLabel("강화 대상 장비가 없습니다")
        return
    end

    if dataID == "2" and unit.CountItem(11)>=10 and unit.gameMoney>=1000 then -- 머신건
        unit.RemoveItem(2, 1, false)
        unit.RemoveItem(11, 10, false)
        unit.UseGameMoney(1000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(12, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "3" and unit.CountItem(11)>=10 and unit.gameMoney>=1000 then -- 방탄조끼
        unit.RemoveItem(3, 1, false)
        unit.RemoveItem(11, 10, false)
        unit.UseGameMoney(1000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(13, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "9" and unit.CountItem(11)>=10 and unit.gameMoney>=1000 then -- 부츠
        unit.RemoveItem(9, 1, false)
        unit.RemoveItem(11, 10, false)
        unit.UseGameMoney(1000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(14, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "19" and unit.CountItem(11)>=10 and unit.gameMoney>=1000 then -- 개틀링건
        unit.RemoveItem(19, 1, false)
        unit.RemoveItem(11, 10, false)
        unit.UseGameMoney(1000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(20, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "12" and unit.CountItem(23)>=10 and unit.CountItem(25)>=1 and unit.gameMoney>=3000 then -- 개조 머신건
        unit.RemoveItem(12, 1, false)
        unit.RemoveItem(23, 10, false)
        unit.RemoveItem(25, 1, false)
        unit.UseGameMoney(3000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(26, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "13" and unit.CountItem(23)>=10 and unit.CountItem(25)>=1 and unit.gameMoney>=3000 then -- 개조 조끼
        unit.RemoveItem(13, 1, false)
        unit.RemoveItem(23, 10, false)
        unit.RemoveItem(25, 1, false)
        unit.UseGameMoney(3000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(28, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "14" and unit.CountItem(23)>=10  and unit.CountItem(25)>=1 and unit.gameMoney>=3000 then -- 개조 부츠
        unit.RemoveItem(14, 1, false)
        unit.RemoveItem(23, 10, false)
        unit.RemoveItem(25, 1, false)
        unit.UseGameMoney(3000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(29, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "20" and unit.CountItem(23)>=10 and unit.CountItem(25)>=1 and unit.gameMoney>=3000 then -- 개조 개틀링건
        unit.RemoveItem(20, 1, false)
        unit.RemoveItem(23, 10, false)
        unit.RemoveItem(25, 1, false)
        unit.UseGameMoney(3000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(27, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "26" and unit.CountItem(34)>=10 and unit.CountItem(36)>=1 and unit.gameMoney>=10000 then -- 특별 머신건
        unit.RemoveItem(26, 1, false)
        unit.RemoveItem(34, 10, false)
        unit.RemoveItem(36, 1, false)
        unit.UseGameMoney(10000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(37, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "28" and unit.CountItem(34)>=10 and unit.CountItem(36)>=1 and unit.gameMoney>=10000 then -- 특별 조끼
        unit.RemoveItem(28, 1, false)
        unit.RemoveItem(34, 10, false)
        unit.RemoveItem(36, 1, false)
        unit.UseGameMoney(10000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(39, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "29" and unit.CountItem(34)>=10 and unit.CountItem(36)>=1 and unit.gameMoney>=10000 then -- 특별 부츠
        unit.RemoveItem(29, 1, false)
        unit.RemoveItem(34, 10, false)
        unit.RemoveItem(36, 1, false)
        unit.UseGameMoney(10000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(40, 1)
        unit.FireEvent("강화성공")
    elseif dataID == "27" and unit.CountItem(34)>=10 and unit.CountItem(36)>=1 and unit.gameMoney>=10000 then -- 특별 개틀링건
        unit.RemoveItem(27, 1, false)
        unit.RemoveItem(34, 10, false)
        unit.RemoveItem(36, 1, false)
        unit.UseGameMoney(10000)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(38, 1)
        unit.FireEvent("강화성공")
    else
        unit.SendCenterLabel("강화 재료 혹은 골드가 부족합니다!")
    end

end)

-- Server.onAddItem.Add(function(unit)
--     unit.FireEvent("무기목록재발신요청")
-- end)
