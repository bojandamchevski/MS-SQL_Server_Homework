create table Student(
s_id int NOT NULL,
s_fisrt_name varchar(30),
s_last_name varchar(30),
s_date_of_birth date,
s_enrolled_date date,
s_gender varchar(6),
s_national_id_number int,
s_card_number int,
primary key (s_id)
);

create table Teacher(
t_id int NOT NULL,
t_first_name varchar(30),
t_last_name varchar(30),
t_date_of_birth date,
t_academy_rank varchar(50),
t_hire_date date,
primary key (t_id)
);

create table GradeDetails(
gd_id int NOT NULL,
gd_grade_id int,
gd_achievement_type_id int,
gd_achievement_type_points int,
gd_achievement_type_max_points int,
gd_achievement_type date,
primary key (gd_id)
);

create table Course(
c_id int NOT NULL,
c_name varchar(50),
c_credit int,
c_acadeic_year date,
c_semester int,
primary key (c_id)
);

create table Grade(
g_id int NOT NULL,
g_student_id int,
g_course_id int,
g_teacher_id int,
g_grade int,
g_comment varchar(100),
g_created_date date,
primary key (g_id)
);

create table AchievementType(
at_id int NOT NULL,
at_name varchar(50),
at_description varchar(100),
at_participation_rate decimal(5,5),
primary key (at_id)
);