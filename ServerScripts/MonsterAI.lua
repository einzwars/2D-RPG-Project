Server.setMonsterAI(
    1,
    function(enemy, ai, event, data)
        if(event == AI_INIT) then                   -- 적 나타날 때 최초 한 번 실행
            -- Server.SendSay('Hello, Monster AI')  -- 클라이언트에 메시지
        end

        if(event == AI_UPDATE) then             -- 2초마다 1번씩 실행
            ai.SetNearTarget(0, 200)            -- 파라미터 1번값이 0이면 플레이어 탐색, 2번값은 대상과의 거리

            if(ai.GetTargetUnit() ~= nil) then  -- 반환값을 주는 듯? 여하튼 여기선 반환값이 null이 아니면 실행
                ai.UseSkill(0)                  -- 스킬 번호 입력
                -- enemy.Say('삐빅. 대상을 추적합니다.')
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_ATTACKED) then           -- 적이 공격받았을 때
            if ai.GetAttackedUnit() == nil then -- 공격한 유닛이 없을경우 예외처리
                return
            else
                -- enemy.Say('삐빅. 대상을 추적합니다.')
                ai.SetTargetUnit(ai.GetAttackedUnit())  -- 공격한 유닛을 타겟으로 삼음
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_DEAD) then               -- 적이 죽었을 때
            
        end
    end
)

Server.setMonsterAI(
    5,
    function (enemy, ai, event, data)
        if(event == AI_DEAD) then
            enemy.ShowAnimation(19)
        end
    end
)

Server.setMonsterAI(
    2,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
            Server.SendCenterLabel('침입자 발견. 침입자 발견. \n지금부터 섬멸작전을 시행합니다.')
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 2000)

            if(ai.GetTargetUnit() ~= nil)  and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)<=130) then
                ai.UseSkill(5)                
            else
                ai.UseSkill(3)
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
            end
            
            if(enemy.hp<=enemy.maxHP*0.4) and math.random(0, 99)<=49 then
                ai.UseSkill(4)
            end
        end

    end
)

Server.setMonsterAI(
    3,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 200)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(0)
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
                ai.SetFollowTarget(true)
            end
        end

    end
)

Server.setMonsterAI(
    4,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 200)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(0)
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
                ai.SetFollowTarget(true)
            end
        end

    end
)

Server.setMonsterAI(
    6,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 200)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(0)
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
                ai.SetFollowTarget(true)
            end
        end

    end
)

Server.setMonsterAI(
    10,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 200)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(0)
            else
                enemy.Say("적 탐색 중...")
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
            end
        end

    end
)

Server.setMonsterAI(
    11,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 200)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(0)
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
                ai.SetFollowTarget(true)
            end
        end

    end
)

Server.setMonsterAI(
    8,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil)  and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)>=200) then
                ai.UseSkill(10)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) then
                enemy.moveSpeed = 250
                ai.SetFollowTarget(true)
            else
                enemy.moveSpeed = 80
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
                enemy.moveSpeed = 250
                ai.SetFollowTarget(true)
            end
        end

    end
)