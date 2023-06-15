Select * 
from Projects.dbo.mxmh_survey_results;
-- Comment 
--- Results

--------------------------------------------------------------------------------------------------------------------------
-- Handle Null Values
-- Age (Replace with the average age)
-- Music_effects (Replace with 'Not Stated')
-- Change Datatype of Col ANXIETY, DEPRESSION, INSOMNIA, OCD

SELECT avg(age)
FROM projects.dbo.mxmh_survey_results;

-- Create alternate table to clean
Drop table if exists Music_therapy_temp

SELECT *, 
	Coalesce(age, 25) as Complete_age, 
	COALESCE(music_effects, 'Not stated') as Completed_music_effects, 
	CAST(anxiety as int) corrected_anxiety,
	CAST(Depression as int) corrected_depression, 
	CAST(Insomnia as int) corrected_insomnia, 
	CAST(OCD as int) corrected_ocd,
		CASE 
		WHEN Coalesce(age, 25) < 18 then 'Under 18'
		WHEN Coalesce(age, 25) between 18 and 25 then 'Young Adult'
		WHEN Coalesce(age, 25) between 26 and 50 then 'Adult'
		WHEN Coalesce(age, 25) > 50 then 'Veteran'
		END
		As age_ranges
INTO Music_therapy_temp
FROM Projects.dbo.mxmh_survey_results;

Select * 
from Music_therapy_temp;

-- Drop unwanted columns
alter table Music_therapy_temp
Drop column age, anxiety, depression, insomnia, ocd, permissions, music_effects;

--------------------------------------------------------------------------------------------------------------------------
							--			 EDA
	-- Maximum age and minimum age surveyed
	Select max(complete_age) 
	from Music_therapy_temp;
	--- 89

	Select min(complete_age) 
	from Music_therapy_temp;
	--- 10

--------------------------------------------------------------------------------------------------------------------------
-- Count of ages. Lets see the ages of people surveyed

	Select complete_age, count(Complete_age) no_per_age
	from Music_therapy_temp
	group by Complete_age
	order by 2 desc;
--- Mostly 17 - 30 year olds 

--------------------------------------------------------------------------------------------------------------------------
-- Most used streaming service by people surveyed

	Select Primary_streaming_service, COUNT(Primary_streaming_service)
	From Music_therapy_temp
	group by Primary_streaming_service
	order by 2 desc;
--- Spotify by far. Followed by Youtube Music

--------------------------------------------------------------------------------------------------------------------------
-- Most used Streaming Service by age. Use age range too
	
	Select Complete_age, Primary_streaming_service,
	COUNT(Primary_streaming_service) as streaming_count
	from Music_therapy_temp
	group by Complete_age, Primary_streaming_service
	order by 1, 3 desc;

	-- Age Ranges

	Select age_ranges, Primary_streaming_service,
	COUNT(Primary_streaming_service) streaming_count
	from Music_therapy_temp
	group by age_ranges, Primary_streaming_service
	order by 3 desc;


--------------------------------------------------------------------------------------------------------------------------
-- Hours spent per day listening to music. Lets use the age range here
	Select age_ranges, Count(Hours_per_day) Hours_spent
	from Music_therapy_temp
	group by age_ranges
	order by 2 desc;
	--- Young Adults (ages 18 - 25) spend the most hours

	-- Hours per day per individual ages
	Select Complete_age, Count(Hours_per_day) Hours_spent
	from Music_therapy_temp
	group by Complete_age
	order by 2 desc;
	--- 18year olds spend the most hours

