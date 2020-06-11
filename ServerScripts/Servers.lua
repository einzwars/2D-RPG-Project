
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

-- function StatusUpdate(unit)    
--     --local questCounter = unit.GetStat(101)

--     unit.SetStat(101, unit.GetVar(23))

--     unit.SendUpdated()
-- end

-- function StatusInfoUpdated(unit)
--     StatusUpdate(unit)
-- end
-- Server.onRefreshStats.Add(StatusInfoUpdated)