let
    Source = {0..23},
    #"Converti en table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Colonnes renommées" = Table.RenameColumns(#"Converti en table",{{"Column1", "Hours"}}),
    #"Personnalisée ajoutée" = Table.AddColumn(#"Colonnes renommées", "Minutes", each {0..59}),
    #"Minutes développé" = Table.ExpandListColumn(#"Personnalisée ajoutée", "Minutes"),
    #"Personnalisée ajoutée1" = Table.AddColumn(#"Minutes développé", "Seconds", each {0..59}),
    #"Seconds développé" = Table.ExpandListColumn(#"Personnalisée ajoutée1", "Seconds"),
    #"Personnalisée ajoutée2" = Table.AddColumn(#"Seconds développé", "Time", each #time([Hours],[Minutes],[Seconds])),
    #"Type modifié" = Table.TransformColumnTypes(#"Personnalisée ajoutée2",{{"Hours", Int64.Type}, {"Minutes", Int64.Type}, {"Seconds", Int64.Type}, {"Time", type time}}),
    #"Personnalisée ajoutée3" = Table.AddColumn(#"Type modifié", "Record", each Time.ToRecord([Time]))
in
    #"Personnalisée ajoutée3"
