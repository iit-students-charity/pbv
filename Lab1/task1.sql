drop table teacher;
drop table subject;
drop table student_group;
drop table teacher_student_group;

create table if not exists teacher(
    ЛичныйНомер text not null primary key,
    Фамилия text not null,
    Должность text,
    Кафедра text,
    Специальность text,
    ТелефонДомашний int
);
create table if not exists subject(
    КодовыйНомерПредмета text not null primary key,
    НазваниеПремета text not null,
    КоличествоЧасов int,
    Специальность text,
    Семестр int
);
create table if not exists student_group(
    КодовыйНомерГруппы text not null primary key,
    НазваниеГруппы text not null,
    КоличествоЧеловек int,
    Специальность text,
    ФамилияСтаросты text
);
create table if not exists teacher_student_group(
    КодовыйНомерГруппы text not null,
    КодовыйНомерПредмета text not null,
    ЛичныйНомер text not null,
    НомерАудитории int,
    primary key (КодовыйНомерГруппы, КодовыйНомерПредмета, ЛичныйНомер)
);

insert into teacher (ЛичныйНомер, Фамилия, Должность, Кафедра, Специальность, ТелефонДомашний) values
('221Л', 'Фролов', 'Доцент', 'ЭВМ', 'АСОИ, ЭВМ', 487),
('222Л', 'Костин', 'Доцент', 'ЭВМ', 'ЭВМ', 543),
('225Л', 'Бойко', 'Профессор', 'АСУ', 'АСОИ, ЭВМ', 112),
('430Л', 'Глазов', 'Ассистент', 'ТФ', 'СД', 421),
('110Л', 'Петров', 'Ассистент', 'Экономики', 'Международная экономика', 324);
insert into subject (КодовыйНомерПредмета, НазваниеПремета, КоличествоЧасов, Специальность, Семестр) values
('12П', 'Мини ЭВМ', 36, 'ЭВМ', 1),
('14П', 'ПЭВМ', 72, 'ЭВМ', 2),
('17П', 'СУБД ПК', 48, 'АСОИ', 4),
('18П', 'ВКСС', 52, 'АСОИ', 6),
('34П', 'Физика', 30, 'СД', 6),
('22П', 'Аудит', 24, 'Бухучёта', 3);
insert into student_group (КодовыйНомерГруппы, НазваниеГруппы, КоличествоЧеловек, Специальность, ФамилияСтаросты) values
('8Г', 'Э-12', 18, 'ЭВМ', 'Иванова'),
('7Г', 'Э-15', 22, 'ЭВМ', 'Сеткин'),
('4Г', 'АС-9', 24, 'АСОИ', 'Балабанов'),
('3Г', 'АС-8', 20, 'АСОИ', 'Чижов'),
('17Г', 'С-14', 29, 'СД', 'Амросов'),
('12Г', 'М-6', 16, 'Международная экономика', 'Трубин'),
('10Г', 'Б-4', 21, 'Бухучёт', 'Зязюткин');
insert into teacher_student_group (КодовыйНомерГруппы, КодовыйНомерПредмета, ЛичныйНомер, НомерАудитории) values
('8Г', '12П', '222Л', 112),
('8Г', '14П', '221Л', 220),
('8Г', '17П', '222Л', 112),
('7Г', '14П', '221Л', 220),
('7Г', '17П', '222Л', 241),
('7Г', '18П', '225Л', 210),
('4Г', '12П', '222Л', 112),
('4Г', '18П', '225Л', 210),
('3Г', '12П', '222Л', 112),
('3Г', '17П', '221Л', 241),
('3Г', '18П', '225Л', 210),
('17Г', '12П', '222Л', 112),
('17Г', '22П', '110Л', 220),
('17Г', '34П', '430Л', 118),
('12Г', '12П', '222Л', 112),
('12Г', '22П', '110Л', 210),
('10Г', '12П', '222Л', 210),
('10Г', '22П', '110Л', 210);

\echo 1 -- Получить полную информацию обо всех преподавателях.
select * from teacher;

\echo 2 -- Получить полную информацию обо всех студенческих группах на специальности ЭВМ.
select * from student_group
    where Специальность = 'ЭВМ';

\echo 3 -- Получить личный номер преподавателя и номера аудиторий, в которых они преподают предмет с кодовым номером 18П.
select distinct ЛичныйНомер, НомерАудитории from teacher_student_group
    where КодовыйНомерПредмета = '18П';

