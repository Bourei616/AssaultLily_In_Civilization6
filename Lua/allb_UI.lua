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