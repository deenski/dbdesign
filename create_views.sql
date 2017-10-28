CREATE VIEW `customer_info` AS
SELECT p.passID, p.first_name, p.last_name, a.Street1, a.Street2, a.City, a.State, a.Zip, p.email, p.phone_number
FROM passengers as p natural join address as a;

CREATE VIEW `ride_info` AS
SELECT rr.request_id, p.first_name, p.last_name, a.Street1, a.Street2, a.City, rr.request_time
FROM passengers as p natural join address as a natural join ride_request as rr
WHERE a.addressID = rr.pickup_address_id or a.addressID = rr.dropoff_address_id;

