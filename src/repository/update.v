module repository

import time
import entities
import mf_core.infradb

pub fn update_latest_recomendation(id int) ! {
	mut db := infradb.ConnectionDb.new()!

	defer {
		db.close()
	}

	sql db.conn {
		update entities.Contact set latest_recomendation_at = time.now() where id == id
	}!
}
