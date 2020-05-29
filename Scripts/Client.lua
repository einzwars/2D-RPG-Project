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

-- function OverloadSystem()
--     for i, quickslot in ipairs(Client.myPlayerUnit.quickSlots) do
--             quickslot.skillDataID
--         end        
-- end