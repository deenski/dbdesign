INSERT INTO commercial_accounts (business_id, name, phone, billing_email, contact_name, rate)
VALUES (1999, "Individual Account","see passenger phone", "See passenger email", "See passenger name", default),
(default, "Twenty Mile Security", "303-505-5603", "jake@twentymilesecurity.com", "Jakob Vendegna", default),
(default, "Nielsen Contracting", "970-333-1653", "mahilio.11@gmail.com", "Maili Nielsen", 0.95);

select * from commercial_accounts;

insert into passengers (passID, first_name, last_name, BDay, social, email, phone_number, rider_type, commercial_id, rider_insurance_policy)
VALUES (default, "Jakob", "Vendegna", CURDATE(), "663-24-1588", "jakevendegna@gmail.com","303-505-5603", default, default, default),
(default, "Maili", "Nielsen", CURDATE(), "223-25-8888", "maili@jake-and-maili.life", "970-333-1653", default, default, default);

select * from passengers;

insert into address (addressID, passID, Street1, Street2, City, State, Zip, address_type)
VALUES (default, 1, '16052 E. Davies Dr', 'Unit 304', 'Aurora', 'CO', 80016, 'H'), 
(default, 1, '1933 Xanadu Way', null, 'Aurora', 'CO', 80014, 'W'),
(default, 2, '533 Teller St.', 'Unit G', 'Frisco', 'CO', 80138, 'H');

select * from address;

insert into ride_request 
values (default, 1, 2, default), 
(default, 2, 1, default),
(default, 1, 3, default),
(default, 3, 1, default);

select * from ride_request;

insert into vehicles
values(default, 'C', "Sophie1", curdate(), 1000), 
(default, 'C', "Sophie2", curdate(), 1000),
(default, 'T', "Astrid1", curdate(), 0);

select * from vehicles;

insert into trip
values (default, 1, 1, 3), 
(default, 2, 1, 3),
(default, 3, 1, 67),
(default, 1, 3, 68);

select * from trip;

insert into invoices
values(default, curdate() , 1), 
(default, curdate(), 2),
(default, curdate(), 3),
(default, curdate(), 4);

select * from invoices;

