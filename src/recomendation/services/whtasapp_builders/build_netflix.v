module whtasapp_builders

import wpapi.services as wpapi_services
import mf_core.context_service as ctx_service
import mf_core.features.netflix.models as netflix_models

fn build_netflix(ctx ctx_service.ContextService, whatsapp string, netflix netflix_models.NetflixProduct) {
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
	) or {
		ctx.log_info({
			'path':        '${@FN}'
			'status_text': 'fail'
			'list_error':  {
				'product': netflix.id.str()
				'error': err.msg()
				'code':  err.code().str()
			}
		})
	}
}
