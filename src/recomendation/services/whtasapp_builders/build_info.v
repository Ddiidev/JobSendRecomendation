module whtasapp_builders

import strings
import wpapi.services as wpapi_services
import mf_core.context_service as ctx_service

fn build_infos(ctx ctx_service.ContextService, whatsapp string) {
	mut sb := strings.new_builder(100)

	sb.write_string('🌐 Acesse: *https://maisfoco.life* 🌱\n')
	sb.write_string('📩 Email: *contato@maisfoco.life*\n')
	sb.write_string(
		'📖 Não sei se você sabe, mas você pode cancelar a inscrição na newsletter a qualquer momento.\n' +
		'A iniciativa Mais foco 🌱 é gratuita e é primordial que você tenha liberdade de conseguir escolher\n' +
		'seu filme, jogo ou livro, mas também de quando não quer mais receber as novidades.\n' +
		'Aqui está o link para *cancelar* a inscrição: *https://maisfoco.life/newsletter/cancel/${whatsapp}*')
	wpapi_services.send_text(to: whatsapp, text: sb.str()) or {
		ctx.log_info({
			'path':        '${@FN}'
			'status_text': 'fail'
			'list_error':  {
				'error': err.msg()
				'code':  err.code().str()
			}
		})

		return
	}
}
