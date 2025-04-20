module maisfoco_server

import time
import json
import wpapi.services as wpapi
import mf_core.context_service as ctx_service

pub fn send_message_confirm_cancel(ctx ctx_service.ContextService, rsequest string) {
	data := json.decode(map[string]string, rsequest) or {
		map[string]string{}
	}

	link := data['link'] or {
		'(FALHA AO GERAR O LINK PARA CANCELAR, por favor reportar via email: contato@maisfoco.life)'
	}

	start_time := time.now()

	wpapi.send_text(
		to:   data['contact']
		text: 'Olá! Só por segurança mais uma confirmação para cancelar a newsletter do Mais foco 🌱: ${link}'
	) or {
		duration := time.now() - start_time

		ctx.log_server_action(
			path:        '${@FN} (${@MOD})${@FILE_LINE}'
			method:      .update
			status_text: 'fail'
			duration:    '${duration.seconds():.2f}'
			list_error:  {
				'code': err.code().str()
				'msg':  err.msg()
			}
		)

		return
	}

	duration := time.now() - start_time

	ctx.log_server_action(
		path:        '${@FN} (${@MOD})${@FILE_LINE}'
		method:      .create
		status_text: 'success'
		duration:    '${duration.seconds():.2f}'
	)
}
