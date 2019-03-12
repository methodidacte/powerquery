(vFirstYear as number, optional vLastYear as nullable number, optional vCulture as nullable text) =>
let
	LastYear = if vLastYear = null or vLastYear = "" then Date.Year(DateTime.FixedLocalNow()) else vLastYear,
	Culture = if vCulture = null or vCulture = "" then "en-us" else vCulture,
	Source = List.Dates,
	#"Invoked FunctionSource" = Source(#date(vFirstYear, 1, 1), Duration.Days(#date(LastYear+1,1,1) - #date(vFirstYear,1,1)), #duration(1, 0, 0, 0)),
	#"Table from List" = Table.FromList(#"Invoked FunctionSource", Splitter.SplitByNothing(), null, null, ExtraValues.Error),
	//#"Added Index" = Table.AddIndexColumn(#"Table from List", "Index", 1, 1),
	#"Renamed Columns" = Table.RenameColumns(#"Table from List",{{"Column1", "Date"}}),
    #"Changed Type" = Table.TransformColumnTypes(#"Renamed Columns",{{"Date", type date}}),
	#"Added Year" = Table.AddColumn(#"Changed Type", "Year", each Date.Year([Date]), type number),
	#"Added Month Number" = Table.AddColumn(#"Added Year", "Month Number", each Date.Month([Date]), type number),
    #"Added Month Name" = Table.AddColumn(#"Added Month Number", "Month Name", each Date.ToText([Date],"MMMM", Culture), type text),
    #"Added Month Short Name" = Table.AddColumn(#"Added Month Name", "Month", each Date.ToText([Date],"MMM", Culture), type text),
	#"Added Day in month" = Table.AddColumn(#"Added Month Short Name", "Day of month", each Date.Day([Date]), type number),
    #"Added Day Name" = Table.AddColumn(#"Added Day in month", "Day Name", each Date.ToText([Date],"dddd", Culture), type text),
    #"Added Day Short Name" = Table.AddColumn(#"Added Day Name", "Day", each Date.ToText([Date],"ddd", Culture), type text),
    #"Added Day of Week" = Table.AddColumn(#"Added Day Short Name", "Day of week", each Date.DayOfWeek([Date]), type number),
	#"Added Quarter Number" = Table.AddColumn(#"Added Day of Week", "Quarter Number", each Date.QuarterOfYear([Date]), type number),
	#"Added Year Quarter" = Table.AddColumn(#"Added Quarter Number", "Year Quarter", each Number.ToText([Year]) & "Q" & Number.ToText([Quarter Number],"00"), type text),
	#"Added Year Month" = Table.AddColumn(#"Added Year Quarter", "Year Month", each Number.ToText([Year]) & Number.ToText([Month Number],"00"), type text),
	#"Reordered Columns" = Table.ReorderColumns(#"Added Year Month",{"Date", "Year", "Year Quarter", "Quarter Number", "Month Number", "Month Name", "Month", "Year Month", "Day of month", "Day Name", "Day", "Day of week"})
in
    #"Reordered Columns"
