let
    Source = Excel.Workbook(File.Contents("C:\DIAD\Data\USSales\bi_dimensions.xlsx"), null, true),
    geo_Sheet = Source{[Item="geo",Kind="Sheet"]}[Data],
    #"Removed Top Rows" = Table.Skip(geo_Sheet,3),
    #"Promoted Headers" = Table.PromoteHeaders(#"Removed Top Rows", [PromoteAllScalars=true]),
    #"Changed Type" = Table.TransformColumnTypes(#"Promoted Headers",{{"Zip", type text}, {"City", type text}, {"State", type text}, {"Region", type text}, {"District", type text}, {"Country", type text}}),
    #"Replaced Value" = Table.ReplaceValue(#"Changed Type",null,"Nigeria",Replacer.ReplaceValue,{"Country"}),
    #"Added Custom" = Table.AddColumn(#"Replaced Value", "CustomKey", each [Zip] & "," & [Country]),
    #"Added Conditional Column" = Table.AddColumn(#"Added Custom", "Custom", each if [District] <> "NULL" then [District] else [Zip] & "," & [City]),
    #"Removed Columns" = Table.RemoveColumns(#"Added Conditional Column",{"District"}),
    #"Renamed Columns" = Table.RenameColumns(#"Removed Columns",{{"Custom", "District"}})
in
    #"Renamed Columns"