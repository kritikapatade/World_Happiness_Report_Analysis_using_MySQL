/*Show top 5 countries that have high latest positive affects
and where freedom to make life choices is backed by good social support*/
with latest_records as (
	select * from (
	select *,row_number() over (partition by `ï»¿Country name` order by year desc) as row_num from `world-happiness-report`
	)t1 where row_num=1
)
select `ï»¿Country name`,`Social support`,`Freedom to make life choices`,`Positive affect`
from latest_records
where `Social support`>0.8 and `Freedom to make life choices`>0.8 order by `Positive affect` desc limit 5;

/*Examine correlation between GDP of countries and perceptions of corruption*/
with latest_records as (
	select * from (
	select *,row_number() over (partition by `ï»¿Country name` order by year desc) as row_num from `world-happiness-report`
	)t1 where row_num=1
),
processed_gdp as (
select *, cast(`Log GDP per capita` as signed) as gdp_int from latest_records
)
select `ï»¿Country name`,`Log GDP per capita`,gdp_int,`Perceptions of corruption` from (
	select *,row_number() over (partition by gdp_int order by `Perceptions of corruption` desc) as rn
	from processed_gdp
)t1 where rn=1 order by `Log GDP per capita` desc;