--------------------------------------------------------------------------------------------------------------------------
	-- Lets check among those surveyed for those with musical backgrounds either Instrumentalist or Composer

	select *,
	COUNT(*) as num_musical_bg
	from
	(select *,
	case 
	when instrumentalist = 'Yes' OR composer = 'Yes' then 'Yes'
	else 'No'
	end as music_background
	from Music_therapy_temp) subquery
	where subquery.music_background = 'Yes';
	--- Only 269 people out of 736 surveyed meet this requirement

	-- Most common diagnosis of mental state
	
	Select *
	from 
		(select 
		Sum(Case 
		when corrected_anxiety > 0 then 1
		else 0 end) as Sum_anxiety,
		Sum(Case
		when corrected_depression > 0 then 1
		else 0
		end) as sum_Depression,
		Sum(Case
		when corrected_insomnia > 0 then 1
		else 0
		end) as sum_Insomnia,
		sum(Case
		when corrected_ocd > 0 then 1
		else 0
	end) as sum_OCD
		from Music_therapy_temp) mental_state
	--group by mental_state.OCD, mental_state.Anxiety, mental_state.Depression, mental_state.Insomnia
	--order by 2 desc;
	--- Anxiety(701) is the most common

	-- Mental Health state of people with musical background
	
	select sum(Sum_anxiety) #anxiety_no_Mb, 
	sum(sum_Depression) #depression_no_Mb, 
	sum(sum_Insomnia)#insomnia_no_Mb, 
	sum(sum_OCD) #ocd_no_Mb
	from
	(select 
		case 
		when coalesce(instrumentalist, 'Not Stated') = 'Yes' OR Coalesce(composer, 'Not Stated') = 'Yes' 
		then 'Yes'
		else 'No'
		end as music_background,
		Sum(
			Case 
			when 
			corrected_anxiety > 0 then 1
			else 0 
			end) as Sum_anxiety,
		Sum(
			Case
			when corrected_depression > 0 
			then 1
			else 0
			end) as sum_Depression,
		Sum(
			Case
			when corrected_insomnia > 0 then 1
			else 0
			end) as sum_Insomnia,
		Sum(
			Case
			when corrected_ocd > 0 then 1
			else 0
			end) as sum_OCD
			from Music_therapy_temp
		group by instrumentalist, composer) subquery
	where subquery.music_background = 'Yes'
	;
	--- Anxiety(256) is the most common among Surveyed people with musical background

	-- Lets look at the same query for Non-Musical Background
	
	select 
		sum(Sum_anxiety) #anxiety_no_Mb, 
		sum(sum_Depression) #depression_no_Mb, 
		sum(sum_Insomnia)#insomnia_no_Mb, 
		sum(sum_OCD) #ocd_no_Mb
	from
		(select case 
		when coalesce(instrumentalist, 'Not Stated') = 'Yes' OR Coalesce(composer, 'Not Stated') = 'Yes' 
		then 'Yes'
		else 'No'
		end as music_background,
		Sum(
			Case 
			when corrected_anxiety > 0 then 1
			else 0 end) as Sum_anxiety,
		Sum(
			Case
			when corrected_depression > 0 then 1
			else 0
			end) as sum_Depression,
		Sum(
			Case
			when corrected_insomnia > 0 then 1
			else 0
			end) as sum_Insomnia,
		Sum(
			Case
			when corrected_ocd > 0 then 1
			else 0
			end) as sum_OCD
		from Music_therapy_temp
	group by instrumentalist, composer) subquery
	where subquery.music_background = 'No'
	;
--- Anxiety (445) is also the highest here

