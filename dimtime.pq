let
    Source = {0..23},
    #"Converti en table" = Table.FromList(Source, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    #"Colonnes renommées" = Table.RenameColumns(#"Converti en table",{{"Column1", "Hours"}}),
    #"Personnalisée ajoutée" = Table.AddColumn(#"Colonnes renommées", "Minuts", each {0..59}),
    #"Minuts développé" = Table.ExpandListColumn(#"Personnalisée ajoutée", "Minuts"),
    #"Personnalisée ajoutée1" = Table.AddColumn(#"Minuts développé", "Seconds", each {0..59}),
    #"Seconds développé" = Table.ExpandListColumn(#"Personnalisée ajoutée1", "Seconds"),
    #"Personnalisée ajoutée2" = Table.AddColumn(#"Seconds développé", "Time", each #time([Hours],[Minuts],[Seconds])),
    #"Type modifié" = Table.TransformColumnTypes(#"Personnalisée ajoutée2",{{"Hours", Int64.Type}, {"Minuts", Int64.Type}, {"Seconds", Int64.Type}, {"Time", type time}}),
    #"Personnalisée ajoutée3" = Table.AddColumn(#"Type modifié", "Record", each Time.ToRecord([Time]))
in
    #"Personnalisée ajoutée3"
