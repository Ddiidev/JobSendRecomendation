module whtasapp_builders

import wpapi.services as wpapi_services
import mf_core.context_service as ctx_service
import mf_core.features.gift_cards.entities as gift_cards_entities

pub fn build_gift(ctx ctx_service.ContextService, whatsapp string, gift gift_cards_entities.GiftCard) {
	mut text := '👉🏻 Plataforma: *${gift.plataform}*\n'
	text += '🎁 Título: *Você foi sorteado!*\n'
	text += '📝 Descrição: *${gift.description}*\n'
	text += '🔑 Código: *${gift.code}*\n'
	text += '*Espero que seja bom pra você!*\n'

	wpapi_services.send_image(
		to:      whatsapp
		url:     gift.image_link
		caption: text
	) or {
		ctx.log_info({
			'path':        '${@FN}'
			'status_text': 'fail'
			'list_error':  {
				'gift':  gift.id.str()
				'error': err.msg()
				'code':  err.code().str()
			}
		})
	}
}
