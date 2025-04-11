module repository

import entities
import mf_core.utils
import mf_core.infradb

pub fn get_all(current_id int) ![]entities.Contact {
	mut db := infradb.ConnectionDb.new()!

	defer {
		db.close()
	}

	// max := current_id + 100

	start, _ := utils.get_date_start_and_end()

	return sql db.conn {
		select from entities.Contact where (latest_recomendation_at is none
		|| latest_recomendation_at < start)
	} or {
		eprintln(err)
		return []entities.Contact{}
	}
}
