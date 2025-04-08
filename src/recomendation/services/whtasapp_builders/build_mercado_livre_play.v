module whtasapp_builders

import wpapi.services as wpapi_services
import mercado_livre_play.models as mercado_livre_play_models

fn build_mercado_livre_play(whatsapp string, mercado_livre_play mercado_livre_play_models.MercadoLivrePlayProduct) {
	mut text := '👉🏻 Plataforma: *Mercado Livre Play*\n'
	text += '📍 Título: *${mercado_livre_play.title}*\n'
	text += '📅 Ano: *${mercado_livre_play.year}*\n'
	text += '⭐ Avaliação: *${mercado_livre_play.geral_evaluation}/5.0 (${mercado_livre_play.qtde_evaluation} avaliações)*\n'
	text += '🗒️ Sinopse: _${mercado_livre_play.overview.trim_space()}_\n'
	text += '🎬 Trailer: *${mercado_livre_play.trailer_link}*\n'
	text += '🌐 Link: *${mercado_livre_play.link}*\n'
	text += '🎭 Gêneros: *${mercado_livre_play.genders}*\n'
	text += '🔊 Idiomas: *${mercado_livre_play.languages}*\n'
	text += '💬 Legendas: *${mercado_livre_play.subtitles}*\n'

	wpapi_services.send_image(
		to:      whatsapp
		url:     mercado_livre_play.thumbnails_links
		caption: text
	) or {}
}
