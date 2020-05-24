
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