Server.setMonsterAI(
    1,
    function(enemy, ai, event, data)
        if(event == AI_INIT) then               -- 적 나타날 때 최초 한 번 실행
        end

        if(event == AI_UPDATE) then             -- 2초마다 1번씩 실행
            ai.SetNearTarget(0, 300)            -- 파라미터 1번값이 0이면 플레이어 탐색, 2번값은 대상과의 거리

            if(ai.GetTargetUnit() ~= nil) then  -- 반환값을 주는 듯? 여하튼 여기선 반환값이 null이 아니면 실행
                ai.UseSkill(26)                  -- 스킬 번호 입력                
            end
        end

        if(event == AI_ATTACKED) then           -- 적이 공격받았을 때
            if ai.GetAttackedUnit() == nil then -- 공격한 유닛이 없을경우 예외처리
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())  -- 공격한 유닛을 타겟으로 삼음
            end
        end

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
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
            enemy.field.SendCenterLabel("<Color=Red>침입자 발견. 침입자 발견. \n지금부터 섬멸작전을 시행합니다.</color>")
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
            
            if(enemy.hp<=enemy.maxHP*0.4) and math.random(0, 99)<=59 then
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
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(26)
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
            end
        end

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end

    end
)

Server.setMonsterAI(
    4,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(26)
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
            end
        end

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    6,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    10,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(27)
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    11,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(26)
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
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
                enemy.moveSpeed = 200
                ai.SetFollowTarget(true)
            else
                enemy.moveSpeed = 60
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
                enemy.moveSpeed = 200
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    12,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil)  and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)>=200) then
                ai.UseSkill(10)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) then
                enemy.moveSpeed = 220
                ai.SetFollowTarget(true)
            else
                enemy.moveSpeed = 60
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
                enemy.moveSpeed = 220
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    13,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(15)
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    15,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)<=120) then
                ai.UseSkill(14)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) then
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    14,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
            ai.customData.delay = 0
        end

        if(event == AI_UPDATE) then

            if enemy.field.playerCount <=0 then
                ai.SetTargetUnit(nil)
                ai.customData.delay = 0
                return
            else
                ai.SetNearTarget(0, 3000)
            end

            if(ai.GetTargetUnit() ~= nil) and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)<=120) then
                ai.customData.delay = ai.customData.delay + 1
                ai.UseSkill(5)            
            elseif(ai.GetTargetUnit() ~= nil) and ai.customData.delay ~= 0 and ai.customData.delay%4 == 0 then
                ai.customData.delay = ai.customData.delay + 1
                enemy.field.SendCenterLabel("<Color=Red>포착 중...</color> ")
                ai.UseSkillToPosition(16, Point(ai.GetTargetUnit().x, ai.GetTargetUnit().y))
            elseif(ai.GetTargetUnit() ~= nil) and ai.customData.delay ~= 0 and ai.customData.delay%5 == 0 then
                ai.customData.delay = ai.customData.delay + 1
                enemy.field.SendCenterLabel("<Color=Red>포착 완료</color> ")
                ai.UseSkillToPosition(6, Point(ai.GetTargetUnit().x, ai.GetTargetUnit().y))
            elseif(ai.GetTargetUnit() ~= nil) then
                ai.customData.delay = ai.customData.delay + 1
                ai.UseSkill(0)
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
            end
        end

        if event == 2 then
            ai.customData.delay = 0
            enemy.SendUpdated()
        end

    end
)

