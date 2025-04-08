module whtasapp_builders

import wpapi.services as wpapi_services
import netflix.models as netflix_models

fn build_netflix(whatsapp string, netflix netflix_models.NetflixProduct) {
	mut text := '👉🏻 Plataforma: *Netflix*\n'
	text += '📍 Título: *${netflix.title}*\n'
	text += '🎭 Gêneros: *${netflix.genders}*\n'
	text += '⭐ Avaliação: *Não definido*\n'
	text += '🗒️ Sinopse: _${netflix.overview.trim_space()}_\n'
	text += '🎬 Trailer: *${netflix.trailer_link}*\n'
	text += '🌐 Link: *${netflix.link}*\n'

	wpapi_services.send_image(
		to:      whatsapp
		url:     netflix.thumbnails_links
		caption: text
	) or {}
}
