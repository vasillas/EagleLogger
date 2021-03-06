DROP VIEW IF EXISTS nets_view;
CREATE VIEW nets_view AS
  SELECT
    nets.id as net_id,
    nets.id,
    nets.created,
    nets.net_type_id,
    nets.ncs_id,
    nets.started,
    nets.stopped,
    nets.deleted,
    net_types.name,
    net_types.description,
    net_types.frequency,
    net_types.start_time,
    net_types.nts,
    net_types.skywarn,
    net_types.name ||
      COALESCE(' (' || net_types.frequency || 'MHz)', '') ||
      COALESCE(' - ' || TO_CHAR(nets.started, 'Dy, Mon fmDDth @ HH24:MI'), '')
      as title,
    net_types.description ||
      COALESCE(' - ' || count(checkins.*) || ' checkins', '')
      as subtitle
  FROM nets
  JOIN net_types ON net_types.id = nets.net_type_id
  LEFT JOIN checkins ON checkins.net_id = nets.id
  GROUP BY nets.id,
    net_types.id
;

