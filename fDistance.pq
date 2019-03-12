(lat1 as number, long1 as number, lat2 as number, long2 as number, optional miles as logical) =>

let
	lat1rad = lat1 * Number.PI / 180,
	long1rad = long1 * Number.PI / 180,
	lat2rad = lat2 * Number.PI / 180,
	long2rad = long2 * Number.PI / 180,
	r = 6372.797, // mean radius of Earth in km
	dlat = lat2rad - lat1rad,
  dlng = long2rad - long1rad,
  a = Number.Sin(dlat / 2) * Number.Sin(dlat / 2) + Number.Cos(lat1) * Number.Cos(lat2) * Number.Sin(dlng / 2) * Number.Sin(dlng / 2),
  c = 2 * Number.Atan(Number.Sqrt(a) / Number.Sqrt(1 - a)),
 	km = r * c,
	result = if miles then km * 0.621371192 / km else km
in
	result
