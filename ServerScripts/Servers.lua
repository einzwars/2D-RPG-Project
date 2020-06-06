
--서버에서 클라이언트 크기 가져오기
--스크립트로 ClientWidth()를 실행시킨후 월드변수와 해당변수와 연결 해주면 됩니다.
function ClientWidth()
    Server.FireEvent("GetW")
end

function ClientHeight()
    Server.FireEvent("GetH")
end

Server.GetTopic("Width").Add(
        function(value)
            Server.SetWorldVar(0,value*0.5)
        end)

Server.GetTopic("Height").Add(
        function(value)
            Server.SetWorldVar(1,value*0.5)
        end)

Server.GetTopic("originalQuickslot").Add(function(quick1, quick2, quick3, quick4, quick5, quick6, quick7, quick8)
    unit.SetQuickSlot(2, 0, quick1)
    unit.SetQuickSlot(2, 1, quick2)
    unit.SetQuickSlot(2, 2, quick3)
    unit.SetQuickSlot(2, 3, quick4)
    unit.SetQuickSlot(2, 4, quick5)
    unit.SetQuickSlot(2, 5, quick6)
    unit.SetQuickSlot(2, 6, quick7)
    unit.SetQuickSlot(2, 7, quick8)
end)

Server.GetTopic("무기목록").Add(function()
    local myItems = unit.player.GetItems()
    local myItemsT = {}             -- 빈 테이블

    for i, v in pairs(myItems) do
        if Server.GetItem(myItems[i].dataID).type == 2 then
            myItemsT["_"..i] = {myItems[i].id, myItems[i].dataID, myItems[i].count, myItems[i].level}
        end
    end

    unit.FireEvent("무목", Utility.JSONSerialize(myItemsT))

end)

Server.GetTopic("강화요청").Add(function(itemID)
    if itemID == "" or itemID == nil then
        unit.SendCenterLabel("강화할 장비를 선택해주세요")
        return
    end

    local id = tonumber(itemID)

    if unit.player.GetItem(id) == nil then
        unit.SendCenterLabel("강화 대상 장비가 없습니다")
        return
    end

    if rand(0, 2) == 0 then
        unit.SendCenterLabel("강화에 성공하였습니다")
        unit.player.GetItem(id).level = unit.player.GetItem(id).level + 1
        unit.player.SendItemUpdated(unit.player.GetItem(id))
        unit.FireEvent("강화성공", unit.player.GetItem(id).level)
    else
        unit.SendCenterLabel("강화에 실패하였습니다")
    end

end)

Server.onAddItem.Add(function(unit)
    unit.FireEvent("무기목록재발신요청")
end)

-- function StatusUpdate(unit)    
--     --local questCounter = unit.GetStat(101)

--     unit.SetStat(101, unit.GetVar(23))

--     unit.SendUpdated()
-- end

-- function StatusInfoUpdated(unit)
--     StatusUpdate(unit)
-- end
-- Server.onRefreshStats.Add(StatusInfoUpdated)