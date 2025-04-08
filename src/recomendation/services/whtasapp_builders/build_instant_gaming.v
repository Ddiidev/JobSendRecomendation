module whtasapp_builders

import wpapi.services as wpapi_services
import instant_gaming.models as instant_gaming_models

fn build_instant_gaming(whatsapp string, instant_gaming instant_gaming_models.InstantGamingProduct) {
	mut text := '👉🏻 Plataforma: *Instant Gaming*\n'
	text += '📍 Título: *${instant_gaming.title}*\n'
	text += '🎭 Genêro: *${instant_gaming.genders}*\n'
	text += '🎮 Plataforma de ativação: ${instant_gaming.activating_plataform}\n'
	text += '⭐ Avaliação: *${instant_gaming.review_general}*\n'
	text += '🗒️ Sinopse: _${instant_gaming.about.trim_space()}_\n'
	text += '🎬 Trailer: *${instant_gaming.preview_video}*\n'
	text += '🪙 Preço: *R$ ${instant_gaming.get_price()}* (_-${instant_gaming.get_discount()}%_) | *~R$ ${instant_gaming.get_old_price()}~*\n'
	text += '🌐 Link: *${instant_gaming.link}*\n'

	wpapi_services.send_image(
		to:      whatsapp
		url:     instant_gaming.images[0] or { return }.image_url
		caption: text
	) or {}
}
