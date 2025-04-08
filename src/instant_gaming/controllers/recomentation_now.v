module controllers

import shareds.logger
import instant_gaming.models
import instant_gaming.repository

pub fn get_recomendation(mut log logger.ILogger) !models.InstantGamingProduct {
	data_entities := repository.get_recomendation() or {
		log.error('${@FN} | ${err.str()}')
		return err
	}

	return data_entities.to_model()
}
