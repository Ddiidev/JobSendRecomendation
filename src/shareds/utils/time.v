module utils

import time
import shareds.consts

pub fn get_date_start_and_end() (time.Time, time.Time) {
	current_date := time.now().custom_format('YYYY-MM-DD')

	start_current_date_time := time.parse('${current_date} 00:00:00') or { consts.time_empty }
	end_current_date_time := time.parse('${current_date} 23:59:59') or { consts.time_empty }

	return start_current_date_time, end_current_date_time
}

pub fn get_current_date_clean_time() time.Time {
	return time.parse('${time.now().ymmdd()} 00:00:00') or { consts.time_empty }
}

pub fn sanitize_date_clean_time(time_ time.Time) time.Time {
	return time.parse('${time_.ymmdd()} 00:00:00') or { consts.time_empty }
}
