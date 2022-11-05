--1) простые запросы

select * from friends f;

select * from profile p where p.country = 'Russian';



--2) запросы с агрегацией 

select count(idComments), idUser  from comments c group by idUser;


select count(i.idItem), UserId  from inventar i group by UserId order by i.idItem asc;




--3) джоин



select i.idItem, i.UserId, i.idGame  from inventar i inner join user u on i.UserId = u.idUser ;


select f.idForum, fhu.UserId  from forum f 
inner join forum_has_user fhu on f.idForum= fhu.ForumId
inner join user u on fhu.UserId = u.idUser ; 




--4) джоин с подзапросом

select p.idProfile, count(g.idGame) from profile p 
inner join games_has_profile ghp on p.idProfile = ghp.ProfileId 
inner join games g on g.idGame = ghp.GamesId 
where (select g.idGame where g.idGame  > 30) group by g.idGame 
