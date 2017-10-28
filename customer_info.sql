SELECT p.passID, p.first_name, p.last_name, a.Street1, a.Street2, a.City, a.State, a.Zip
FROM passengers as p natural join address as a;