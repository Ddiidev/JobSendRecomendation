module controllers

import shareds.logger
import netflix.models
import netflix.repository

pub fn get_recomendation(mut log logger.ILogger) !models.NetflixProduct {
	data_entities := repository.get_recomendation() or {
		log.error('${@FN} | ${err.str()}')
		return err
	}

	return data_entities.to_model()
}
