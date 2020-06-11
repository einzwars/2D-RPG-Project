Server.GetTopic("무기목록").Add(function()

    local myItems = unit.player.GetItems()
    local myItemsT = {}             -- 빈 테이블
    local ingredient1 = unit.CountItem(11)

    for i, v in pairs(myItems) do
        if Server.GetItem(myItems[i].dataID).type == 2 then
            myItemsT["_"..i] = {myItems[i].id, myItems[i].dataID, myItems[i].count, ingredient1}
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

    if dataID == "2" and unit.CountItem(11)>=10 then -- 머신건
        unit.RemoveItem(2, 1, false)
        unit.RemoveItem(11, 10, false)
        unit.SendCenterLabel("강화에 성공했습니다!")
        unit.AddItem(12, 1)
        -- unit.player.SendItemUpdated(unit.player.GetItem(id))
        unit.FireEvent("강화성공")
    else
        unit.SendCenterLabel("강화 재료가 부족합니다")
    end

end)

-- Server.onAddItem.Add(function(unit)
--     unit.FireEvent("무기목록재발신요청")
-- end)
