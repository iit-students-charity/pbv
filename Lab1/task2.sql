\echo Вариант 7 (26|17|25|8|2|7|11|36|16|31)

drop table producer;
drop table part;
drop table project;
drop table producer_part_project;

create table if not exists producer (
    П text not null primary key,
    ИмяП text not null,
    Статус int,
    Город text
);
create table if not exists part (
    Д text not null primary key,
    ИмяД text not null,
    Цвет text,
    Размер int,
    Город text
);
create table if not exists project (
    ПР text not null primary key,
    ИмяПР text not null,
    Город text
);
create table if not exists producer_part_project (
    П text not null,
    Д text not null,
    ПР text not null,
    S int,
    primary key (П, Д, ПР)
);

insert into producer (П, ИмяП, Статус, Город) values
('П1', 'Петров', 20, 'Москва'),
('П2', 'Синицин', 10, 'Таллинн'),
('П3', 'Федоров', 30, 'Таллинн'),
('П4', 'Чаянов', 20, 'Минск'),
('П5', 'Крюков', 30, 'Киев');
insert into part (Д, ИмяД, Цвет, Размер, Город) values
('Д1', 'Болт', 'Красный', 12, 'Москва'),
('Д2', 'Гайка', 'Зелёная', 17, 'Минск'),
('Д3', 'Диск', 'Черный', 17, 'Вильнюс'),
('Д4', 'Диск', 'Черный', 14, 'Москва'),
('Д5', 'Корпус', 'Красный', 12, 'Минск'),
('Д6', 'Крышки', 'Красный', 19, 'Москва');
insert into project (ПР, ИмяПР, Город) values
('ПР1', 'ИПР1', 'Минск'),
('ПР2', 'ИПР2', 'Таллинн'),
('ПР3', 'ИПР3', 'Псков'),
('ПР4', 'ИПР4', 'Псков'),
('ПР5', 'ИПР5', 'Москва'),
('ПР6', 'ИПР6', 'Саратов'),
('ПР7', 'ИПР7', 'Москва');
insert into producer_part_project (П, Д, ПР, S) values
('П1', 'Д1', 'ПР1', 200),
('П1', 'Д1', 'ПР2', 700),
('П2', 'Д3', 'ПР1', 400),
('П2', 'Д2', 'ПР2', 200),
('П2', 'Д3', 'ПР3', 200),
('П2', 'Д3', 'ПР4', 500),
('П2', 'Д3', 'ПР5', 600),
('П2', 'Д3', 'ПР6', 400),
('П2', 'Д3', 'ПР7', 800),
('П2', 'Д5', 'ПР2', 100),
('П3', 'Д3', 'ПР1', 200),
('П3', 'Д4', 'ПР2', 500),
('П4', 'Д6', 'ПР3', 300),
('П4', 'Д6', 'ПР7', 300),
('П5', 'Д2', 'ПР2', 200),
('П5', 'Д2', 'ПР4', 100),
('П5', 'Д5', 'ПР5', 500),
('П5', 'Д5', 'ПР7', 100),
('П5', 'Д6', 'ПР2', 200),
('П5', 'Д1', 'ПР2', 100),
('П5', 'Д3', 'ПР4', 200),
('П5', 'Д4', 'ПР4', 800),
('П5', 'Д5', 'ПР4', 400),
('П5', 'Д6', 'ПР4', 500);

\echo ----SCHEMES----
select * from producer;
select * from part;
select * from project;
select * from producer_part_project;

\echo 26 -- Получить номера проектов, для которых среднее количество поставляемых деталей Д1 больше, чем наибольшее количество любых деталей, поставляемых для проекта ПР1.
select ПР from producer_part_project ppp 
    group by ПР, Д
    having Д = 'Д1'
    and avg(S) > (
        select max(S) from producer_part_project where ПР = 'ПР1'
    );

\echo 17 -- Для каждой детали, поставляемой для проекта, получить номер детали, номер проекта и соответствующее общее количество.
select Д, ПР, sum(S) from producer_part_project
    group by Д, ПР
    order by Д;

\echo 25 -- Получить номера проектов, город которых стоит первым в алфавитном списке городов.
select distinct first_value(ПР) over(order by Город) ПервыйПроект
    from project;

\echo 8 -- Получить все такие тройки "номера поставщиков-номера деталей-номера проектов", для которых никакие из двух выводимых поставщиков, деталей и проектов не размещены в одном городе.
select distinct П, Д, ПР from producer prd
    join part prt on prd.Город != prt.Город
    join project prj on prd.Город != prj.Город and prt.Город != prj.Город;

\echo 2 -- Получить полную информацию обо всех проектах в Минске.
select * from project
    where Город = 'Минск';

\echo 7 -- Получить все такие тройки "номера поставщиков-номера деталей-номера проектов", для которых выводимые поставщик, деталь и проект не размещены в одном городе.
select П, Д, ПР from producer prd, part prt, project prj
    where not(prd.Город = prt.Город
    and prd.Город = prj.Город
    and prt.Город = prj.Город);

\echo 11 -- Получить все пары названий городов, для которых поставщик из первого города обеспечивает проект во втором городе.
select distinct prd.Город ГородПоставщика, prj.Город ГородПроекта from producer_part_project ppp
    join producer prd on ppp.П = prd.П
    join project prj on ppp.ПР = prj.ПР
    order by prd.Город;

\echo 36 -- Получить все пары номеров поставщиков, скажем, Пx и Пy, такие, что оба эти поставщика поставляют в точности одно и то же множество деталей.
with not_eq as (
    select distinct p1.П П1, p2.П П2, p1.Д, p2.Д from producer_part_project p1
        join producer_part_project p2 on p1.Д != p2.Д
        where (
            select count(distinct Д) from producer_part_project where П = p1.П
        ) != (
            select count(distinct Д) from producer_part_project where П = p2.П
        )
        or (
            select count(Д) from producer_part_project
                where (Д = p1.Д and П = p2.П)
                or (Д = p2.Д and П = p1.П)
        ) = 0
    )
select distinct p1.П, p2.П from producer_part_project p1
    join producer_part_project p2 on p1.П != p2.П
    where p1.П not in (select П1 from not_eq where П2 = p2.П)
    and p2.П not in (select П2 from not_eq where П1 = p1.П);

\echo 16 -- Получить общее количество деталей Д1, поставляемых поставщиком П1.
select sum(S) КоличествоДеталейД1 from producer_part_project
    where Д = 'Д1'
    and П = 'П1';

\echo 31 -- Получить номера поставщиков, поставляющих одну и ту же деталь для всех проектов.
select П ПоставщикиС1Деталью from producer_part_project
    group by П
    having count(distinct Д) = 1;