\echo 4 -- Получить  номера предметов и названия предметов, которые ведет преподаватель Костин.
select distinct s.КодовыйНомерПредмета, s.НазваниеПремета from subject s
    join teacher_student_group tsg on tsg.КодовыйНомерПредмета = s.КодовыйНомерПредмета
    join teacher t on tsg.ЛичныйНомер = t.ЛичныйНомер
    where teacher.Фамилия = 'Костин';

\echo 5 -- Получить номер группы, в которой ведутся предметы преподавателем Фроловым.
select tsg.КодовыйНомерГруппы from teacher_student_group tsg
    join teacher on teacher.ЛичныйНомер = tsg.ЛичныйНомер
    where teacher.Фамилия = 'Фролов';

\echo 6 -- Получить информацию о предметах, которые ведутся на специальности АСОИ.
select * from subject 
    where Специальность = 'АСОИ';

\echo 7 -- Получить информацию о преподавателях, которые ведут предметы на специальности АСОИ.
select * from teacher
    where Специальность like '%АСОИ%';

\echo 8 -- Получить фамилии преподавателей, которые ведут предметы в 210 аудитории.
select Фамилия from teacher t
    join teacher_student_group tsg on  t.ЛичныйНомер = tsg.ЛичныйНомер
    where tsg.НомерАудитории = 210
    group by Фамилия;

\echo 9 -- Получить названия предметов и названия групп, которые ведут занятия в аудиториях с 100 по 200. 
select s.НазваниеПремета, sg.НазваниеГруппы from teacher_student_group tsg
    join subject s on tsg.КодовыйНомерПредмета = s.КодовыйНомерПредмета
    join student_group sg on tsg.КодовыйНомерГруппы = sg.КодовыйНомерГруппы
    where tsg.НомерАудитории > 100 and tsg.НомерАудитории < 200;

\echo 10 -- Получить пары номеров групп с одной специальности.
select sg1.КодовыйНомерГруппы, sg2.КодовыйНомерГруппы from student_group sg1
    join student_group sg2 on sg1.Специальность = sg2.Специальность
    and sg1.КодовыйНомерГруппы != sg2.КодовыйНомерГруппы;

\echo 11 -- Получить общее количество студентов, обучающихся на специальности ЭВМ.
select sum(КоличествоЧеловек) СтудентовНаЭВМ from student_group
    where Специальность = 'ЭВМ';

\echo 12 -- Получить номера преподавателей, обучающих студентов по специальности ЭВМ.
select ЛичныйНомер from teacher
    where Специальность like '%ЭВМ%';

\echo 13 -- Получить номера предметов, изучаемых всеми студенческими группами.
select distinct КодовыйНомерПредмета from teacher_student_group;

\echo 14 -- Получить фамилии преподавателей, преподающих те же предметы, что и преподаватель преподающий предмет с номером 14П.
select Фамилия from teacher t
    join teacher_student_group tsp on t.ЛичныйНомер = tsp.ЛичныйНомер
    where КодовыйНомерПредмета in (
        select КодовыйНомерПредмета from teacher_student_group
        where ЛичныйНомер in (
	    select ЛичныйНомер from teacher_student_group
	    where КодовыйНомерПредмета = '14П'
	)
    )
    group by Фамилия;

\echo 15 -- Получить информацию о предметах, которые не ведет преподаватель с личным номером 221Л.
select * from subject
    where КодовыйНомерПредмета not in (
        select КодовыйНомерПредмета from teacher_student_group
        where ЛичныйНомер = '221Л'
        group by КодовыйНомерПредмета
    );

\echo 16 -- Получить информацию о предметах, которые не изучаются в группе М-6.
select * from subject
    where КодовыйНомерПредмета not in (
	select distinct КодовыйНомерПредмета from teacher_student_group tsg
	    join student_group sg on tsg.КодовыйНомерГруппы = sg.КодовыйНомерГруппы
	    where sg.НазваниеГруппы = 'М-6'
    );

\echo 17 -- Получить информацию о доцентах, преподающих в группах 3Г и 8Г.
select * from teacher
    where Должность = 'Доцент'
    and ЛичныйНомер in (
        select ЛичныйНомер from teacher_student_group
	    where КодовыйНомерГруппы = '3Г'
    )
    and ЛичныйНомер in (
        select ЛичныйНомер from teacher_student_group
	    where КодовыйНомерГруппы = '8Г'
    );

\echo 18 -- Получить номера предметов, номера преподавателей, номера групп, в которых ведут занятия преподаватели с кафедры ЭВМ, имеющих специальность АСОИ.
select КодовыйНомерПредмета, ЛичныйНомер, КодовыйНомерГруппы from teacher_student_group
    where ЛичныйНомер in (
        select ЛичныйНомер from teacher
	    where Кафедра = 'ЭВМ'
	    and Специальность like '%АСОИ%'
    );

