module whtasapp_builders

import wpapi.services as wpapi_services
import amazon.models as amazon_models

fn build_amazon(whatsapp string, amazon_products []amazon_models.AmazonProduct) {
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
		) or {}
	}
}
