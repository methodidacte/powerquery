(URL) =>
let

    JsonRecords = URL,
    JsonRequest = "{""url"": """ & JsonRecords & """}",
    JsonContent = Text.ToBinary(JsonRequest, TextEncoding.Ascii),
    Response =
        Web.Contents("https://YOUR_REGION.api.cognitive.microsoft.com/vision/v1.0/analyze?",
                [Headers=[#"Ocp-Apim-Subscription-Key"="YOUR_KEY", #"Content-Type"="application/json"],
                Content=JsonContent
            ]),

    JsonResponse = Json.Document(Response,1252),
    categories = JsonResponse[categories],
    ListToTable = Table.FromList(categories, Splitter.SplitByNothing(), null, null, ExtraValues.Error),
    ExpandTable = Table.ExpandRecordColumn(ListToTable, "Column1", {"name", "score"}, {"description", "confidence"}),
    Output = Table.TransformColumnTypes(ExpandTable,{{"description", type text}, {"confidence", type number}})
in
    Output
