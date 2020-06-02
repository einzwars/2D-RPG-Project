
ScreenUI.hpBarVisible  = false
ScreenUI.mpBarVisible  = false
ScreenUI.expBarVisible  = false
ScreenUI.levelVisible = false

HPMP = Image("Pictures/HPMP.png", Rect(Client.width/2-104, Client.height-101, 207, 41))
HUD = Image("Pictures/HUD.png", Rect(0, Client.height-48, 1200, 48))
BAR_HP = Image("Pictures/BAR_HP.png", Rect(Client.width/2-60, Client.height-95, 146, 10))
BAR_MP = Image("Pictures/BAR_MP.png", Rect(Client.width/2-60, Client.height-79, 146, 10))
BAR_EXP = Image("Pictures/BAR_EXP.png", Rect(178, Client.height-16, 531, 10))

LVTextOut1 = Text()
LVTextOut1.rect = Rect(9, Client.height-48+17, 122, 31)
LVTextOut1.textSize = 20
LVTextOut2 = Text()
LVTextOut2.rect = Rect(9, Client.height-48+19, 122, 31)
LVTextOut2.textSize = 20
LVTextOut3 = Text()
LVTextOut3.rect = Rect(11, Client.height-48+17, 122, 31)
LVTextOut3.textSize = 20
LVTextOut4 = Text()
LVTextOut4.rect = Rect(11, Client.height-48+19, 122, 31)
LVTextOut4.textSize = 20
LVText = Text()
LVText.rect = Rect(10, Client.height-48+18, 122, 31)
LVText.textSize = 20

function refreshUI()

	LVText.text = "LV."..Client.myPlayerUnit.level
	LVTextOut1.text = "<color=#000000>LV."..Client.myPlayerUnit.level.."</color>"
	LVTextOut2.text = "<color=#000000>LV."..Client.myPlayerUnit.level.."</color>"
	LVTextOut3.text = "<color=#000000>LV."..Client.myPlayerUnit.level.."</color>"
	LVTextOut4.text = "<color=#000000>LV."..Client.myPlayerUnit.level.."</color>"

	BAR_HP.DOScale(Point(Client.myPlayerUnit.hp/Client.myPlayerUnit.maxHP, 1), 0.5)
	BAR_MP.DOScale(Point(Client.myPlayerUnit.mp/Client.myPlayerUnit.maxMP, 1), 0.5)
	BAR_EXP.DOScale(Point(Client.myPlayerUnit.exp/Client.myPlayerUnit.maxEXP, 1), 0.5)
end

Client.onTick.Add(refreshUI,1)
