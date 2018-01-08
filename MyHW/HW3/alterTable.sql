SELECT constraint_name, table_name 
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS; 

ALTER TABLE Carriers
DROP constraint PK__Carriers__D837D05FC3037BB3;
ALTER TABLE Months
DROP constraint PK__Months__DF5032EC07455407;
alter table Weekdays
drop constraint PK__Weekdays__D877D2165FC5AAE8;

alter table Carriers
alter column cid varchar(10);
alter table Carriers
alter column name varchar(100);

alter table Months
alter column month varchar(10);

alter table Weekdays
alter column day_of_week varchar(10);

delete from Carriers
where cid = '02Q';

alter table Carriers
add primary key (cid);