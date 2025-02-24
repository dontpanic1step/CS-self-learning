create table dogs as
    select "abraham" as name, "curly" as fur union
    select "belle"          , "straight"     union
    select "celly"          , "curly"        union
    select "delano"         , "curly"        union
    select "fillmore"       , "straight"     union
    select "eddie"          , "curly";
create table parents as
    select "abraham" as parent, "belle" as child union
    select "abraham"          , "celly"          union
    select "delano"           , "abraham"        union
    select "fillmore"         , "delano"         union
    select "delano"           , "eddie";