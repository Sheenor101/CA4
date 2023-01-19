
library(RSQLite)

con <- dbConnect(SQLite(), dbname = "CA4.sqlite3")
                 
sql <- readLines("D:\\DKIT\\SqlDatabase\\SqlScript.sql")

dbExecute(con, "CREATE TABLE assets (
   id integer NOT NULL CONSTRAINT assets_pk PRIMARY KEY,
   name text NOT NULL,
   type text NOT NULL,
   status text NOT NULL);")

dbExecute(con, "CREATE TABLE project (
  name text NOT NULL,
  phase text NOT NULL,
  date_start date NOT NULL,
  date_end date NOT NULL,
  team text NOT NULL,
  CONSTRAINT project_pk PRIMARY KEY (name,phase),
  CONSTRAINT project_team_ak UNIQUE (team));")

dbExecute(con, "CREATE TABLE tasks (
    id integer NOT NULL CONSTRAINT tasks_pk PRIMARY KEY,
    name text NOT NULL,
    status text NOT NULL,
    project_name text NOT NULL,
    project_phase text NOT NULL,
    team_name text NOT NULL,
    team_member_id integer NOT NULL,
    CONSTRAINT tasks_project FOREIGN KEY (project_name,project_phase)
    REFERENCES project (name,phase),
    CONSTRAINT tasks_team FOREIGN KEY (team_name,team_member_id)
    REFERENCES team (name,member_id));")

dbExecute(con, "CREATE TABLE team (
    name text NOT NULL,
    member_id integer NOT NULL,
    project_name text NOT NULL,
    project_phase text NOT NULL,
    CONSTRAINT team_pk PRIMARY KEY (name,member_id),
    CONSTRAINT team_project FOREIGN KEY (project_name,project_phase)
    REFERENCES project (name,phase));")

dbExecute(con, "CREATE TABLE team_members (
    id integer NOT NULL CONSTRAINT team_members_pk PRIMARY KEY,
    name text NOT NULL,
    team text NOT NULL);")

dbListTables(con)

dbGetQuery(con, "SELECT name from sqlite_master WHERE type='table';")

##### populate tqables ####


dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(1,'Chair','PROP','Not Started');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(2,'Car','PROP','Cleanup');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(3,'Street Walker','CHAR','Not Started');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(4,'Spotlight','FX','Not Started');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(5,'Sewing Machine','PROP','Complete');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(6,'Kitchen','LOCATION','Not Started');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(7,'Shoe 1','PROP','Cleanup');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(8,'Ball of Wool','PROP','Not Started');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(9,'Table','PROP','Not Started');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(10,'Buttermilk Churn','PROP','Not Started');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(11,'Coins','PROP','Completed');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(12,'Street','LOCATION','Completed');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(13,'FX Fire','FX','Cleanup');")
dbExecute(con, "INSERT INTO assets (id, name, type, status) VALUES(14,'Radio','PROP','Not Started');")

dbGetQuery(con, "SELECT * from assets;")
#dbExecute(con, "DELETE FROM assets WHERE id=2;")

dbExecute(con, "INSERT INTO project (name, phase, date_start, date_end, team) VALUES('Mams Old Chair','Backgrounds','2023-01-07','2023-01-25', 'Layout');")
dbExecute(con, "INSERT INTO project (name, phase, date_start, date_end, team) VALUES('Mams Old Chair','Asset Build','2023-01-25','2023-02-01', 'Modelling1');")
dbExecute(con, "INSERT INTO project (name, phase, date_start, date_end, team) VALUES('Mams Old Chair','Character Build','2023-02-01','2023-02-22', 'Modelling2');")
dbExecute(con, "INSERT INTO project (name, phase, date_start, date_end, team) VALUES('Mams Old Chair','Character Rig','2023-02-22','2023-03-01', 'Rigging');")
dbExecute(con, "INSERT INTO project (name, phase, date_start, date_end, team) VALUES('Mams Old Chair','Props','2023-03-01','2023-03-08', 'Modelling3');")
dbExecute(con, "INSERT INTO project (name, phase, date_start, date_end, team) VALUES('Mams Old Chair','Animation','2023-03-08','2023-04-08', 'Animation');")
dbExecute(con, "INSERT INTO project (name, phase, date_start, date_end, team) VALUES('Mams Old Chair','Compositing','2023-04-09','2023-04-25', 'Compositing');")
dbExecute(con, "INSERT INTO project (name, phase, date_start, date_end, team) VALUES('Mams Old Chair','Sound_FX','2023-04-25','2023-04-30', 'FX');")


