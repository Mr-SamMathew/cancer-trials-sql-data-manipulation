USE Practice;

SELECT *
FROM   dbo.cancer_trials_2020_2024;

--Sponsor Trial Counts: The Clinical Operations team wants to see top sponsors. Write a query to find the top 5 lead_sponsor organizations that have the highest total count of trials.
SELECT   TOP 5 lead_sponsor,
               count(lead_sponsor) AS sponsorcount
FROM     dbo.cancer_trials_2020_2024
GROUP BY lead_sponsor
ORDER BY sponsorcount DESC;

--Missing Phase Handling: Find all INTERVENTIONAL trials where phase is either NULL or marked as 'Not Specified'. Display their nct_id, study_title, and sponsor_type.
SELECT nct_id,
       study_title,
       sponsor_type,
       phase
FROM   dbo.cancer_trials_2020_2024
WHERE  phase IN (
    'NA',
    'Not Specified'
);

--Targeted Female Cancer Studies: Return all trials targeting female participants (sex = 'FEMALE') with an enrollment of more than 100 participants. Sort the results by enrollment in descending order.
SELECT   *
FROM     dbo.cancer_trials_2020_2024
WHERE    sex = 'FEMALE'
         AND enrollment > 100
ORDER BY enrollment DESC;

--Industry vs. Non-Industry Enrollment Metrics: Strategic Finance wants to compare trial size metrics across sponsor types. Write a query calculating the total enrollment, average enrollment (rounded to 2 decimal places), and maximum enrollment for each sponsor_type. Order by total enrollment descending.
SELECT   sponsor_type,
         count(sponsor_type) AS NumberofSponsors,
         sum(enrollment) AS TotalEnrollment,
         round (
             avg (enrollment),
             2
         ) AS AvgEnrollment,
         max(enrollment) AS MaxEnrollment
FROM     dbo.cancer_trials_2020_2024
GROUP BY sponsor_type
ORDER BY TotalEnrollment DESC;

--Pattern Search for Lung Cancer: The Oncology R&D division is focusing on Lung Cancer. Write a query to list all trials where conditions contains the phrase 'Lung Cancer' (case-insensitive). Return nct_id, study_title, conditions, and lead_sponsor.
SELECT *
FROM   dbo.cancer_trials_2020_2024
WHERE  conditions LIKE 'Lung Cancer';

--Multi-Intervention Flagging: Some trials involve multiple interventions separated by semicolons (e.g., 'DRUG; DEVICE'). Write a query that selects trials where intervention_types contains a semicolon (;), showing nct_id, study_type, and intervention_types.
SELECT nct_id,
       study_type,
       intervention_types
FROM   dbo.cancer_trials_2020_2024
WHERE  intervention_types LIKE '%;%';

--Overall Average Comparison (Basic Aggregation):For every trial, return the nct_id, lead_sponsor, enrollment, and show the average enrollment across the entire dataset as a separate column named overall_avg_enrollment."
SELECT nct_id,
       lead_sponsor,
       enrollment,
       avg(enrollment) OVER () AS overall_avg_enrollment
FROM   dbo.cancer_trials_2020_2024;

--Sequential Row Numbering (Basic Ranking):Generate a sequential study index (study_num) for each trial assigned by its start_date in ascending order (oldest first). Return study_num, nct_id, study_title, and start_date.
SELECT nct_id,
       study_title,
       start_date,
       rank() OVER (ORDER BY start_date ASC) AS startdates
FROM   dbo.cancer_trials_2020_2024;

--Partitioned Running Totals (Window Aggregation):Calculate a cumulative running total of participant enrollment over time (ordered by start_date) separately for each sponsor_type. Return nct_id, sponsor_type, start_date, enrollment, and running_total_enrollment.
SELECT nct_id,
       sponsor_type,
       start_date,
       enrollment,
       sum(enrollment) OVER (PARTITION BY start_date,
                                          sponsor_type) AS enrollment_spons_and_date
FROM   dbo.cancer_trials_2020_2024;

--Count the total number of studies conducted under each sponsor_type. Display the sponsor_type and its corresponding total_trials count, ordered from highest to lowest
SELECT   sponsor_type,
         count(sponsor_type) AS sponsortype_bytrials
FROM     dbo.cancer_trials_2020_2024
GROUP BY sponsor_type
ORDER BY count(sponsor_type) DESC;
