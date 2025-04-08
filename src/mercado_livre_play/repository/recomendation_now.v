module repository

import shareds.db
import shareds.utils
import mercado_livre_play.entities

pub fn get_recomendation() !entities.MercadoLivrePlayProduct {
	mut dbase := db.ConnectionDb.new()!
	defer {
		dbase.close()
	}

	start, end := utils.get_date_start_and_end()

	mut res := []entities.MercadoLivrePlayProduct{}
	$if debug ? || debug_without_cache ? {
		res = sql dbase.conn {
			select from entities.MercadoLivrePlayProduct limit 1
		}!
	} $else {
		res = sql dbase.conn {
			select from entities.MercadoLivrePlayProduct where current_date >= start
			&& current_date <= end limit 1
		}!
	}

	return res[0] or { entities.MercadoLivrePlayProduct{} }
}
