use littlelemondb2;
DELIMITER //
create procedure GetMaxQuantity() 
BEGIN
select max(quantity) from orders;
END//
DELIMITER ;


prepare GetOrderDetail from "select order_id, quantity, total_cost from orders where customer_id= ?";


DELIMITER //
create procedure CancelOrder(in in_order_id int) 
BEGIN
delete from orders where order_id = in_order_id;
END//
DELIMITER ;

DELIMITER //
create  procedure CheckBooking (in in_booking_date date, in in_table_number int) 
BEGIN
select case when exists (select booking_id from bookings where date = in_booking_date and table_number = in_table_number) then concat('Table ' , in_table_number, ' is already booked')
else concat('Table ', in_table_number, ' not booked yet')  end as Booking_Status ;
END//
DELIMITER ;

DELIMITER //
create  procedure AddValidBooking (in in_booking_date date, in in_table_number int) 
BEGIN
start transaction;
insert into bookings(date, table_number) values (in_booking_date, in_table_number);
select case when count(*)> 1 then False else true end into @double_booking from bookings where date = in_booking_date and table_number = in_table_number;
if @double_booking then
	rollback;
	select concat('Table ', in_table_number, ' is already booked. Booking cancelled') from dual;
else  
	commit;
	select concat('Table ', in_table_number, ' already booked on', in_booking_date) from dual;
end if;
END//
DELIMITER ;

DELIMITER //
create  procedure AddBooking (in in_booking_id int, in in_customer_id int, in in_booking_date date, in in_table_number int) 
BEGIN
insert into bookings(booking_id, customer_id, date, table_number) values (in_booking_id, in_customer_id, in_booking_date, in_table_number);
select concat('New booking added') from dual;
END//
DELIMITER ;
 #call AddBooking(1,1,'2023-10-10',3);
 
DELIMITER //
create  procedure UpdateBooking  (in in_booking_id int,  in in_booking_date date) 
BEGIN
update bookings set date = in_booking_date where booking_id= in_booking_id;
select concat('Booking' , in_booking_id, ' updated.') from dual;
END//
DELIMITER ;

DELIMITER //
create  procedure CancelBooking  (in in_booking_id int) 
BEGIN
delete from bookings where booking_id= in_booking_id;
select concat('Booking' , in_booking_id, ' cancelled.') from dual;
END//
DELIMITER ;
