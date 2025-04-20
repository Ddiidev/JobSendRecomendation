module controllers

import mf_core.features.amazon.models
import mf_core.features.amazon.repository
import mf_core.context_service as ctx_service
import mf_core.log_observoo.models as log_models

pub fn get_recomendation(mut ctx ctx_service.ContextService) ![]models.AmazonProduct {
	data_entities := repository.get_recomendation() or {
		ctx.log_server_action(log_models.ContractTypeServerAction{
            method:      .create
            path:        '${@FN} ${@FILE_LINE}'
            status_text: err.msg()
            list_error:       {
                'code':    err.code().str()
                'message': err.msg()
            }
        })
		return err
	}

	return data_entities.map(it.to_model())
}
