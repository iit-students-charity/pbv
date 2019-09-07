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

select * from teacher;

select * from student_group
    where Специальность = 'ЭВМ';

select ЛичныйНомер, НомерАудитории from teacher_student_group
    where КодовыйНомерПредмета = '18П';

select subject.КодовыйНомерПредмета, subject.НазваниеПремета from subject
    inner join teacher_student_group pre on pre.КодовыйНомерПредмета = subject.КодовыйНомерПредмета
    inner join teacher on pre.ЛичныйНомер = teacher.ЛичныйНомер
    where teacher.Фамилия = 'Костин';

select pre.КодовыйНомерГруппы from teacher_student_group pre
    inner join teacher on teacher.ЛичныйНомер = pre.ЛичныйНомер
    where teacher.Фамилия = 'Фролов';

select * from subject 
    where Специальность like '%АСОИ%';

select teacher.Фамилия from teacher
    inner join teacher_student_group pre on  teacher.ЛичныйНомер = pre.ЛичныйНомер
    where pre.НомерАудитории = 210;

select subject.НазваниеПремета, student_group.НазваниеГруппы from teacher_student_group pre
    inner join subject on pre.КодовыйНомерПредмета = subject.КодовыйНомерПредмета
    inner join student_group on pre.КодовыйНомерГруппы = student_group.КодовыйНомерГруппы;

select 