\echo 19 -- Получить номера групп с такой же специальностью, что и специальность преподавателей.
select distinct sg.КодовыйНомерГруппы from student_group sg
    join teacher_student_group tsg on sg.КодовыйНомерГруппы = tsg.КодовыйНомерГруппы
    join (select ЛичныйНомер, unnest(string_to_array(Специальность, ', ')) Специальность from teacher) t
        on tsg.ЛичныйНомер = t.ЛичныйНомер
    where sg.Специальность = t.Специальность;

\echo 20 -- Получить номера преподавателей с кафедры ЭВМ, преподающих предметы по специальности, совпадающей со специальностью студенческой группы.
select distinct t.ЛичныйНомер from teacher t
    join teacher_student_group tsg on t.ЛичныйНомер = tsg.ЛичныйНомер
    join student_group sg on tsg.КодовыйНомерГруппы = sg.КодовыйНомерГруппы
    join subject s on tsg.КодовыйНомерПредмета = s.КодовыйНомерПредмета
    where t.Кафедра = 'ЭВМ'
    and s.Специальность = sg.Специальность;

\echo 21 -- Получить специальности студенческой группы, на которых работают преподаватели кафедры АСУ.
select distinct sg.Специальность from student_group sg
    join teacher_student_group tsg on sg.КодовыйНомерГруппы = tsg.КодовыйНомерГруппы
    join teacher t on tsg.ЛичныйНомер = t.ЛичныйНомер
    where t.Кафедра = 'АСУ';

\echo 22 -- Получить номера предметов, изучаемых группой АС-8.
select s.КодовыйНомерПредмета from subject s
    join teacher_student_group tsg on s.КодовыйНомерПредмета = tsg.КодовыйНомерПредмета
    join student_group sg on tsg.КодовыйНомерГруппы = sg.КодовыйНомерГруппы
    where sg.НазваниеГруппы = 'АС-8';

\echo 23 -- Получить номера студенческих групп, которые изучают те же предметы, что и студенческая группа АС-8.
with as8_subj as (
        select distinct КодовыйНомерПредмета from teacher_student_group tsg
	    join student_group sg on sg.КодовыйНомерГруппы = tsg.КодовыйНомерГруппы
	    where sg.НазваниеГруппы = 'АС-8'
    )
select distinct tsg.КодовыйНомерГруппы from teacher_student_group tsg
    join student_group sg on tsg.КодовыйНомерГруппы = sg.КодовыйНомерГруппы
    where НазваниеГруппы != 'АС-8'
    and КодовыйНомерПредмета in (select * from as8_subj)
    group by tsg.КодовыйНомерГруппы
    having count(distinct КодовыйНомерПредмета) >= (
        select count(*) from as8_subj
    );

\echo 24 -- Получить номера студенческих групп, которые не изучают предметы, преподаваемых в студенческой группе АС-8.
with as8_subj as (
        select distinct КодовыйНомерПредмета from teacher_student_group tsg
	    join student_group sg on sg.КодовыйНомерГруппы = tsg.КодовыйНомерГруппы
	    where sg.НазваниеГруппы = 'АС-8'
    )
select distinct КодовыйНомерГруппы from teacher_student_group
    where КодовыйНомерГруппы not in (
        select КодовыйНомерГруппы from teacher_student_group
	    where КодовыйНомерПредмета in (select * from as8_subj)
    );

\echo 25 -- Получить номера студенческих групп, которые не изучают предметы, преподаваемых преподавателем 430Л.
with "430L_subj" as (
        select distinct КодовыйНомерПредмета from teacher_student_group
	    where ЛичныйНомер = '430Л'
    )
select distinct КодовыйНомерГруппы from teacher_student_group
    where КодовыйНомерГруппы not in (
        select КодовыйНомерГруппы from teacher_student_group
	    where КодовыйНомерПредмета in (select * from "430L_subj")
    );


\echo 26 -- Получить номера преподавателей, работающих с группой Э-15, но не преподающих предмет 12П.
with teaches_12P as (
	select distinct ЛичныйНомер from teacher_student_group
	    where КодовыйНомерПредмета = '12П'
    )
select distinct ЛичныйНомер from teacher_student_group
    where КодовыйНомерГруппы in (
	select КодовыйНомерГруппы from student_group
	    where НазваниеГруппы = 'Э-15'
    )
    and ЛичныйНомер not in (select * from teaches_12P);

