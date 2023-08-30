USE Referrals;

-- DELETE FROM Referral;
-- DELETE FROM surgeon;
-- DELETE FROM patient;
-- DELETE FROM healthtargeteligible;
-- DELETE FROM referrer;
-- DELETE FROM department;

SELECT count(s.department) AS "number of people referred to cardiothoracic" FROM referral r
	INNER JOIN surgeon s
		ON r.surgeonID=s.surgeonID
	Where s.department = "Cardiothoracic";
    
SELECT s.department, round(avg(DATEDIFF(r.FSADate, r.referralDate))) AS "average Days waiting" FROM referral r
	INNER JOIN surgeon s
		ON r.surgeonID = s.surgeonID
	GROUP BY s.department;
    
SELECT concat(s.firstName, " ", s.lastName) AS "surgeon name", concat(p.firstName, " ", p.lastName) AS "paitent name", dw.days
	FROM referral r
		INNER JOIN surgeon s
			ON s.surgeonID=r.surgeonID
		INNER JOIN patient p
			ON p.NHI=r.patientID
		INNER JOIN V_daysWaiting dw
			ON dw.referralID=r.referralID
		ORDER BY s.lastName;

SELECT pa.age, concat(p.firstName, " ", p.lastName) AS "paitent name", s.department FROM referral r
	INNER JOIN patient p
		ON p.NHI=r.patientID
	INNER JOIN surgeon s
		ON s.surgeonID=r.surgeonID
	INNER JOIN V_patientAge pa
		ON p.NHI=pa.NHI
    WHERE s.department="Paediatric Surgery" AND pa.age>18;
    
SELECT s.department, avg(dw.days) FROM referral r
	INNER JOIN surgeon s
		ON s.surgeonID=r.surgeonID
	INNER JOIN V_daysWaiting dw
			ON dw.referralID=r.referralID
	where (dw.days/75)<1
    GROUP BY s.department;