dbGetQuery(con, "SELECT * from project;")

dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('Layout','101','Mams Old Chair', 'Backgrounds');")
dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('Modelling1','103','Mams Old Chair', 'Asset Build');")
dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('Modelling2','103','Mams Old Chair', 'Character Build');")
dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('Rigging','105','Mams Old Chair', 'Character Rig');")
dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('Modelling3','103','Mams Old Chair', 'Props');")
dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('Animation','104','Mams Old Chair', 'Animation');")
dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('Animation','102','Mams Old Chair', 'Animation');")
dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('Compositing','107','Mams Old Chair', 'Compositing');")
dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('FX','108','Mams Old Chair', 'Sound_FX');")
dbExecute(con, "INSERT INTO team (name, member_id, project_name, project_phase) VALUES('Rigging','106','Mams Old Chair', 'Character Rig');")

dbGetQuery(con, "SELECT * from team ORDER BY project_phase;")

dbExecute(con, "INSERT INTO team_members (id, name, team) VALUES('101','Sheena Walsh', 'Layout');")
dbExecute(con, "INSERT INTO team_members (id, name, team) VALUES('102','Seamus Tuffy', 'Animation');")
dbExecute(con, "INSERT INTO team_members (id, name, team) VALUES('103','Marie McGovern', 'Modelling');")
dbExecute(con, "INSERT INTO team_members (id, name, team) VALUES('104','Neil Tidball', 'Animation');")
dbExecute(con, "INSERT INTO team_members (id, name, team) VALUES('105','Rachel Lee', 'Rigging');")
dbExecute(con, "INSERT INTO team_members (id, name, team) VALUES('106','Pauline Murphy', 'Rigging');")
dbExecute(con, "INSERT INTO team_members (id, name, team) VALUES('107','Maureen Kelly', 'Compositing');")
dbExecute(con, "INSERT INTO team_members (id, name, team) VALUES('108','Paul Mouse', 'FX');")

dbGetQuery(con, "SELECT * from team_members;")

dbExecute(con, "INSERT INTO Tasks (id, name, status, project_name, project_phase, team_name, team_member_id) VALUES('1','colour assets', 'not started', 'Mams Old Chair', 'Asset Build', 'Modelling1', '103');")
dbExecute(con, "INSERT INTO Tasks (id, name, status, project_name, project_phase, team_name, team_member_id) VALUES('2','reference assets', 'completed', 'Mams Old Chair', 'Asset Build', 'Modelling2', '103');")
dbExecute(con, "INSERT INTO Tasks (id, name, status, project_name, project_phase, team_name, team_member_id) VALUES('3','build assets', 'not started', 'Mams Old Chair', 'Asset Build', 'Modelling1', '103');")
dbExecute(con, "INSERT INTO Tasks (id, name, status, project_name, project_phase, team_name, team_member_id) VALUES('4','final design', 'not started', 'Mams Old Chair', 'Asset Build', 'Modelling2', '103');")
dbExecute(con, "INSERT INTO Tasks (id, name, status, project_name, project_phase, team_name, team_member_id) VALUES('5','cleanup', 'not started', 'Mams Old Chair', 'Asset Build', 'Modelling1', '103');")
dbExecute(con, "INSERT INTO Tasks (id, name, status, project_name, project_phase, team_name, team_member_id) VALUES('6','rough draft', 'not started', 'Mams Old Chair', 'Asset Build', 'Modelling2', '103');")


dbGetQuery(con, "SELECT * from Tasks;")
