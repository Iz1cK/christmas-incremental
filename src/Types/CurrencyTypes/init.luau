local CurrencyTypes = {}
--#region Decoration
type Decoration = { type: "Decoration" }
--#endregion
--#region CandyCane
type CandyCane = { type: "CandyCane" }
--#endregion
--region Bell
type Bell = { type: "Bell" }
--endregion
--#region CurrencyTypes
export type CurrencyTypes = Decoration | CandyCane | Bell

CurrencyTypes["Decoration"] = { type = "Decoration" } :: Decoration
CurrencyTypes["CandyCane"] = { type = "CandyCane" } :: CandyCane
CurrencyTypes["Bell"] = { type = "Bell" } :: Bell

CurrencyTypes = table.freeze(CurrencyTypes)

return CurrencyTypes
--#endregion