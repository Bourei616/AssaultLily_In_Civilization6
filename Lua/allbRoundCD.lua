local RoundCounter = {}
if ExposedMembers.AL == nil then ExposedMembers.AL = {} end
ExposedMembers.AL.RoundCD = {
	set = function(playerID, cd, callback)
		if RoundCounter[playerID] == nil then
			RoundCounter[playerID] = {}
		end
		local obj = {
			cd = cd,
			callback = callback
		}
		table.insert(RoundCounter[playerID], obj)
	end,
	run = function(playerID)
		if RoundCounter[playerID] == nil then
			return
		end
		for i, e in pairs(RoundCounter[playerID]) do
			e.cd = e.cd - 1
			if (e.cd == 0) then
				e.callback()
				RoundCounter[playerID][i] = nil
			end
		end
	end
}

GameEvents.PlayerTurnStarted.Add(ExposedMembers.AL.RoundCD.run)

--[[ 测试：三回合后本地玩家在控制台打印“三回合已到！”
ExposedMembers.AL.RoundCD.set(0,3,function()
	print("三回合已到！")
end)
--]]