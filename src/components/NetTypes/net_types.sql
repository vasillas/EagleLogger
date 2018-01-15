DROP TABLE IF EXISTS net_types;
CREATE TABLE net_types (
  id serial NOT NULL,
  created timestamp DEFAULT current_timestamp NOT NULL,
  name varchar(32),
  description varchar(256),
  frequency varchar(32),
  start_time time,
  nts boolean DEFAULT false NOT NULL,
  skywarn boolean DEFAULT false NOT NULL,
  deleted boolean DEFAULT false NOT NULL,
  PRIMARY KEY (id),
  UNIQUE (name)
);
