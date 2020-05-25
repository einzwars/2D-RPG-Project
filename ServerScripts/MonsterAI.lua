Server.setMonsterAI(
    4,
    function(enemy, ai, event, data)
        if(event == AI_INIT) then                   -- 적 나타날 때 최초 한 번 실행
            -- Server.SendSay('Hello, Monster AI')  -- 클라이언트에 메시지
        end

        if(event == AI_UPDATE) then             -- 2초마다 1번씩 실행
            ai.SetNearTarget(0, 200)            -- 파라미터 1번값이 0이면 플레이어 탐색, 2번값은 대상과의 거리

            if(ai.GetTargetUnit() ~= nil) then  -- 반환값을 주는 듯? 여하튼 여기선 반환값이 null이 아니면 실행
                ai.UseSkill(4)                  -- 스킬 번호 입력
                enemy.Say('삐빅. 대상을 추적합니다.')
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_ATTACKED) then           -- 적이 공격받았을 때
            if ai.GetAttackedUnit() == nil then -- 공격한 유닛이 없을경우 예외처리
                return
            else
                enemy.Say('삐빅. 대상을 추적합니다.')
                ai.SetTargetUnit(ai.GetAttackedUnit())
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_DEAD) then               -- 적이 죽었을 때
            -- Server.SendSay('Bye')
        end
    end
)