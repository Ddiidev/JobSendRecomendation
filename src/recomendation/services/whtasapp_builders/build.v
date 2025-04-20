module whtasapp_builders

import time
import repository
import mf_core.context_service as ctx_service
import mf_core.features.amazon.models as amazon_models
import mf_core.features.netflix.models as netflix_models
import mf_core.features.instant_gaming.models as instant_gaming_models
import mf_core.features.livros_gratuitos.models as livros_gratuitos_models
import mf_core.features.mercado_livre_play.models as mercado_livre_play_models

// Função para construir e enviar um email com recomendações de todas as plataformas
pub fn build_all_recommendations(contact_id int, whatsapp string,
	amazon_products []amazon_models.AmazonProduct,
	instant_gaming_product instant_gaming_models.InstantGamingProduct,
	livros_gratuitos_product livros_gratuitos_models.LivrosGratuitosProduct,
	mercado_livre_play_product mercado_livre_play_models.MercadoLivrePlayProduct,
	netflix_product netflix_models.NetflixProduct) {
	ctx := ctx_service.ContextService{}
	start_time := time.now()

	dump('(Whatapp)Iniciado recomendação para Amazon')
	build_amazon(ctx, whatsapp, amazon_products)

	ctx.log_info({
		'path': '${@FN} (${@MOD})${@FILE_LINE} (Whatapp)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg': 'Amazon gerada'
		}
	})

	dump('(Whatapp)Iniciado recomendação para Instant Gaming')
	build_instant_gaming(ctx, whatsapp, instant_gaming_product)

	ctx.log_info({
		'path': '${@FN} (${@MOD})${@FILE_LINE} (Whatapp)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg': 'Instant Gaming gerada'
		}
	})

	dump('(Whatapp)Iniciado recomendação para Livros Gratuitos')
	build_livros_gratuitos(ctx, whatsapp, livros_gratuitos_product)

	ctx.log_info({
		'path': '${@FN} (${@MOD})${@FILE_LINE} (Whatapp)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg': 'Livros gratuitos gerada'
		}
	})

	dump('(Whatapp)Iniciado recomendação para Mercado Livre Play')
	build_mercado_livre_play(ctx, whatsapp, mercado_livre_play_product)

	ctx.log_info({
		'path': '${@FN} (${@MOD})${@FILE_LINE} (Whatapp)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg': 'Mercado livre play gerada'
		}
	})

	dump('(Whatapp)Iniciado recomendação para Netflix')
	build_netflix(ctx, whatsapp, netflix_product)

	ctx.log_info({
		'path': '${@FN} (${@MOD})${@FILE_LINE} (Whatapp)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg': 'Netflix gerada'
		}
	})

	dump('(Whatapp)Adicionando informações de adicionais')
	build_infos(ctx, whatsapp)

	ctx.log_info({
		'path': '${@FN} (${@MOD})${@FILE_LINE} (Whatapp)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg': 'Informações de rodapé gerada'
		}
	})

	duration := time.now() - start_time

	repository.update_latest_recomendation(contact_id) or {
		ctx.log_server_action(
			path:        '${@FN} (${@MOD})${@FILE_LINE}'
			method:      .update
			status_text: 'fail'
			duration:    '${duration.seconds():.2f}'
			list_error:  {
				'code': err.code().str()
				'msg':  err.msg()
			}
		)

		return
	}

	ctx.log_server_action(
		path:        '${@FN} (${@MOD})${@FILE_LINE}'
		method:      .create
		status_text: 'success'
		duration:    '${duration.seconds():.2f}'
	)
}
