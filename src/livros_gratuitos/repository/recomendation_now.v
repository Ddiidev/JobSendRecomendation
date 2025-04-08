module repository

import shareds.db
import shareds.utils
import livros_gratuitos.entities

pub fn get_recomendation() !entities.LivrosGratuitosProduct {
	mut dbase := db.ConnectionDb.new()!

	defer {
		dbase.close()
	}

	start, end := utils.get_date_start_and_end()

	mut res := []entities.LivrosGratuitosProduct{}
	$if debug ? || debug_without_cache ? {
		res = sql dbase.conn {
			select from entities.LivrosGratuitosProduct limit 1
		}!
	} $else {
		res = sql dbase.conn {
			select from entities.LivrosGratuitosProduct where current_date >= start
			&& current_date <= end limit 1
		}!
	}

	return res[0] or { entities.LivrosGratuitosProduct{} }
}
