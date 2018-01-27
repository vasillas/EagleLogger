-- TEMPORARY TABLES
-- EN.dat
DROP TABLE IF EXISTS fcc_l_amat_en_tmp;
CREATE TEMPORARY TABLE fcc_l_amat_en_tmp (
  record_type char(2),
  usid numeric(9),
  uls text,
  ebf varchar(30),
  callsign char(10),
  type char(2),
  licensee_id char(9),
  name varchar(200),
  first_name varchar(20),
  middle_initial char(1),
  last_name varchar(20),
  suffix char(3),
  phone char(10),
  fax char(10),
  email varchar(50),
  address varchar(60),
  city varchar(20),
  state char(2),
  zip_code char(9),
  po_box varchar(20),
  attention_line varchar(35),
  sgin char(3),
  frn text,
  applicant_type char(1),
  applicant_type_other char(40),
  status_code char(1),
  status_date varchar(30)
);

-- HD.dat
DROP TABLE IF EXISTS fcc_l_amat_hd_tmp;
CREATE TEMPORARY TABLE fcc_l_amat_hd_tmp (
  record_type char(2),
  usid numeric(9),
  uls char(14),
  ebf varchar(30),
  callsign char(10),
  status char(1),
  radio_service_code char(2),
  grant_date text,
  expired_date text,
  cancellation_date text,
  eligibility_rule_num char(10),
  reserved char(1),
  alien char(1),
  alien_government char(1),
  alien_corporation char(1),
  alien_officer char(1),
  alien_control char(1),
  revoked char(1),
  convicted char(1),
  adjudged char(1),
  reserved2 char(1),
  common_carrier char(1),
  non_common_carrier char(1),
  private_comm char(1),
  fixed char(1),
  mobile char(1),
  radiolocation char(1),
  satellite char(1),
  developmental_or_sta_or_demonstration char(1),
  interconnected_service char(1),
  certifier_first_name varchar(20),
  certifier_mi char(1),
  certifier_last_name varchar(20),
  certifier_suffix char(3),
  certifier_title char(40),
  female char(1),
  black_or_african_american char(1),
  native_american char(1),
  hawaiian char(1),
  asian char(1),
  white char(1),
  hispanic char(1),
  effective_date text,
  last_action_date text,
  auction_id text,
  broadcast_services_regulatory_status char(1),
  band_manager_regulatory_status char(1),
  broadcast_services_type_of_radio_service char(1),
  alien_ruling char(1),
  licensee_name_change char(1)
);

-- IMPORT DATA
\copy fcc_l_amat_en_tmp FROM 'tmp/EN.dat' DELIMITER '|'
\copy fcc_l_amat_hd_tmp FROM 'tmp/HD.dat' DELIMITER '|'

-- INSERT EN/HD DATA
INSERT INTO fcc_l_amat_en (
  record_type,
  usid,
  uls,
  ebf,
  callsign,
  type,
  licensee_id,
  name,
  first_name,
  middle_initial,
  last_name,
  suffix,
  phone,
  fax,
  email,
  address,
  city,
  state,
  zip_code,
  po_box,
  attention_line,
  sgin,
  frn,
  applicant_type,
  applicant_type_other,
  status_code,
  status_date
) SELECT
  record_type,
  usid,
  uls,
  ebf,
  callsign,
  type,
  licensee_id,
  name,
  first_name,
  middle_initial,
  last_name,
  suffix,
  phone,
  fax,
  email,
  address,
  city,
  state,
  zip_code,
  po_box,
  attention_line,
  sgin,
  CASE WHEN TRIM(frn) = ''
    THEN 0
    ELSE frn::bigint
  END,
  applicant_type,
  applicant_type_other,
  status_code,
  to_date(nullif(status_date, ''), 'MM/DD/YYYY')
FROM fcc_l_amat_en_tmp
ON CONFLICT (usid) DO NOTHING;

