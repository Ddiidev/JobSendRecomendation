module whtasapp_builders

import wpapi.services as wpapi_services
import mf_core.context_service as ctx_service
import mf_core.features.livros_gratuitos.models as livros_gratuitos_models

fn build_livros_gratuitos(ctx ctx_service.ContextService, whatsapp string, livro_gratuito livros_gratuitos_models.LivrosGratuitosProduct) {
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
	) or {
		ctx.log_info({
			'path':        '${@FN}'
			'status_text': 'fail'
			'list_error':  {
				'product': livro_gratuito.id.str()
				'error':   err.msg()
				'code':    err.code().str()
			}
		})
	}
}
