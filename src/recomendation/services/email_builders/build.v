module email_builders

import time
import strings
import repository
import mf_core.context_service as ctx_service
import mf_core.features.amazon.models as amazon_models
import mf_core.features.netflix.models as netflix_models
import mf_core.handle_email.service as email_service
import mf_core.features.instant_gaming.models as instant_gaming_models
import mf_core.features.livros_gratuitos.models as livros_gratuitos_models
import mf_core.features.mercado_livre_play.models as mercado_livre_play_models

// Função para construir e enviar um email com recomendações de todas as plataformas
pub fn build_all_recommendations(contact_id int, email string,
	amazon_products []amazon_models.AmazonProduct,
	instant_gaming_product instant_gaming_models.InstantGamingProduct,
	livros_gratuitos_product livros_gratuitos_models.LivrosGratuitosProduct,
	mercado_livre_play_product mercado_livre_play_models.MercadoLivrePlayProduct,
	netflix_product netflix_models.NetflixProduct) {
	mut sb := strings.new_builder(300)
	ctx := ctx_service.ContextService{}
	start_time := time.now()

	ctx.log_info({
		'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg':        'Iniciando geração de email de recomendações'
		}
	})

	// Verificar se há pelo menos um produto para enviar
	if amazon_products.len == 0 {
		ctx.log_info({
			'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
			'statusText': 'success'
			'additional': {
				'contact_id': contact_id.str()
				'msg':        'Nenhum produto para enviar'
			}
		})
		return
	}

	// Gerar o cabeçalho do email
	sb.write_string(generate_html_header('Recomendações MaisFoco.life'))

	ctx.log_info({
		'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg':        'Header gerado'
		}
	})

	for amazon in amazon_products {
		sb.write_string(generate_amazon_html(amazon))
	}

	ctx.log_info({
		'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg':        'Amazon gerada'
		}
	})

	// Adicionar produto do Instant Gaming
	sb.write_string(generate_instant_gaming_html(instant_gaming_product))

	ctx.log_info({
		'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg':        'Instant Gaming gerada'
		}
	})

	if livros_gratuitos_product.title != '' {
		// Adicionar produto de Livros Gratuitos
		sb.write_string(generate_livros_gratuitos_html(livros_gratuitos_product))

		ctx.log_info({
			'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
			'statusText': 'success'
			'additional': {
				'contact_id': contact_id.str()
				'msg':        'Livros Gratuitos gerada'
			}
		})
	}

	// Adicionar produto do Mercado Livre Play
	sb.write_string(generate_mercado_livre_play_html(mercado_livre_play_product))

	ctx.log_info({
		'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg':        'Mercado Livre Play gerada'
		}
	})

	// Adicionar produto da Netflix
	sb.write_string(generate_netflix_html(netflix_product))

	ctx.log_info({
		'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg':        'Netflix gerada'
		}
	})

	build_infos(email)

	ctx.log_info({
		'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg':        'Informações de rodapé gerada'
		}
	})

	// Adicionar o rodapé do email
	sb.write_string(generate_html_footer())

	ctx.log_info({
		'path':       '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
		'statusText': 'success'
		'additional': {
			'contact_id': contact_id.str()
			'msg':        'footer gerado'
		}
	})

	// Criar mensagem de email com o HTML
	mut list_error := map[string]string{}

	hemail := email_service.get()
	hemail.send(email, 'Recomendações MaisFoco.life', sb.str()) or {
		list_error['msg_error'] = err.msg()
		list_error['email'] = email

		ctx.log_server_action(
			path:        '${@FN} (${@MOD})${@FILE_LINE}'
			method:      .create
			status_text: 'fail'
			list_error:  {
				'custom_msg': 'Erro ao enviar email'
				'msg':        err.msg()
			}
		)
	}

	repository.update_latest_recomendation(contact_id) or {
		list_error['msg_error_update'] = err.msg()
		list_error['contact_id'] = contact_id.str()

		ctx.log_server_action(
			path:        '${@FN} (${@MOD})${@FILE_LINE}'
			method:      .create
			status_text: 'fail'
			list_error:  {
				'custom_msg': 'Erro ao atualizar latest_recomendation'
				'msg':        err.msg()
			}
		)
	}

	if list_error.len > 0 {
		ctx.log_server_action(
			path:        '${@FN} (${@MOD})${@FILE_LINE}'
			method:      .create
			status_text: 'fail'
			list_error:  &list_error
		)
	}

	duration := time.now() - start_time

	ctx.log_register(
		path:     '${@FN} (${@MOD})${@FILE_LINE} (EMAIL)'
		response: {
			'contact_id': contact_id.str()
		}
	)
	ctx.log_server_action(
		path:        '${@FN} (${@MOD})${@FILE_LINE}'
		method:      .create
		status_text: 'success'
		duration:    '${duration.seconds():.2f}'
	)
}
