module repository

import entities
import shareds.db
import shareds.utils

pub fn get_all(current_id int) ![]entities.Contact {
	mut dbase := db.ConnectionDb.new()!

	defer {
		dbase.close()
	}

	// max := current_id + 100

	start, _ := utils.get_date_start_and_end()

	return sql dbase.conn {
		select from entities.Contact where (latest_recomendation_at is none
		|| latest_recomendation_at < start)
	} or {
		eprintln(err)
		return []entities.Contact{}
	}
}