INSERT INTO fcc_l_amat_hd (
  record_type,
  usid,
  uls,
  ebf,
  callsign,
  status,
  radio_service_code,
  grant_date,
  expired_date,
  cancellation_date,
  eligibility_rule_num,
  reserved,
  alien,
  alien_government,
  alien_corporation,
  alien_officer,
  alien_control,
  revoked,
  convicted,
  adjudged,
  reserved2,
  common_carrier,
  non_common_carrier,
  private_comm,
  fixed,
  mobile,
  radiolocation,
  satellite,
  developmental_or_sta_or_demonstration,
  interconnected_service,
  certifier_first_name,
  certifier_mi,
  certifier_last_name,
  certifier_suffix,
  certifier_title,
  female,
  black_or_african_american,
  native_american,
  hawaiian,
  asian,
  white,
  hispanic,
  effective_date,
  last_action_date,
  auction_id,
  broadcast_services_regulatory_status,
  band_manager_regulatory_status,
  broadcast_services_type_of_radio_service,
  alien_ruling,
  licensee_name_change
) SELECT
  record_type,
  usid,
  uls,
  ebf,
  callsign,
  status,
  radio_service_code,
  to_date(nullif(grant_date, ''), 'MM/DD/YYYY'),
  to_date(nullif(expired_date, ''), 'MM/DD/YYYY'),
  to_date(nullif(cancellation_date, ''), 'MM/DD/YYYY'),
  eligibility_rule_num,
  reserved,
  alien,
  alien_government,
  alien_corporation,
  alien_officer,
  alien_control,
  revoked,
  convicted,
  adjudged,
  reserved2,
  common_carrier,
  non_common_carrier,
  private_comm,
  fixed,
  mobile,
  radiolocation,
  satellite,
  developmental_or_sta_or_demonstration,
  interconnected_service,
  certifier_first_name,
  certifier_mi,
  certifier_last_name,
  certifier_suffix,
  certifier_title,
  female,
  black_or_african_american,
  native_american,
  hawaiian,
  asian,
  white,
  hispanic,
  to_date(nullif(effective_date, ''), 'MM/DD/YYYY'),
  to_date(nullif(last_action_date, ''), 'MM/DD/YYYY'),
  NULLIF(auction_id, '')::int,
  broadcast_services_regulatory_status,
  band_manager_regulatory_status,
  broadcast_services_type_of_radio_service,
  alien_ruling,
  licensee_name_change
FROM fcc_l_amat_hd_tmp
ON CONFLICT (usid) DO NOTHING;

-- INSERT CALLSIGNS
INSERT INTO callsigns (
  frn, callsign, name,
  first_name, middle_initial, last_name,
  email, phone, address, zip_code_id,
  valid_start, valid_end
) SELECT DISTINCT ON (fcc_l_amat_en.frn)
  fcc_l_amat_en.frn,
  TRIM(fcc_l_amat_en.callsign),
  initcap(fcc_l_amat_en.first_name),
  initcap(fcc_l_amat_en.first_name),
  initcap(fcc_l_amat_en.middle_initial),
  initcap(fcc_l_amat_en.last_name),
  fcc_l_amat_en.email,
  fcc_l_amat_en.phone,
  initcap(fcc_l_amat_en.address),
  zip_codes.id,
  fcc_l_amat_hd.grant_date,
  coalesce(fcc_l_amat_hd.cancellation_date, fcc_l_amat_hd.expired_date)
FROM fcc_l_amat_en
LEFT JOIN fcc_l_amat_hd ON fcc_l_amat_hd.usid = fcc_l_amat_en.usid
LEFT JOIN zip_codes ON zip_codes.zip_code = fcc_l_amat_en.zip_code
WHERE frn > 0
ORDER BY fcc_l_amat_en.frn, fcc_l_amat_hd.grant_date DESC, fcc_l_amat_en.usid DESC
ON CONFLICT (frn) DO UPDATE SET
  callsign = TRIM(excluded.callsign),
  first_name = excluded.first_name,
  middle_initial = excluded.middle_initial,
  last_name = excluded.last_name,
  email = excluded.email,
  phone = excluded.phone,
  address = excluded.address,
  valid_start = excluded.valid_start,
  valid_end = excluded.valid_end
;
