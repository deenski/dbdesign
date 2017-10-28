SELECT * from address;
select * from commercial_accounts;
select * from invoices;
select * from passengers;
select * from ride_request;
select * from trip;
select * from vehicles;

select distinct t.trip_id, i.invoice_id, rr.request_time, 
	p.first_name, p.last_name, a.Street1, a.Street2, 
    a.City, a.State, a.Zip, t.billable_miles,
	ca.rate, 5.00 as min_tip, round(t.billable_miles * ca.rate + 5 , 2) as balance_due 
from invoices as i 
join trip as t using(trip_id)
join ride_request as rr using(request_id)
join address as a on a.addressID = rr.pickup_address_id
join passengers as p using(passID)
natural join commercial_accounts as ca
where a.addressID = rr.pickup_address_id
ORDER BY i.invoice_id
;