Server.setMonsterAI(
    7,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(27)
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    17,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(28)
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    16,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil)  and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)>=200) then
                ai.UseSkill(10)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) then
                enemy.moveSpeed = 220
                ai.SetFollowTarget(true)
            else
                enemy.moveSpeed = 60
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
                enemy.moveSpeed = 220
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    9,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(27)
            end
        end

        if(event == AI_ATTACKED) then
            if ai.GetAttackedUnit() == nil then
                return
            else
                ai.SetTargetUnit(ai.GetAttackedUnit())
            end
        end

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    18,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(15)
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    19,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)<=120) then
                ai.UseSkill(14)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) then
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    20,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)<=120) then
                ai.UseSkill(14)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) then
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    21,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(15)
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    22,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)>=200) then
                ai.UseSkill(10)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) then
                enemy.moveSpeed = 270
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
                enemy.moveSpeed = 270
                ai.SetFollowTarget(true)
            end
        end

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    23,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
            ai.customData.militaryDelay = 0
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 1000)

            if(ai.GetTargetUnit() ~= nil) and (enemy.hp<=enemy.maxHP*0.3) and (ai.customData.militaryDelay%5 == 0) then
                enemy.field.SendCenterLabel("<Color=Red>위험! 위험!</color>")
                ai.UseSkill(4)
            end

            if(ai.GetTargetUnit() ~= nil) and (ai.customData.militaryDelay~=0) and (ai.customData.militaryDelay%3 == 0) then
                ai.customData.militaryDelay = ai.customData.militaryDelay+1
                ai.UseSkill(3)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) then
                ai.customData.militaryDelay = ai.customData.militaryDelay+1
                ai.UseSkill(8)
                enemy.MakeSturn(2)
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

        if event == 2 then
            ai.customData.militaryDelay = 0
            enemy.SendUpdated()
        end

    end
)

Server.setMonsterAI(
    24,
    function (enemy, ai, event, data)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 300)

            if(ai.GetTargetUnit() ~= nil) then
                ai.UseSkill(15)
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

        if(event == AI_DEAD) then
            enemy.ShowAnimation(43)
        end
    end
)

Server.setMonsterAI(
    25,
    function (enemy, ai, event, data)
        local randnum = math.random(0, 99)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 1500)

            if(ai.GetTargetUnit() ~= nil) and (ai.Distance(enemy.x, enemy.y, ai.GetTargetUnit().x, ai.GetTargetUnit().y)>=120) then
                ai.UseSkill(10)
                enemy.PullFromUnit(ai.GetTargetUnit(), 100, 0.3)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) and randnum <= 49 then
                enemy.field.SendCenterLabel("<Color=Red>물러나십시오!</color>")
                ai.UseSkill(18)
                ai.SetFollowTarget(true)
            else
                enemy.field.SendCenterLabel("<Color=Red>뚝배기!</color>")
                ai.UseSkill(19)
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
    26,
    function (enemy, ai, event, data)
        local randomx = math.random(32*4, 32*28)
        local randomy = -(math.random(32*3, 32*19))

        if(event == AI_INIT) then
            ai.customData.droneDelay = 0
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 33*24)

            if(ai.GetTargetUnit() ~= nil) and (ai.customData.droneDelay~=0) and (ai.customData.droneDelay%5 == 0) then
                ai.customData.droneDelay = ai.customData.droneDelay+1
                enemy.field.SendCenterLabel("<Color=Red>K 넌 로봇이야! 내말을 들어야 해!</color>")
                ai.UseSkill(22)
                enemy.MakeSturn(2)
            elseif(ai.GetTargetUnit() ~= nil) and (ai.customData.droneDelay~=0) and (ai.customData.droneDelay%3 == 0) then
                ai.customData.droneDelay = ai.customData.droneDelay+1
                ai.UseSkill(21)
                enemy.SpawnAt(randomx-16, randomy-16)           
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) then
                ai.customData.droneDelay = ai.customData.droneDelay+1
                enemy.field.SendCenterLabel("<Color=Red>죽어라!</color>")
                ai.UseSkill(20)
                enemy.MakeSturn(2)
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

        if event == 2 then
            ai.customData.droneDelay = 0
            enemy.SendUpdated()
        end

    end
)

Server.setMonsterAI(
    27,
    function (enemy, ai, event, data)
        local randnum = math.random(0, 99)

        if(event == AI_INIT) then
        end

        if(event == AI_UPDATE) then
            ai.SetNearTarget(0, 2000)

            if(ai.GetTargetUnit() ~= nil) and (enemy.hp<=enemy.maxHP*0.5) and randnum <=33 then
                if(randnum == 0) then
                    enemy.field.SendCenterLabel("<Color=Red>죽어라 이 대머리!</color>")
                end
                ai.UseSkill(24)
                ai.SetFollowTarget(true)
            elseif(ai.GetTargetUnit() ~= nil) and randnum <= 49 then
                enemy.field.SendCenterLabel("<Color=Red>무다무다무다무다무다무다!!!</color>")
                ai.UseSkill(23)
                enemy.MakeSturn(2)
                ai.SetFollowTarget(true)
            else
                ai.UseSkill(25)
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