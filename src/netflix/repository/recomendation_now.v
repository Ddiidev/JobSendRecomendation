module repository

import shareds.db
import shareds.utils
import netflix.entities

pub fn get_recomendation() !entities.NetflixProduct {
	mut dbase := db.ConnectionDb.new()!
	defer {
		dbase.close()
	}

	start, end := utils.get_date_start_and_end()

	mut res := []entities.NetflixProduct{}
	$if debug ? || debug_without_cache ? {
		res = sql dbase.conn {
			select from entities.NetflixProduct limit 1
		}!
	} $else {
		res = sql dbase.conn {
			select from entities.NetflixProduct where current_date >= start && current_date <= end limit 1
		}!
	}

	return res[0] or { entities.NetflixProduct{} }
}
