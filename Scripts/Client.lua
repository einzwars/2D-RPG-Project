-- Client.RunLater(
--     function() 
--         Client.FireEvent("Width",Client.width)
--         Client.FireEvent("Height",Client.height)
-- end,2)
-- Client.FireEvent("Width",1)
-- Client.FireEvent("Height",2)
Client.GetTopic("GetW").Add(
    function()
        Client.FireEvent("Width",Client.width)
    end
)

Client.GetTopic("GetH").Add(
    function()
        Client.FireEvent("Height",Client.height)
    end
)

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
    c4 = Client.GetPage("강화").GetControl("강화설명")
    c5 = Client.GetPage("강화").GetControl("아이템ID")
    c6 = Client.GetPage("강화").GetControl("Content")
    c7 = Client.GetPage("강화").GetControl("목록")
    c8 = Client.GetPage("강화").GetControl("아이템레벨")

    for i, v in pairs(myItems) do
        local itemBtn = Button(v[1], Rect(0, 0, 1, 1))
        itemBtn.textColor = Color(0, 0, 0, 0)
        itemBtn.color = Color(0, 0, 0, 0)
        itemBtn.onClick.Add(function()
            c1.SetImageID(Client.GetItem(v[2]).imageID)
            c2.visible = false
            c3.visible = true
            c4.text = Client.GetItem(v[2]).name .. "를(을) 강화합니다"
            c5.text = v[1]
            c8.text = "+"..v[4]
        end)

        grid.AddChild(itemBtn)

        local itemImg = Image("", Rect(itemBtn.x, itemBtn.y, 50, 50))
        itemImg.showOnTop = true
        itemImg.SetImageID(Client.GetItem(v[2]).imageID)

        itemBtn.AddChild(itemImg)

        local levelText = Text()
        if v[4] == 0 then
            levelText.text = ""
        else
            levelText.text = "+".. v[4]
        end

        levelText.color = Color(0, 255, 0)
        levelText.textSize = 12
        levelText.textAlign =2
        levelText.rect = Rect(0, 0, itemImg.width, itemImg.height)
        itemBtn.AddChild(levelText)

        myItemsCount = myItemsCount + 1
    end

    grid.rect = Rect(0, 0, c6.width, grid.cellSize.y*math.ceil(myItemsCount/7))
    c6.height = grid.height
    c7.height = grid.height
end)

Client.GetTopic("강화성공").Add(function(level)
    Client.GetPage("강화").GetControl("아이템레벨").text = "+"..level
end)

Client.GetTopic("무기목록재발신요청").Add(function()
    if Client.GetPage("강화").GetControl("아이템목록").visible == true then
        Client.FireEvent("무기목록")
    end
end)