module controllers

import mf_core.logger
import mf_core.features.mercado_livre_play.models
import mf_core.features.mercado_livre_play.repository

pub fn get_recomendation(mut log logger.ILogger) !models.MercadoLivrePlayProduct {
	data_entities := repository.get_recomendation() or {
		log.error('${@FN} | ${err.str()}')
		return err
	}

	return data_entities.to_model()
}
