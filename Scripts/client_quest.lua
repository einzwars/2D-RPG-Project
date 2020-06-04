
local function comma_value(amount)
	local formatted = amount
	while true do  
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
		if (k==0) then
			break
		end
	end
	return formatted
end

function open_quest()
	Client.FireEvent("getqData")

end

Client.GetTopic("postqData").Add(function(qData)

	local sel = 1

	qData = Utility.JSONParse(qData)

	local mask = Panel(Rect(0, 0, Client.width, Client.height))
	mask.SetOpacity(185)
	mask.showOnTop = true

	local panel = Image("Pictures/quest_panel.png", Rect(Client.width/2-266, Client.height/2-162, 533, 324))


	local closeButton = Button("", Rect(533-23-4, 4, 23, 23))
	closeButton.SetOpacity(0)
	closeButton.onClick.Add(function()
		mask.Destroy()
	end)
	closeButton.AddChild(Image("Pictures/closeButton.png", Rect(0, 0, 23, 23)))

	local explainText = Text("", Rect(214, 51, 255, 135))
	explainText.textAlign = 4

	local rewardEXPText = Text("", Rect(249, 289, 186, 22))
	local rewardEXPText1 = Text("", Rect(248, 288, 186, 22))
	local rewardEXPText2 = Text("", Rect(248, 290, 186, 22))
	local rewardEXPText3 = Text("", Rect(250, 288, 186, 22))
	local rewardEXPText4 = Text("", Rect(250, 290, 186, 22))
	rewardEXPText.textAlign = 4
	rewardEXPText1.textAlign = 4
	rewardEXPText2.textAlign = 4
	rewardEXPText3.textAlign = 4
	rewardEXPText4.textAlign = 4

	local listScrollPanel = ScrollPanel(Rect(17, 51, 178, 253))
	listScrollPanel.SetOpacity(0)

	local rewardScrollPanel = ScrollPanel(Rect(270, 215, 145, 62))
	rewardScrollPanel.SetOpacity(0)
	local rewardBoard

	local function refresh(sel)
		explainText.text = ""
		rewardEXPText.text = ""
		rewardEXPText1.text = ""
		rewardEXPText2.text = ""
		rewardEXPText3.text = ""
		rewardEXPText4.text = ""
		if listBoard ~= nil then
			listBoard.Destroy()
		end
		if rewardBoard ~= nil then
			rewardBoard.Destroy()
		end
		if sel == 1 then
			listBoard = Panel(Rect(0, 0, 178, (#qData.list*38)+(#qData.list-1*4)))
			listBoard.SetOpacity(0)
			for i=1, #qData.list do
				local panel = Panel(Rect(0, ((i-1)*38)+((i-1)*4), 178, 38))
				local txt = Text("", Rect(0, 0, 178, 38))
				txt.textAlign = 4
				txt.text = string.gsub(qData.list[i].name, "slash", "/")
				local button = Button("", Rect(0, 0, 178, 38))
				button.onClick.Add(function()
					if rewardBoard ~= nil then
						rewardBoard.Destroy()
					end
					rewardBoard = Panel(Rect(0, 0, ((#qData.list[i].reward)*32)+((#qData.list[i].reward-1)*6), 62))
					rewardBoard.SetOpacity(0)
					for i2=1, #qData.list[i].reward do
						local image = Image("", Rect(((i2-1)*32)+((i2-1)*6)+5, 5, 32, 32))
						local txt = Text("", Rect(((i2-1)*32)+((i2-1)*6)+5, 30, 32, 32))
						txt.textAlign = 4
						txt.text = qData.list[i].count[i2]

						local txt1 = Text("", Rect(((i2-1)*32)+((i2-1)*6)+4, 29, 32, 32))
						txt1.textAlign = 4
						txt1.text = "<color=#000000>"..qData.list[i].count[i2].."</color>"
						local txt2 = Text("", Rect(((i2-1)*32)+((i2-1)*6)+4, 31, 32, 32))
						txt2.textAlign = 4
						txt2.text = "<color=#000000>"..qData.list[i].count[i2].."</color>"
						local txt3 = Text("", Rect(((i2-1)*32)+((i2-1)*6)+6, 29, 32, 32))
						txt3.textAlign = 4
						txt3.text = "<color=#000000>"..qData.list[i].count[i2].."</color>"
						local txt4 = Text("", Rect(((i2-1)*32)+((i2-1)*6)+6, 31, 32, 32))
						txt4.textAlign = 4
						txt4.text = "<color=#000000>"..qData.list[i].count[i2].."</color>"
						image.SetImageID(Client.GetItem(qData.list[i].reward[i2]).imageID)
						rewardBoard.AddChild(image)
						rewardBoard.AddChild(txt1)
						rewardBoard.AddChild(txt2)
						rewardBoard.AddChild(txt3)
						rewardBoard.AddChild(txt4)
						rewardBoard.AddChild(txt)
					end

					rewardScrollPanel.AddChild(rewardBoard)
					rewardScrollPanel.content = rewardBoard

					local t = qData.list[i].explain
					t = string.gsub(t, "line", "\n")
					t = string.gsub(t, "slash", "/")
					t = string.gsub(t, "colon", ":")
					t = string.gsub(t, "dot", ".")
					t = string.gsub(t, "value", qData.list[i].save)
					explainText.text = t
					if qData.list[i].exp ~= 0 then
						local xp = comma_value(qData.list[i].exp)
						rewardEXPText.text = "획득 경험치 : "..xp.." EXP"
						rewardEXPText1.text = "<color=#000000>획득 경험치 : "..xp.." EXP</color>"
						rewardEXPText2.text = "<color=#000000>획득 경험치 : "..xp.." EXP</color>"
						rewardEXPText3.text = "<color=#000000>획득 경험치 : "..xp.." EXP</color>"
						rewardEXPText4.text = "<color=#000000>획득 경험치 : "..xp.." EXP</color>"
					else
						rewardEXPText.text = ""
						rewardEXPText1.text = ""
						rewardEXPText2.text = ""
						rewardEXPText3.text = ""
						rewardEXPText4.text = ""
					end
				end)

				panel.SetOpacity(50)
				button.SetOpacity(50)

				panel.AddChild(txt)
				panel.AddChild(button)
				listBoard.AddChild(panel)
			end
		else
			listBoard = Panel(Rect(0, 0, 178, (#qData.complete*38)+(#qData.complete-1*4)))
			for i=1, #qData.complete do
				local panel = Panel(Rect(0, ((i-1)*38)+((i-1)*4), 178, 38))
				local txt = Text("", Rect(0, 0, 178, 38))
				txt.textAlign = 4
				txt.text = string.gsub(qData.complete[i].name, "slash", "/")
				local button = Button("", Rect(0, 0, 178, 38))
				button.onClick.Add(function()
					if rewardBoard ~= nil then
						rewardBoard.Destroy()
					end

					rewardBoard = Panel(Rect(0, 0, ((#qData.complete[i].reward)*32)+((#qData.complete[i].reward-1)*6), 62))
					rewardBoard.SetOpacity(0)
					for i2=1, #qData.complete[i].reward do
						local image = Image("", Rect(((i2-1)*32)+((i2-1)*6)+5, 5, 32, 32))
						local txt = Text("", Rect(((i2-1)*32)+((i2-1)*6)+5, 30, 32, 32))
						txt.textAlign = 4
						txt.text = qData.complete[i].count[i2]
						local txt1 = Text("", Rect(((i2-1)*32)+((i2-1)*6)+4, 29, 32, 32))
						txt1.textAlign = 4
						txt1.text = "<color=#000000>"..qData.complete[i].count[i2].."</color>"
						local txt2 = Text("", Rect(((i2-1)*32)+((i2-1)*6)+4, 31, 32, 32))
						txt2.textAlign = 4
						txt2.text = "<color=#000000>"..qData.complete[i].count[i2].."</color>"
						local txt3 = Text("", Rect(((i2-1)*32)+((i2-1)*6)+6, 29, 32, 32))
						txt3.textAlign = 4
						txt3.text = "<color=#000000>"..qData.complete[i].count[i2].."</color>"
						local txt4 = Text("", Rect(((i2-1)*32)+((i2-1)*6)+6, 31, 32, 32))
						txt4.textAlign = 4
						txt4.text = "<color=#000000>"..qData.complete[i].count[i2].."</color>"
						image.SetImageID(Client.GetItem(qData.complete[i].reward[i2]).imageID)
						rewardBoard.AddChild(image)
						rewardBoard.AddChild(txt1)
						rewardBoard.AddChild(txt2)
						rewardBoard.AddChild(txt3)
						rewardBoard.AddChild(txt4)
						rewardBoard.AddChild(txt)
					end

					rewardScrollPanel.AddChild(rewardBoard)
					rewardScrollPanel.content = rewardBoard

					local t = qData.complete[i].explain
					t = string.gsub(t, "line", "\n")
					t = string.gsub(t, "slash", "/")
					t = string.gsub(t, "colon", ":")
					t = string.gsub(t, "dot", ".")
					t = string.gsub(t, "value", qData.complete[i].save)
					explainText.text = t
					if qData.complete[i].exp ~= 0 then
						local xp = comma_value(qData.complete[i].exp)
						rewardEXPText.text = "획득 경험치 : "..xp.." EXP"
						rewardEXPText1.text = "<color=#000000>획득 경험치 : "..xp.." EXP</color>"
						rewardEXPText2.text = "<color=#000000>획득 경험치 : "..xp.." EXP</color>"
						rewardEXPText3.text = "<color=#000000>획득 경험치 : "..xp.." EXP</color>"
						rewardEXPText4.text = "<color=#000000>획득 경험치 : "..xp.." EXP</color>"
					else
						rewardEXPText.text = ""
						rewardEXPText1.text = ""
						rewardEXPText2.text = ""
						rewardEXPText3.text = ""
						rewardEXPText4.text = ""
					end
				end)

				panel.SetOpacity(50)
				button.SetOpacity(50)

				panel.AddChild(txt)
				panel.AddChild(button)
				listBoard.AddChild(panel)
			end
		end
		listScrollPanel.AddChild(listBoard)
		listScrollPanel.content = listBoard
	end

	local ongoingList = Button("진\n행\n중", Rect(496, 80, 37, 79))
	ongoingList.textSize = 16
	ongoingList.color = Color(35, 35, 35)
	ongoingList.onClick.Add(function()
		sel = 1
		refresh(1)
	end)

	local completeList = Button("완\n료", Rect(496, 188, 37, 79))
	completeList.textSize = 16
	completeList.color = Color(35, 35, 35)
	completeList.onClick.Add(function()
		sel = 2
		refresh(2)
	end)

	refresh(sel)

	listScrollPanel.horizontal = false
	listScrollPanel.showHorizontalScrollbar = true

	rewardScrollPanel.vertical = false
	rewardScrollPanel.showHorizontalScrollbar = true

	panel.AddChild(listScrollPanel)
	panel.AddChild(rewardScrollPanel)
	panel.AddChild(explainText)
	panel.AddChild(rewardEXPText1)
	panel.AddChild(rewardEXPText2)
	panel.AddChild(rewardEXPText3)
	panel.AddChild(rewardEXPText4)
	panel.AddChild(rewardEXPText)

	panel.AddChild(closeButton)
	panel.AddChild(ongoingList)
	panel.AddChild(completeList)
	mask.AddChild(panel)
end)

-- open_quest()