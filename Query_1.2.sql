SELECT
	r.date_id,
	s.first_name,
	s.last_name,
	s.hourly_rate,
	sh.start_time,
	sh.end_time,
	((
			HOUR (
			TIMEDIFF( sh.end_time, sh.start_time ))
			) + (
			MINUTE (
			TIMEDIFF( sh.end_time, sh.start_time )))
	) AS hours_in_shift,
	((
			HOUR (
			TIMEDIFF( sh.end_time, sh.start_time ))
			) + (
			MINUTE (
			TIMEDIFF( sh.end_time, sh.start_time )))
	) * s.hourly_rate AS staff_cost 
FROM
	rota r
	LEFT JOIN staff s ON r.staff_id = s.staff_id
	LEFT JOIN shift sh ON r.shift_id = sh.shift_id;
— save query