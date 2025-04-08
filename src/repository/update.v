module repository

import time
import entities
import shareds.db

pub fn update_latest_recomendation(id int) ! {
	mut dbase := db.ConnectionDb.new()!

	defer {
		dbase.close()
	}

	sql dbase.conn {
		update entities.Contact set latest_recomendation_at = time.now() where id == id
	}!
}
