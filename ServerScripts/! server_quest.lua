
quest_var = 1

local function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

function returnBool(a, unit)
	if a ~= "" then
		if string.match(a, "<") then
			a = split(a, " < ")
			if tonumber(a[1]) < tonumber(a[2]) then
				return true
			else
				return false
			end
		elseif string.match(a, ">") then
			a = split(a, " > ")
			if tonumber(a[1]) > tonumber(a[2]) then
				return true
			else
				return false
			end
		elseif string.match(a, "==") then
			a = split(a, " == ")
			if tonumber(a[1]) == tonumber(a[2]) then
				return true
			else
				return false
			end
		end
	end
end

function add_quest(id, name, explain, type, condition, reward, count, exp, data, repeated, GlobalEvent)
	local qData = unit.GetStringVar(quest_var)
	qData = Utility.JSONParse(qData)
	local bool = 0
	for i=1, #qData.list do
		if qData.list[i].id == id then
			bool = 1
		end
	end
	if qData.status[id] == true then
		bool = 2
	end
	if bool == 0 then
		qData.list[1+#qData.list] = {id = id, name = name, explain = explain, type = type, condition = condition, reward = reward, count = count, exp = exp, data = data, repeated = repeated, GlobalEvent = GlobalEvent, save = 0}
		unit.SetStringVar(quest_var, Utility.JSONSerialize(qData))
		unit.SendCenterLabel("신규 퀘스트 "..string.gsub(name, "slash", "/").." 이(가) 등록되었습니다.")
	elseif bool == 1 then
		unit.SendCenterLabel("진행 중인 퀘스트입니다.")
	elseif bool == 2 then
		unit.SendCenterLabel("이미 완료한 퀘스트입니다.")
	end
end

function sub_quest(id)
	local qData = unit.GetStringVar(quest_var)
	qData = Utility.JSONParse(qData)
	local bool = 0
	for i=1, #qData.list do
		if qData.list[#qData.list-(i-1)].id == id then
			unit.SendCenterLabel(string.gsub(qData.list[#qData.list-(i-1)].name, "slash", "/").." 퀘스트를 포기하였습니다.")
			table.remove(qData.list, #qData.list-(i-1))
			unit.SetStringVar(quest_var, Utility.JSONSerialize(qData))
		end
	end
end

function give_questCheck(id)
	local qData = unit.GetStringVar(quest_var)
	qData = Utility.JSONParse(qData)
	local v = {}
	local bool = 0
	for i=1, #qData.list do
		if qData.list[#qData.list-(i-1)].id == id and qData.list[#qData.list-(i-1)].type == "GIVE" then
			if unit.CountItem(qData.list[#qData.list-(i-1)].data[1]) >= qData.list[#qData.list-(i-1)].data[2] then
				unit.RemoveItem(qData.list[#qData.list-(i-1)].data[1], qData.list[#qData.list-(i-1)].data[2], false)
				for i2=1, #qData.list[i].reward do
					unit.AddItem(qData.list[i].reward[i2], qData.list[i].count[i2], false)
				end
				unit.AddEXP(qData.list[#qData.list-(i-1)].exp)
				unit.SendCenterLabel(string.gsub(qData.list[i].name, "slash", "/").." 퀘스트을(를) 완료하였습니다.")
				if qData.list[i].GlobalEvent ~= false then
					unit.StartGlobalEvent(tonumber(qData.list[i].GlobalEvent))
				end
				table.insert(v, i)
				for i=1, #v do
					if qData.list[#v-(i-1)].repeated == "false" then
						qData.status[qData.list[#v-(i-1)].id] = true
					end
					qData.list[#v-(i-1)].save = 0
					qData.complete[1+#qData.complete] = qData.list[#v-(i-1)]
					table.remove(qData.list, v[#v-(i-1)])
				end
				unit.SetStringVar(quest_var, Utility.JSONSerialize(qData))
				return true
			else
				return false
			end
		end
	end
end

Server.GetTopic("getqData").Add(function(text)

	local t = Utility.JSONParse(unit.GetStringVar(quest_var))

	for i=1, #t.list do
		if string.match(t.list[i].explain, "Var") then
			local start, stop = string.find(t.list[i].explain, "Var")
			t.list[i].explain = string.gsub(t.list[i].explain, string.sub(t.list[i].explain, start, stop+1), unit.GetVar(tonumber(string.sub(t.list[i].explain, stop+1, stop+1))))
		end
	end
	unit.FireEvent("postqData", Utility.JSONSerialize(t))
end)

function onJoinPlayer(s)
	local qData = s.unit.GetStringVar(quest_var)
	if qData == "" or qData == nil then
		qData = {list = {}, status = {}, complete = {}}
		s.unit.SetStringVar(quest_var, Utility.JSONSerialize(qData))
	end
end
Server.onJoinPlayer.Add(onJoinPlayer)

function onUnitDead(target, attacker)
	if target.type == 2 then
		local qData = Utility.JSONParse(attacker.GetStringVar(quest_var))
		local v = {}
		for i=1, #qData.list do
			if qData.list[i].type == "KILL" then
				if target.monsterID == qData.list[i].data[1] then
					qData.list[i].save = qData.list[i].save + 1
				end
				if returnBool(string.gsub(string.gsub(qData.list[i].condition, "value", qData.list[i].save), "data", qData.list[i].save), attacker) == true then
					for i2=1, #qData.list[i].reward do
						attacker.AddItem(qData.list[i].reward[i2], qData.list[i].count[i2], false)
					end
					attacker.AddEXP(qData.list[#qData.list-(i-1)].exp)
					attacker.SendCenterLabel(string.gsub(qData.list[i].name, "slash", "/").." 퀘스트을(를) 완료하였습니다.")
					if qData.list[i].GlobalEvent ~= false then
						attacker.StartGlobalEvent(tonumber(qData.list[i].GlobalEvent))
					end
					table.insert(v, i)
				end
			end
		end
		for i=1, #v do
			if qData.list[#v-(i-1)].repeated == "false" then
				qData.status[qData.list[#v-(i-1)].id] = true
			end
			qData.list[#v-(i-1)].save = 0
			qData.complete[1+#qData.complete] = qData.list[#v-(i-1)]
			table.remove(qData.list, v[#v-(i-1)])
		end
		attacker.SetStringVar(quest_var, Utility.JSONSerialize(qData))
	end
end
Server.onUnitDead.Add(onUnitDead)

Server.onUseItem.Add(function(unit, titem)
	local qData = Utility.JSONParse(unit.GetStringVar(quest_var))
	local v = {}
	for i=1, #qData.list do
		if qData.list[i].type == "USE" then
			if titem.dataID == qData.list[i].data[1] then
				qData.list[i].save = qData.list[i].save + 1
			end
			if returnBool(string.gsub(qData.list[i].condition, "value", qData.list[i].save), unit) == true then
				for i2=1, #qData.list[i].reward do
					unit.AddItem(qData.list[i].reward[i2], qData.list[i].count[i2], false)
				end
				unit.AddEXP(qData.list[#qData.list-(i-1)].exp)
				unit.SendCenterLabel(string.gsub(qData.list[i].name, "slash", "/").." 퀘스트을(를) 완료하였습니다.")
				if qData.list[i].GlobalEvent ~= false then
					unit.StartGlobalEvent(tonumber(qData.list[i].GlobalEvent))
				end
				table.insert(v, i)
			end
		end
	end
	for i=1, #v do
		if qData.list[#v-(i-1)].repeated == "false" then
			qData.status[qData.list[#v-(i-1)].id] = true
		end
		qData.list[#v-(i-1)].save = 0
		qData.complete[1+#qData.complete] = qData.list[#v-(i-1)]
		table.remove(qData.list, v[#v-(i-1)])
	end
	unit.SetStringVar(quest_var, Utility.JSONSerialize(qData))
end)

Server.onSay.Add(function(unit, text)
	local qData = Utility.JSONParse(unit.GetStringVar(quest_var))
	local v = {}
	for i=1, #qData.list do
		if qData.list[i].type == "CHAT" then
			if text == qData.list[i].data[1] then
				qData.list[i].save = qData.list[i].save + 1
			end
			if returnBool(string.gsub(qData.list[i].condition, "value", qData.list[i].save), unit) == true then
				for i2=1, #qData.list[i].reward do
					unit.AddItem(qData.list[i].reward[i2], qData.list[i].count[i2], false)
				end
				unit.AddEXP(qData.list[#qData.list-(i-1)].exp)
				unit.SendCenterLabel(string.gsub(qData.list[i].name, "slash", "/").." 퀘스트을(를) 완료하였습니다.")
				if qData.list[i].GlobalEvent ~= false then
					unit.StartGlobalEvent(tonumber(qData.list[i].GlobalEvent))
				end
				table.insert(v, i)
			end
		end
	end
	for i=1, #v do
		if qData.list[#v-(i-1)].repeated == "false" then
			qData.status[qData.list[#v-(i-1)].id] = true
		end
		qData.list[#v-(i-1)].save = 0
		qData.complete[1+#qData.complete] = qData.list[#v-(i-1)]
		table.remove(qData.list, v[#v-(i-1)])
	end
	unit.SetStringVar(quest_var, Utility.JSONSerialize(qData))
end)

Server.onUnitDead.Add(function(target, attacker)
	if target.type == 0 then
		local qData = Utility.JSONParse(target.GetStringVar(quest_var))
		local v = {}
		for i=1, #qData.list do
			if qData.list[i].type == "DEAD" then
				qData.list[i].save = qData.list[i].save + 1
				if returnBool(string.gsub(qData.list[i].condition, "value", qData.list[i].save), target) == true then
					for i2=1, #qData.list[i].reward do
						target.AddItem(qData.list[i].reward[i2], qData.list[i].count[i2], false)
					end
					target.AddEXP(qData.list[#qData.list-(i-1)].exp)
					target.SendCenterLabel(string.gsub(qData.list[i].name, "slash", "/").." 퀘스트을(를) 완료하였습니다.")
					if qData.list[i].GlobalEvent ~= false then
						target.StartGlobalEvent(tonumber(qData.list[i].GlobalEvent))
					end
					table.insert(v, i)
				end
			end
		end
		for i=1, #v do
			if qData.list[#v-(i-1)].repeated == "false" then
				qData.status[qData.list[#v-(i-1)].id] = true
			end
			qData.list[#v-(i-1)].save = 0
			qData.complete[1+#qData.complete] = qData.list[#v-(i-1)]
			table.remove(qData.list, v[#v-(i-1)])
		end
		target.SetStringVar(quest_var, Utility.JSONSerialize(qData))
	end
end)

Server.onBuyGameMoneyItem.Add(function(unit, dataID, count)
	local qData = Utility.JSONParse(unit.GetStringVar(quest_var))
	local v = {}
	for i=1, #qData.list do
		if qData.list[i].type == "BUY" then
			if dataID == qData.list[i].data[1] then
				qData.list[i].save = qData.list[i].save + count
			end
			if returnBool(string.gsub(qData.list[i].condition, "value", qData.list[i].save), unit) == true then
				for i2=1, #qData.list[i].reward do
					unit.AddItem(qData.list[i].reward[i2], qData.list[i].count[i2], false)
				end
				unit.AddEXP(qData.list[#qData.list-(i-1)].exp)
				unit.SendCenterLabel(string.gsub(qData.list[i].name, "slash", "/").." 퀘스트을(를) 완료하였습니다.")
				if qData.list[i].GlobalEvent ~= false then
					unit.StartGlobalEvent(tonumber(qData.list[i].GlobalEvent))
				end
				table.insert(v, i)
			end
		end
	end
	for i=1, #v do
		if qData.list[#v-(i-1)].repeated == "false" then
			qData.status[qData.list[#v-(i-1)].id] = true
		end
		qData.list[#v-(i-1)].save = 0
		qData.complete[1+#qData.complete] = qData.list[#v-(i-1)]
		table.remove(qData.list, v[#v-(i-1)])
	end
	unit.SetStringVar(quest_var, Utility.JSONSerialize(qData))
end)

Server.onSellGameMoneyItem.Add(function(unit, dataID, count)
	local qData = Utility.JSONParse(unit.GetStringVar(quest_var))
	local v = {}
	for i=1, #qData.list do
		if qData.list[i].type == "SELL" then
			if dataID == qData.list[i].data[1] then
				qData.list[i].save = qData.list[i].save + count
			end
			if returnBool(string.gsub(qData.list[i].condition, "value", qData.list[i].save), unit) == true then
				for i2=1, #qData.list[i].reward do
					unit.AddItem(qData.list[i].reward[i2], qData.list[i].count[i2], false)
				end
				unit.AddEXP(qData.list[#qData.list-(i-1)].exp)
				unit.SendCenterLabel(string.gsub(qData.list[i].name, "slash", "/").." 퀘스트을(를) 완료하였습니다.")
				if qData.list[i].GlobalEvent ~= false then
					unit.StartGlobalEvent(tonumber(qData.list[i].GlobalEvent))
				end
				table.insert(v, i)
			end
		end
	end
	for i=1, #v do
		if qData.list[#v-(i-1)].repeated == "false" then
			qData.status[qData.list[#v-(i-1)].id] = true
		end
		qData.list[#v-(i-1)].save = 0
		qData.complete[1+#qData.complete] = qData.list[#v-(i-1)]
		table.remove(qData.list, v[#v-(i-1)])
	end
	unit.SetStringVar(quest_var, Utility.JSONSerialize(qData))
end)

Server.onAddItem.Add(function(unit, titem)
	local qData = Utility.JSONParse(unit.GetStringVar(quest_var))
	local v = {}
	for i=1, #qData.list do
		if qData.list[i].type == "HAS" then
			if titem.dataID == qData.list[i].data[1] and unit.CountItem(titem.dataID) >= qData.list[i].save then
				qData.list[i].save = unit.CountItem(titem.dataID)
			end
			if returnBool(string.gsub(qData.list[i].condition, "value", qData.list[i].save), unit) == true then
				for i2=1, #qData.list[i].reward do
					unit.AddItem(qData.list[i].reward[i2], qData.list[i].count[i2], false)
				end
				unit.AddEXP(qData.list[#qData.list-(i-1)].exp)
				unit.SendCenterLabel(string.gsub(qData.list[i].name, "slash", "/").." 퀘스트을(를) 완료하였습니다.")
				if qData.list[i].GlobalEvent ~= false then
					unit.StartGlobalEvent(tonumber(qData.list[i].GlobalEvent))
				end
				table.insert(v, i)
			end
		end
	end
	for i=1, #v do
		if qData.list[#v-(i-1)].repeated == "false" then
			qData.status[qData.list[#v-(i-1)].id] = true
		end
		qData.list[#v-(i-1)].save = 0
		qData.complete[1+#qData.complete] = qData.list[#v-(i-1)]
		table.remove(qData.list, v[#v-(i-1)])
	end
	unit.SetStringVar(quest_var, Utility.JSONSerialize(qData))
end)
