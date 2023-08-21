USE Referrals;

-- DELETE FROM Referral;
-- DELETE FROM surgeon;
-- DELETE FROM patient;
-- DELETE FROM healthtargeteligible;
-- DELETE FROM referrer;
-- DELETE FROM department;


SELECT count(s.department) FROM referral r
	INNER JOIN surgeon s
		ON r.surgeonID=s.surgeonID
	Where s.department = "Cardiothoracic";
    
SELECT s.department, avg(DATEDIFF(r.FSADate, r.referralDate)) FROM referral r
	INNER JOIN surgeon s
		ON r.surgeonID = s.surgeonID
	GROUP BY s.department;