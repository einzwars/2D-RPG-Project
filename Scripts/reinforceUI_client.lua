Client.GetTopic("무목").Add(function(table)
    if grid == nil then
        grid = GridPanel()
        grid.rect = Rect(0, 0, 1, 1)
        grid.cellSize = Point(Client.width*0.067, Client.height*0.1)
        Client.GetPage("강화").GetControl("목록").AddChild(grid)
    end

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
                c4.text = Client.GetItem(12).name .. "\n강화 재료1: "..v[4].."/10"
                c8.text = "공격력+10"
            else
                Server.SendCenterLabel("아직 강화가 불가능합니다!")
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
end)

Client.GetTopic("무기목록재발신요청").Add(function()
    if Client.GetPage("강화").GetControl("아이템목록").visible == true then
        Client.FireEvent("무기목록")
    end
end)