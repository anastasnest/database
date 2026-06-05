USE `ics0012_anesterova_MiniInsta` ;

-- --------------------------------------------------------
-- Front page query (posts by the people I follow, number of
-- likes for each post)
-- --------------------------------------------------------

SET @userID = 6; -- @userID = 6 can show counting of multible likes 

select p.ID as PostID, u.Username, p.CreationTime, pm.MediaTypeID, pm.MediaFileUrl, count(l.UserID) as NumberOfLikes from Following f
join User u on f.FolloweeUserID = u.ID
join Post p on p.UserID = u.ID
left join PostMedia pm on pm.PostID = p.ID
left join Liking l on l.PostID = p.ID
where f.FollowerUserID = @userID
group by p.ID, u.Username, p.CreationTime, pm.MediaTypeID, pm.MediaFileUrl;
 
-- --------------------------------------------------------
-- Profile page
-- Main portion: header with username, profile image, # of posts,
-- # of followers, # of followings, bio
-- Posts by this user in cronologically descending order, 
-- including one media file and # of total media files
-- --------------------------------------------------------
SET @Username = 'cbaccup3b';

select u.ID as UserID, u.Username, u.Website, u.Bio, u.ProfileImageUrl, count(distinct p.ID) as NumberOfPosts, count(distinct f1.FolloweeUserID) as NumberOfFollowers, count(distinct f2.FollowerUserID) as NumberOfFollowedUsers from User u
left join Post p on p.UserID = u.ID
left join Following f1 on f1.FollowerUserID = u.ID 
left join Following f2 on f2.FolloweeUserID = u.ID
where u.Username = @Username
group by u.ID;

select p.ID as PostID, p.LocationName, mt.Name as MediaType, pm.MediaFileUrl from User u
join Post p on p.UserID = u.ID
left join PostMedia pm on pm.PostID = p.ID
left join MediaType mt on mt.ID = pm.MediaTypeID
where u.Username = @Username 
order by p.CreationTime DESC;

-- --------------------------------------------------------
-- Post details
-- Main query: header info (username, profile picture, # of likes)
-- Media files
-- Comments
-- --------------------------------------------------------
SET @PostID = 74; -- @PostID = 207  shows that it can count

select p.ID as PostID, u.Username, u.ProfileImageUrl, p.LocationName, p.Location, count(l.UserID) as NumberOfLikes from Post p
join User u on u.ID = p.UserID
left join Liking l on l.PostID = p.ID
where p.ID = @PostID
group by p.ID;

select pm.ID as PostMediaID, pm.MediaTypeID, pm.MediaFileUrl from PostMedia pm
join Post p on p.ID = pm.PostID
where p.ID = @PostID;

select c.ID as CommentID, c.Comment, c.CreationTime from Post p
join Comment c on p.ID = c.PostID
where p.ID = @PostID
order by c.CreationTime;

-- --------------------------------------------------------
-- Analytical numbers in single data set (total number of users, 
-- total number of posts, Average and max posts per user, 
-- avg and max comments per post, avg ja max likes per post
-- --------------------------------------------------------

select count(distinct u.ID) as TotalNumberOfUsers, count(distinct p.ID) as TotalNumberOfPosts, avg(PostsPerUser) as WrongAvgNumberOfPostsPerUser,
round((count(distinct p.ID) / count(distinct u.ID)), 2) as AvgNumberOfPostsPerUser, max(PostsPerUser) as  MaxNumberOfPostsPerUser, 
round(avg(LikesPerPost), 2) as AvgNumberOfLikesPerPost, max(LikesPerPost) as MaxNumberOfLikesPerPost
from User u
left join Post p on u.ID = p.UserID
left join (
    select u.ID, count(p.ID) as PostsPerUser from User u
    left join Post p on u.ID = p.UserID
    group by u.ID
) PostsCount on u.ID = PostsCount.ID
left join (
	select p.ID, count(l.UserID) as LikesPerPost from Post p
    left join Liking l on l.PostID = p.ID
    group by p.ID
) LikesCount on p.ID = LikesCount.ID;

select u.ID, count(p.ID) as PostPerUser from User u -- this query works fine but rows multiply when inserted in the main query
left join Post p on u.ID = p.UserID
group by u.ID;

select p.ID, count(l.UserID) as LikesPerUser from Post p -- this query works fine even in the main query (I don't understand why this goes fine and the previous doesn't)
left join Liking l on l.PostID = p.ID
group by p.ID;


----------------------------------------------------------
-- TOP 10 Users with most followers
----------------------------------------------------------

select u.ID as UserID, u.Username, count(f.FollowerUserID) as NumberOfFollowers from User u
join Following f on f.FolloweeUserID = u.ID
group by f.FolloweeUserID
order by count(f.FollowerUserID) desc
limit 10;

----------------------------------------------------------
-- User registration count per day
----------------------------------------------------------
update User                                 -- I changed creation times because while inserting the system automatically put the time of when insertion was happening 
set CreationTime = "2024-11-20 18:11:05"
where ID = 1;

update User                                 -- another change of time to have more examples 
set CreationTime = "2024-12-06 02:15:47"
where ID = 25 or ID = 56 or ID = 154;


select date(CreationTime) As Date, count(*) as NumberOfRegistration from User
group by date(CreationTime)
order by date(CreationTime) ASC;

----------------------------------------------------------
-- User division by gender
----------------------------------------------------------

select g.Name as GenderName, count(u.ID) as NumberOfUsers from Gender g
join User u on u.GenderID = g.ID
group by g.ID;
