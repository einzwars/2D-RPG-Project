Client.GetTopic("무목").Add(function(table)
    
    --if grid == nil then
        grid = GridPanel()
        grid.rect = Rect(0, 0, 1, 1)
        grid.cellSize = Point(Client.width*0.067, Client.height*0.1)
        Client.GetPage("강화").GetControl("목록").AddChild(grid)
    --end

    local myItems = Utility.JSONParse(table)
    local myItemsCount = 0

    if #grid.children > 0 then
        for i, v in pairs(grid.children) do
            v.Destroy()
        end
    end

    c1 = Client.GetPage("강화").GetControl("아이템이미지")
    c2 = Client.GetPage("강화").GetControl("아이템목록")
    c3 = Client.GetPage("강화").GetControl("강화창배경")
    c4 = Client.GetPage("강화").GetControl("강화재료")
    c5 = Client.GetPage("강화").GetControl("아이템ID")
    c6 = Client.GetPage("강화").GetControl("Content")
    c7 = Client.GetPage("강화").GetControl("목록")
    c8 = Client.GetPage("강화").GetControl("강화수치")
    c9 = Client.GetPage("강화").GetControl("데이터ID")

    for i, v in pairs(myItems) do
        local itemBtn = Button(v[1], Rect(0, 0, 1, 1))
        itemBtn.textColor = Color(0, 0, 0, 0)
        itemBtn.color = Color(0, 0, 0, 0)
        itemBtn.onClick.Add(function()
            c2.visible = false
            c3.visible = true
            if v[2] == 2 then   -- 머신건
                c1.SetImageID(Client.GetItem(12).imageID)
                c4.text = Client.GetItem(12).name .. "\n강화 재료1: "..v[4].."/10\n골드: "..v[9].."/1000"
                c8.text = "공격력+50"
            elseif v[2] == 3 then   -- 방탄조끼
                c1.SetImageID(Client.GetItem(13).imageID)
                c4.text = Client.GetItem(13).name .. "\n강화 재료1: "..v[4].."/10\n골드: "..v[9].."/1000"
                c8.text = "방어력+10/체력+200"
            elseif v[2] == 9 then   -- 부츠
                c1.SetImageID(Client.GetItem(14).imageID)
                c4.text = Client.GetItem(14).name .. "\n강화 재료1: "..v[4].."/10\n골드: "..v[9].."/1000"
                c8.text = "방어력+10/민첩+2"
            elseif v[2] == 19 then   -- 개틀링건
                c1.SetImageID(Client.GetItem(20).imageID)
                c4.text = Client.GetItem(20).name .. "\n강화 재료1: "..v[4].."/10\n골드: "..v[9].."/1000"
                c8.text = "공격력+40"
            elseif v[2] == 12 then   -- 개조 머신건
                c1.SetImageID(Client.GetItem(26).imageID)
                c4.text = Client.GetItem(26).name .. "\n강화 재료2: "..v[5].."/10\n특별 강화 재료: "..v[7].."/1\n골드: "..v[9].."/3000"
                c8.text = "공격력+150"
            elseif v[2] == 13 then   -- 개조 조끼
                c1.SetImageID(Client.GetItem(28).imageID)
                c4.text = Client.GetItem(28).name .. "\n강화 재료2: "..v[5].."/10\n특별 강화 재료: "..v[7].."/1\n골드: "..v[9].."/3000"
                c8.text = "방어력+20/체력+400"
            elseif v[2] == 14 then   -- 개조 부츠
                c1.SetImageID(Client.GetItem(29).imageID)
                c4.text = Client.GetItem(29).name .. "\n강화 재료2: "..v[5].."/10\n특별 강화 재료: "..v[7].."/1\n골드: "..v[9].."/3000"
                c8.text = "방어력+20/민첩+5"
            elseif v[2] == 20 then   -- 개조 개틀링건
                c1.SetImageID(Client.GetItem(27).imageID)
                c4.text = Client.GetItem(27).name .. "\n강화 재료2: "..v[5].."/10\n특별 강화 재료: "..v[7].."/1\n골드: "..v[9].."/3000"
                c8.text = "공격력+140"
            elseif v[2] == 26 then   -- 특별 머신건
                c1.SetImageID(Client.GetItem(37).imageID)
                c4.text = Client.GetItem(37).name .. "\n강화 재료3: "..v[6].."/10\n전설 강화 재료: "..v[8].."/1\n골드: "..v[9].."/10000"
                c8.text = "공격력+300"
            elseif v[2] == 28 then   -- 특별 조끼
                c1.SetImageID(Client.GetItem(39).imageID)
                c4.text = Client.GetItem(39).name .. "\n강화 재료3: "..v[6].."/10\n전설 강화 재료: "..v[8].."/1\n골드: "..v[9].."/10000"
                c8.text = "방어력+30/체력+500"
            elseif v[2] == 29 then   -- 특별 부츠
                c1.SetImageID(Client.GetItem(40).imageID)
                c4.text = Client.GetItem(40).name .. "\n강화 재료3: "..v[6].."/10\n전설 강화 재료: "..v[8].."/1\n골드: "..v[9].."/10000"
                c8.text = "방어력+30/민첩+10"
            elseif v[2] == 27 then   -- 특별 개틀링건
                c1.SetImageID(Client.GetItem(38).imageID)
                c4.text = Client.GetItem(38).name .. "\n강화 재료3: "..v[6].."/10\n전설 강화 재료: "..v[8].."/1\n골드: "..v[9].."/10000"
                c8.text = "공격력+270"
            else
                Client.GetPage("강화").GetControl("아이템이미지").image = "Pictures/invisible.png"
                c4.text = ""
                c8.text = ""
            end
            c5.text = v[1]
            c9.text = v[2]
        end)

        grid.AddChild(itemBtn)

        local itemImg = Image("", Rect(itemBtn.x, itemBtn.y, 50, 50))
        itemImg.showOnTop = true
        itemImg.SetImageID(Client.GetItem(v[2]).imageID)

        itemBtn.AddChild(itemImg)

        myItemsCount = myItemsCount + 1
    end

    grid.rect = Rect(0, 0, c6.width, grid.cellSize.y*math.ceil(myItemsCount/7))
    c6.height = grid.height
    c7.height = grid.height
end)

Client.GetTopic("강화성공").Add(function(level)
    Client.GetPage("강화").GetControl("아이템ID").text = ""
    Client.GetPage("강화").GetControl("아이템이미지").image = "Pictures/invisible.png"
    Client.GetPage("강화").GetControl("강화재료").text = ""
    Client.GetPage("강화").GetControl("강화수치").text = ""
    Client.GetPage("강화").Destroy()
end)

Client.GetTopic("무기목록재발신요청").Add(function()
    if Client.GetPage("강화").GetControl("아이템목록").enabled == true then
        Client.FireEvent("무기목록")
    end
end)