module services

import time
import repository as contact_repository
import recomendation.services.email_builders
import mf_core.context_service as ctx_service
import recomendation.services.whtasapp_builders
import amazon.controllers as amazon_controllers
import netflix.controllers as netflix_controllers
import mf_core.features.netflix.models as netflix_models
import instant_gaming.controllers as instant_gaming_controllers
import livros_gratuitos.controllers as livros_gratuitos_controllers
import mf_core.features.instant_gaming.models as instant_gaming_models
import mercado_livre_play.controllers as mercado_livre_play_controllers
import mf_core.features.livros_gratuitos.models as livros_gratuitos_models
import mf_core.features.mercado_livre_play.models as mercado_livre_play_models

pub fn send_recomendations() {
	mut threads := []thread{}
	mut ctx := ctx_service.ContextService{}
	start_req_time := time.now()

	defer {
		current_time := time.now()
		ctx.duration = current_time - start_req_time

		ctx.log_info({
			'path':        'ENVIO DE RECOMENDAÇÕES'
			'status_code': f64(200)
			'status_text': 'success'
			'duration':    '${ctx.duration.seconds():.2f}'
		})
	}

	fn_log_product := fn [mut ctx] (err IError, name_product string) {
		ctx.log_server_action(
			path:        'JOB: ENVIO DE RECOMENDAÇÕES(GET_PRODUTOS_${name_product})'
			status_text: 'fail'
			list_error:  {
				'error_code': err.code().str()
				'error':      err.msg()
			}
		)
	}

	contatcs := contact_repository.get_all(0) or {
		ctx.log_server_action(
			path:        'JOB: ENVIO DE RECOMENDAÇÕES(GET_CONTATOS)'
			status_text: 'fail'
			list_error:  {
				'error_code': err.code().str()
				'error':      err.msg()
			}
		)

		return
	}
	amazon_products := amazon_controllers.get_recomendation(mut ctx) or {
		fn_log_product(err, 'AMAZON')

		[]
	}
	netflix_product := netflix_controllers.get_recomendation(mut ctx) or {
		fn_log_product(err, 'NETFLIX')

		netflix_models.NetflixProduct{}
	}
	instangaming_product := instant_gaming_controllers.get_recomendation(mut ctx) or {
		fn_log_product(err, 'INSTANT_GAMING')

		instant_gaming_models.InstantGamingProduct{}
	}
	livros_gratuitos_product := livros_gratuitos_controllers.get_recomendation(mut ctx) or {
		fn_log_product(err, 'LIVROS_GRATUITOS')

		livros_gratuitos_models.LivrosGratuitosProduct{}
	}
	mercado_livre_play_product := mercado_livre_play_controllers.get_recomendation(mut ctx) or {
		fn_log_product(err, 'MERCADO_LIVRE_PLAY')

		mercado_livre_play_models.MercadoLivrePlayProduct{}
	}

	for contact in contatcs {
		println('Número de threads atual: ${threads.len}')
		if threads.len == 4 {
			threads.wait()
			threads = []
		}

		if contact.whatsapp != none {
			dump('Whasapp -> Enviando via whatsapp (add a pilha de threads)')
			threads << go whtasapp_builders.build_all_recommendations(contact.id, contact.whatsapp,
				amazon_products, instangaming_product, livros_gratuitos_product, mercado_livre_play_product,
				netflix_product)
			dump('Whasapp -> Adicionado na pilha de threads')
		}
		if contact.email != none {
			dump('Email -> Enviando via email (add a pilha de threads)')
			threads << go email_builders.build_all_recommendations(contact.id, contact.email,
				amazon_products, instangaming_product, livros_gratuitos_product, mercado_livre_play_product,
				netflix_product)
			dump('Email -> Adicionado na pilha de threads')
		}
	}

	if threads.len > 0 {
		threads.wait()
	}
}
