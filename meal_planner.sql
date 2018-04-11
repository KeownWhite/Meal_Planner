-- Name: Keown White
-- ID num: 620052848

DROP DATABASE IF EXISTS meal_planner;
CREATE DATABASE meal_planner;
use meal_planner;

create table account(
  username varchar(255),
  pword varchar(255),
  primary key(username)
);

create table user_profile(
  profile_id int auto_increment not null,
  username varchar(255) not null,
  fname varchar(255),
  lname varchar(255),
  dob DATE,
  email varchar(320),
  diet_choice varchar(50),
  primary key(profile_id),
  unique key(email),
  foreign key(username) references account(username) on delete cascade on update cascade
);

create table contructs(
  profile_id int,
  plan_id int,
  primary key(plan_id, profile_id),
  foreign key(profile_id) references user_profile(profile_id) on delete cascade on update cascade
  -- foreign key(plan_id) references meal_plan(plan_id) on delete cascade on update cascade
);
set @@foreign_key_checks=0;
ALTER TABLE  `contructs` ADD CONSTRAINT `plan_id` FOREIGN KEY (`plan_id`) REFERENCES `meal_plan` (`plan_id`) ON DELETE CASCADE;

create table meal_plan(
  plan_id int auto_increment not NULL,
  week date,
  primary key(plan_id)
);

create table illness(
  illness_id int auto_increment not NULL,
  illness_type varchar(20),
  primary key(illness_id)
);
create table profile_illnesses(
  profile_id int,
  illness_id int,
  primary key(profile_id),
  foreign key(profile_id) references user_profile(profile_id) on delete cascade on update cascade

);

create table ingredients(
  ingredients_id int auto_increment not null,
  ingredients_name varchar(20),
  food_groups varchar(300),
  measuring_unit varchar(20),
  primary key(ingredients_id)
);
create table kitchen(
    kitchen_id int auto_increment not null,
    profile_id int,
    -- ingredients_id int,
    primary key(kitchen_id),
    foreign key(profile_id) references user_profile(profile_id) on delete cascade on update cascade
    -- foreign key(ingredients_id) references ingredients(ingredients_id) on delete cascade on update cascade
);

create table contain(
  kitchen_id int,
  ingredients_id int,
  quantity VARCHAR (20),
  primary key(ingredients_id, kitchen_id),
  foreign key(ingredients_id) references ingredients(ingredients_id) on delete cascade on update cascade,
  foreign key(kitchen_id) references kitchen(kitchen_id) on delete cascade on update cascade
);

create table recipes(
  recipe_id int auto_increment not null,
  recipe_name varchar(300),
  servings int,
  prep_time_amt int,
  hour_or_mins varchar(20),
  recipe_type varchar(20),
  recipe_diet_type varchar(100),
  calories int,
  recipe_img varchar(300),
  primary key(recipe_id)
);

create table instructions(
    instructions_id int auto_increment not null,
    recipe_id int,
    direction varchar(100),
    primary key(instructions_id),
    foreign key(recipe_id) references recipes(recipe_id) on delete cascade on update cascade
);
create table comprise(
  recipe_id int auto_increment not null,
  ingredients_id int,
  recipe_qunt varchar(20),
  primary key(recipe_id,ingredients_id),
  foreign key(recipe_id) references recipes(recipe_id) on delete cascade on update cascade,
  foreign key(ingredients_id) references ingredients(ingredients_id) on delete cascade on update cascade
);


create table add_recipe(
  username varchar(20),
  recipe_id int auto_increment not null,
  creation_date Date,
  primary key(username),
  foreign key(username) references user_profile(username) on delete cascade on update cascade,
  foreign key(recipe_id) references recipes(recipe_id) on delete cascade on update cascade

);

create table meals(
    meal_id int auto_increment not null,
    meal_name varchar(100),
    meal_type varchar(20),
    calories int,
    primary key(meal_id)
);
create table creates(
    meal_id int,
    recipe_id int,
    primary key(meal_id, recipe_id),
    foreign key(meal_id) references meals(meal_id) on delete cascade on update cascade,
    foreign key(recipe_id) references recipes(recipe_id) on delete cascade on update cascade
);

create table meal_plan(
    plan_id int,
    meal_id int,
    primary key(meal_id, plan_id),
    foreign key(meal_id) references meals(meal_id) on delete cascade on update cascade,
    foreign key(plan_id) references meal_plan(plan_id) on delete cascade on update cascade
);


-- -- create table determines(
-- --     plan_id,
-- --     item_id
-- -- );
