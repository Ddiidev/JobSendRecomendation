module controllers

import amazon.models
import shareds.logger
import amazon.repository

pub fn get_recomendation(mut log logger.ILogger) ![]models.AmazonProduct {
	data_entities := repository.get_recomendation() or {
		log.error('${@FN} | ${err.str()}')
		return err
	}

	return data_entities.map(it.to_model())
}
