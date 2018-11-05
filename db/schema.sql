### Schema

-- CREATE DATABASE burgers_db;
USE burgers_db;

drop table if exists burgers;
drop trigger if exists before_insert_burgers;
drop trigger if exists before_update_burgers;

create table burgers (
	id char(36) not null Primary key,
    date_created datetime not null default current_timestamp(),
    last_mod_date datetime not null,
    name varchar(255) not null,
    devoured BOOLEAN DEFAULT false
);

-- DELIMITER ;;
CREATE TRIGGER before_insert_burgers
BEFORE INSERT ON burgers
FOR EACH ROW
BEGIN
    SET new.id = uuid();
    SET new.date_created=current_timestamp();
    SET new.last_mod_date=new.date_created;
END;

CREATE TRIGGER before_update_burgers
BEFORE UPDATE ON burgers
FOR EACH ROW
BEGIN
	SET new.id=OLD.id;
	SET new.date_created=OLD.date_created;
    SET new.last_mod_date=current_timestamp();
END;
-- ;;