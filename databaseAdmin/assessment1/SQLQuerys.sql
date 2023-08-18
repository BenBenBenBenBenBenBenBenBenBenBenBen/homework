USE Referrals;

-- DELETE FROM Referral;
-- DELETE FROM surgeon;
-- DELETE FROM patient;
-- DELETE FROM healthtargeteligible;
-- DELETE FROM referrer;
-- DELETE FROM department;


SELECT concat(p.firstName, " ", p.lastName) AS "Paitent Name", s.department FROM referral r
	Inner join patient p
		ON r.patientID=p.NHI
	INNER JOIN surgeon s
		ON r.surgeonID=s.surgeonID
	Where s.department = "Cardiothoracic"
	ORDER BY p.lastName;
    
SELECT s.department, avg(DATEDIFF(r.FSADate, r.referralDate)) FROM referral r
	INNER JOIN surgeon s
		ON r.surgeonID = s.surgeonID
	GROUP BY s.department;