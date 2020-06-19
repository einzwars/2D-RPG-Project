-------------------------------------------------
-- <아이템 획득시 랜덤옵션 부여스크립트>
-- 제작: 파밍RPG 개발자

-- *사용법*
-- 스크립트 설정을 완료해주세요.

-- *유의사항*
-- 잘못된 사용으로 인한 책임은 게임 개발자에게 있습니다.
-- 옵션이 없는 아이템을 교환/창고에서꺼내기 등을 수행하여도 옵션이 부여됩니다.
-- **단, 설정한 아이템에 한함
-- 한칸에 1개밖에 안들어가는 장비를 한번에 AddItem등으로 2개 이상줄경우 첫번째 아이템에만 부여됩니다. (하나씩주세요)

-- *문의*
-- 안받습니다.

-- *기타사항*
-- 수정은 가능하나, 재판매는 금지합니다.
-------------------------------------------------

-------------------------------------------------
-- 설정하기
-------------------------------------------------
RandomOption = {}

RandomOption.optionList = { --★ 수정필요 ★

    -- 타입정보
    -- 1=직업+, 2=직업%, 3=아이템+, 3=아이템%

    -- 스탯정보
    -- 0=atk, 1=def, 2=magicAtk, 3=magicDef, 4=agi, 5=luck, 6=maxHP, 7=maxMP,
    -- 101~132 = 커스텀 1~32번

    -- 등록된 스탯 중 랜덤종류, 랜덤범위로 추가됩니다.
    -- 아래로 쭉쭉추가하시면 됩니다 (,는 꼭 넣어주세요)

    --{ 타입, 스탯, 최소, 최대, 소수점 }(0=소수점없음, 1=1자리, 2=2자리, -1=10단위절삭, -2=100단위절삭..).

    -- {1, 6, 100, 1000, -2},
    -- {1, 7, 100, 1000, -2},
    
    -- {1, 0, 1, 10, 0},
    -- {1, 1, 1, 10, 0},
    
    -- {1, 4, 0.1, 0.5, 1},
    -- {1, 5, 0.1, 0.5, 1},
    
    {3, 0, 20, 40, 0},   --공격력+20~40
    {3, 4, 10, 10, 0},  --민첩+10
    {3, 5, 5, 5, 0},    --운+5
    {3, 0, 15, 25, 0},    --공격력+15~25
    {3, 1, 5, 10, 0},    --방어력+5~10
    {3, 6, 300, 300, 0},    --체력+300
    {3, 7, 20, 20, 0},    --과부하+20
    {3, 4, 5, 5, 0}       --민첩+5

}

RandomOption.itemList = { --★ 수정필요 ★

    -- optionCount = 랜덤으로 부여되는 옵션의 개수를 의미합니다.
    -- optionAmp = 부여되는 옵션의 배율(%)를 의미합니다 100=100%(기본) 200=200%(2배)
    -- dataID = 해당 등급(젤첨에숫자)에 해당하는 아이템 dataID를 입력해주세요.
    
    -- 중복주의 / 중복된 dataID 가 있을 경우 제일 높은 등급이 적용됩니다.
    -- 아래로 쭉쭉추가하시면 됩니다 (,는 꼭 넣어주세요)

    [1] = { -- 특별
        optionCount=2, optionAmp=100,
        dataID = {
            26, 27, 28, 29
        }
    }, 
    [2] = { -- 전설
        optionCount=3, optionAmp=200,
        dataID = {
            37, 38, 39, 40, 48, 49, 50, 51
        }
    }, 
    [3] = {
        optionCount=1, optionAmp=100,
        dataID = {
            
        }
    }, 
    [4] = {
        optionCount=2, optionAmp=100,
        dataID = {

        }
    }, 
}

-------------------------------------------------
-- 아래는 왠만하면 건들지마세요
-------------------------------------------------

RandomOption.CheckRarity = {}
for i=1, #RandomOption.itemList, 1 do
    local db = RandomOption.itemList[i].dataID

    for j=1, #db, 1 do
        RandomOption.CheckRarity[db[j]] = i
    end
end

function RandomOption:AddOption(u, item)
    if not (u and item) then
        return
    end

    if #item.options >= 1 then
        return
    end
    
    local rarity = self.CheckRarity[item.dataID]
    
    if not rarity then
        return
    end
    
    local db = self.itemList[rarity]

    if not db then
        return
    end

    for i=1, db.optionCount, 1 do
        local to = self.optionList[rand(1, #self.optionList + 1)]
        local o = {
            type = to[1],
            statID = to[2],
            value = math.floor(rand(to[3]*(10^to[5]), to[4]*(10^to[5]) + 1) *(db.optionAmp/100)) / (10^to[5]) 
        }
        Utility.AddItemOption(item, o.type, o.statID, o.value)
    end
    
    u.player.SendItemUpdated(item)
    
end
Server.onAddItem.Add(function(u, item) RandomOption:AddOption(u, item) end)