json.array!(@divesites) do |divesite|
  json.name           divesite.name
  json.latitude       divesite.latitude
  json.longitude      divesite.longitude
end