--------------------------------------------------------------------------------------------------------------------------
-- Lets look at Hours spent for those with extreme Mental Health Cases. Ranking from 8 and above


	WITH cte1 
	AS
	(
	Select *
	FROM
		(
		 Select *, 
		Case 
			when corrected_anxiety >= 8 then 'Anxiety_extreme'
			when corrected_depression >= 8 then 'Depression_extreme'
			when corrected_insomnia >= 8 then 'Insomnia_extreme'
			when corrected_ocd >= 8 then 'OCD_extreme'
			end as Mental_health_extreme,

-- Low MH 3 or below
		Case 
			when corrected_anxiety <= 3  then 'Anxiety_low'
			when corrected_depression <= 3 then 'Depression_low'
			when corrected_insomnia <= 3 then 'Insomnia_low'
			when corrected_ocd <= 3 then 'OCD_low'
			end as Mental_health_low,

-- Mid MH  4 - 7
		Case
			when corrected_anxiety  between 4 and 7  then 'Anxiety_mid'
			when corrected_depression  between 4 and 7 then 'Depression_mid'
			when corrected_insomnia  between 4 and 7 then 'Insomnia_mid'
			when corrected_ocd between 4 and 7 then 'OCD_mid'
			end as Mental_health_mid,

--No MH. They must have 0 in all respects
		Case
			when corrected_anxiety = 0  
			and corrected_depression = 0 and corrected_insomnia = 0 
			and corrected_ocd = 0 then 'None'
			end as Good_mental_state
			from Music_therapy_temp)as subquery)

	SELECT CAST(AVG(Hours_per_day) as dec(4,2)) avg_hours_spent_extreme_mh, Mental_health_extreme
	from cte1
	where Mental_health_extreme is not null
	group by Mental_health_extreme
	order by 1 desc;
	--- People that self diagnosed extreme Insomnia spent more hours(4. on avg) listening to music

	-- Same Query but for Low MH
	with cte3 as
	(
		Select *
		from
		(
		 Select *, 
	Case 
		when corrected_anxiety >= 8 then 'Anxiety_extreme'
		when corrected_depression >= 8 then 'Depression_extreme'
		when corrected_insomnia >= 8 then 'Insomnia_extreme'
		when corrected_ocd >= 8 then 'OCD_extreme'
		end as Mental_health_extreme,

		Case 
		when corrected_anxiety <= 3  then 'Anxiety_low'
		when corrected_depression <= 3 then 'Depression_low'
		when corrected_insomnia <= 3 then 'Insomnia_low'
		when corrected_ocd <= 3 then 'OCD_low'
		end as Mental_health_low,

		Case
		when corrected_anxiety  between 4 and 7  then 'Anxiety_mid'
		when corrected_depression  between 4 and 7 then 'Depression_mid'
		when corrected_insomnia  between 4 and 7 then 'Insomnia_mid'
		when corrected_ocd between 4 and 7 then 'OCD_mid'
		end as Mental_health_mid,

		Case
		when corrected_anxiety = 0  
		and corrected_depression = 0 and corrected_insomnia = 0 
		and corrected_ocd = 0 then 'None'
		end as Good_mental_state
		from Music_therapy_temp)as subquery)

		select cast(avg(Hours_per_day) as dec(4,1)) avg_hours_spent_low_mh, Mental_health_low
		from cte3
		where Mental_health_low is not null
		group by Mental_health_low
		order by 1 desc;
	--- People that Self-diagnosed OCD of 3 or lower spent more time (3.7 on avg) listening to music
	
	-- Same Query for Mid Level
	with cte3 as
	(
		Select *
		from
		(
		 Select *, 
	Case 
		when corrected_anxiety >= 8 then 'Anxiety_extreme'
		when corrected_depression >= 8 then 'Depression_extreme'
		when corrected_insomnia >= 8 then 'Insomnia_extreme'
		when corrected_ocd >= 8 then 'OCD_extreme'
		end as Mental_health_extreme,

		Case 
		when corrected_anxiety <= 3  then 'Anxiety_low'
		when corrected_depression <= 3 then 'Depression_low'
		when corrected_insomnia <= 3 then 'Insomnia_low'
		when corrected_ocd <= 3 then 'OCD_low'
		end as Mental_health_low,

		Case
		when corrected_anxiety  between 4 and 7  then 'Anxiety_mid'
		when corrected_depression  between 4 and 7 then 'Depression_mid'
		when corrected_insomnia  between 4 and 7 then 'Insomnia_mid'
		when corrected_ocd between 4 and 7 then 'OCD_mid'
		end as Mental_health_mid,

		Case
		when corrected_anxiety = 0  
		and corrected_depression = 0 
		and corrected_insomnia = 0 
		and corrected_ocd = 0 then 'None'
		end as Good_mental_state
		from Music_therapy_temp)as subquery)

		select cast(avg(Hours_per_day) as dec(4,1)) avg_hours_spent_mid_mh, Mental_health_mid
		from cte3
		where Mental_health_mid is not null
		group by Mental_health_mid
		order by 1 desc;
	--- People that Self-diagnosed OCD between 4 to 7 spent more time (4.1 on avg) listening to music

	-- Query for those with a good mental state
	with cte3 as
	(
		Select *
		from
		(
		 Select *, 
	Case 
		when corrected_anxiety >= 8 then 'Anxiety_extreme'
		when corrected_depression >= 8 then 'Depression_extreme'
		when corrected_insomnia >= 8 then 'Insomnia_extreme'
		when corrected_ocd >= 8 then 'OCD_extreme'
		end as Mental_health_extreme,

		Case 
		when corrected_anxiety <= 3  then 'Anxiety_low'
		when corrected_depression <= 3 then 'Depression_low'
		when corrected_insomnia <= 3 then 'Insomnia_low'
		when corrected_ocd <= 3 then 'OCD_low'
		end as Mental_health_low,

		Case
		when corrected_anxiety  between 4 and 7  then 'Anxiety_mid'
		when corrected_depression  between 4 and 7 then 'Depression_mid'
		when corrected_insomnia  between 4 and 7 then 'Insomnia_mid'
		when corrected_ocd between 4 and 7 then 'OCD_mid'
		end as Mental_health_mid,

		Case
		when corrected_anxiety = 0  
		and corrected_depression = 0 and corrected_insomnia = 0 
		and corrected_ocd = 0 then 'None'
		end as Good_mental_state
		from Music_therapy_temp)as subquery)

		select cast(avg(Hours_per_day) as dec(4,1)) avg_hours_spent_extreme_mh, Good_mental_state
		from cte3
		where Good_mental_state is not null
		group by Good_mental_state
		order by 1 desc;

