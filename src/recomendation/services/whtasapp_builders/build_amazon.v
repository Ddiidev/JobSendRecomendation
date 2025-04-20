module whtasapp_builders

import wpapi.services as wpapi_services
import mf_core.context_service as ctx_service
import mf_core.features.amazon.models as amazon_models

fn build_amazon(ctx ctx_service.ContextService, whatsapp string, amazon_products []amazon_models.AmazonProduct) {
	mut list_error := map[string]string{}

	defer {
		if list_error.len > 0 {
			list_error['contato'] = whatsapp

			ctx.log_info({
				'path': '${@FN}'
				'status_text': 'fail'
				'list_error': &list_error
			})
		}
	}

	for amazon in amazon_products {
		mut text := '👉🏻 Plataforma: *Amazon*\n'
		text += '📍 Título: *${amazon.title}*\n'
		text += '⭐ Avaliação: *${amazon.geral_evaluation}*\n'
		text += '🗒️ Sinopse: _${amazon.sinopse.trim_space()}_\n'
		text += '🪙 Preço: *${amazon.price_printed or { 0.00 }}*\n'
		text += '🪙 Preço digital: *${amazon.price_kindle_ebook or { 0.00 }}*\n'
		text += '🌐 Link: *${amazon.link}*\n'

		wpapi_services.send_image(
			to:      whatsapp
			url:     amazon.thumbnails_links
			caption: text
		) or {
			list_error['msg_error'] = err.msg()
			list_error['error_product_id'] = amazon.id.str()
		}
	}
}
