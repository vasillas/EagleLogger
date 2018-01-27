DROP VIEW IF EXISTS checkins_view;
CREATE VIEW checkins_view AS
  SELECT
    checkins.*,
    checkins.id as checkin_id,
    callsigns.created as callsign_created,
    callsigns.callsign as callsign,
    callsigns.callsign as title,
    callsigns.name ||
      COALESCE(' in ' || zip_codes.county, '') as subtitle
  FROM checkins
  JOIN callsigns ON callsigns.id = checkins.callsign_id
  LEFT JOIN zip_codes ON zip_codes.id = callsigns.zip_code_id
;