--------------------------------------------------------------------------------------------------------------------------
					-- Focus on Genre
			--Fav Genre

		Select Fav_genre, COUNT(Fav_genre) no_of_fav_genre
		from Music_therapy_temp
		---where complete_age = 18
		group by Fav_genre
		order by 2 desc;
		--- Rock

			-- Fav genre by age
	SELECT Complete_age, Fav_genre, 
		COUNT(Fav_genre) fav_genre_by_age, 
		COUNT(Fav_genre) over (partition by fav_genre) num_diversity
	FROM Music_therapy_temp
	GROUP BY Complete_age, Fav_genre
	ORDER BY 4 DESC, 3 DESC, 1;
	--- Rock is the most diverse (IN 46 DIFFERENT INDIVIDUAL AGES) Followed by Pop(27 different individual ages)

--------------------------------------------------------------------------------------------------------------------------
	-- Music Effect per Genre
	Select Fav_genre, Completed_music_effects, COUNT(*)
	from Music_therapy_temp
	group by Fav_genre, Completed_music_effects
	order by 1;

--------------------------------------------------------------------------------------------------------------------------
	-- BPM per favorite genre
	-- Lets make it a range so Min - Max per Fav_genre
	----Noticing some outrageous numbers like 624, 9999999, e.t.c so lets filter them out
	

	WITH cte5 
	AS
		(Select *
		FROM 
	(
		Select Fav_genre, 
		bpm, 
		min(bpm) over (partition by fav_genre) Lowest_bpm_per_genre, 
		max(bpm) over (partition by fav_genre) Highest_bpm_per_genre 
		from Music_therapy_temp
		where bpm is not null and bpm > 20 and bpm < 500
		group by Fav_genre, BPM) subquery)
	
	SELECT DISTINCT Fav_genre, CONCAT(Lowest_bpm_per_genre, ' - ', Highest_bpm_per_genre)as bpm_range
	FROM cte5;
	
--------------------------------------------------------------------------------------------------------------------------
		-- Fav genre of Highest and Lowest MH scorers

	-- 60 ranked Lowest MH scorers
	
	WITH cte7
	AS
	(
		SELECT *, row_number() over (order by added_sum asc) AS rank
		FROM
	(
		SELECT fav_genre, corrected_anxiety, corrected_depression, corrected_insomnia, corrected_ocd,
		(corrected_anxiety + corrected_depression + corrected_insomnia + corrected_ocd) AS added_sum
	FROM Music_therapy_temp) subquery
	group by Fav_genre, corrected_anxiety, corrected_depression, corrected_insomnia, corrected_ocd, added_sum
	)
	
	SELECT Fav_genre, added_sum,
			count(rank) over (partition by fav_genre)num_fav_genre
	FROM cte7
	WHERE rank <=60;
	--- Rock was the most listened
	

	-- Highest MH Scorers

	WITH cte8
	AS
	(
		Select *,row_number() over ( order by added_sum desc) rank
		from
	(
		Select fav_genre, corrected_anxiety, corrected_depression, corrected_insomnia, corrected_ocd,
					(corrected_anxiety + corrected_depression + corrected_insomnia + corrected_ocd) AS added_sum
		FROM Music_therapy_temp) subquery
		GROUP BY Fav_genre, corrected_anxiety, corrected_depression, corrected_insomnia, corrected_ocd, added_sum
	)
	SELECT Fav_genre, added_sum, count(rank) over (partition by fav_genre)num_fav_genre
	FROM cte8
	where rank <=60;
	--- Rock by 16 people
	
	