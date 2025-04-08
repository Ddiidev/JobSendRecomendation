module whtasapp_builders

import wpapi.services as wpapi_services
import livros_gratuitos.models as instant_gaming_models

fn build_livros_gratuitos(whatsapp string, livro_gratuito instant_gaming_models.LivrosGratuitosProduct) {
	mut text := '👉🏻 Plataforma: *Livros Gratuitos*\n'
	text += '📍 Título: *${livro_gratuito.title}*\n'
	text += '🎭 Genêro: *${livro_gratuito.genders}*\n'
	text += '✍🏻 Autor: ${livro_gratuito.author}\n'
	text += '📖 Digital: Tem PDF ${livro_gratuito.has_pdf()}, Tem Leitura online ${livro_gratuito.has_read_online()}\n'
	text += '🗒️ Sinopse: _${livro_gratuito.overview.trim_space()}_\n'
	text += '🪙 Preço: *R$ 0.00*\n'
	text += '🌐 Link: *${livro_gratuito.link}*\n'

	wpapi_services.send_image(
		to:      whatsapp
		url:     livro_gratuito.thumbnail_link
		caption: text
	) or {}
}
