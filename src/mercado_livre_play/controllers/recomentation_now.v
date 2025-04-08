module controllers

import shareds.logger
import mercado_livre_play.models
import mercado_livre_play.repository

pub fn get_recomendation(mut log logger.ILogger) !models.MercadoLivrePlayProduct {
	data_entities := repository.get_recomendation() or {
		log.error('${@FN} | ${err.str()}')
		return err
	}

	return data_entities.to_model()
}
