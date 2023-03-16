if ExposedMembers.AL == nil then ExposedMembers.AL = {}; end
ExposedMembers.GameEvents = GameEvents

function GetNextPlot(iPlayerID, iCityID)
	local pCity = CityManager.GetCity(iPlayerID, iCityID);
	local iPlot = -1;
	if pCity ~= nil and pCity:GetCulture() ~= nil then
		iPlot = pCity:GetCulture():GetNextPlot();
        print("iPlot is"..iPlot)
	end
	return iPlot;
end
ExposedMembers.AL.GetNextPlot = GetNextPlot

function KaedeGovernorHasPomotion(iPlayerID)
	local pPlayer = Players[iPlayerID];
	local pGovernors = pPlayer:GetGovernors();
	local pGovernor = pGovernors:GetGovernor(GameInfo.Governors["GOVERNOR_AL_KAEDE"].Index);
	if pGovernor:HasPromotion(GameInfo.GovernorPromotions["GOVERNOR_PROMOTION_AL_KAEDE_5"].Hash) then
		print("success" )
		return true;
	else
		print("false")
		return false;
	end
end
ExposedMembers.AL.KaedeGovernorHasPomotion = KaedeGovernorHasPomotion