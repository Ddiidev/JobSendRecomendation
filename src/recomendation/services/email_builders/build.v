module email_builders

import strings
import repository
import shareds.logger
import amazon.models as amazon_models
import netflix.models as netflix_models
import shareds.handle_email.service as email_service
import instant_gaming.models as instant_gaming_models
import livros_gratuitos.models as livros_gratuitos_models
import mercado_livre_play.models as mercado_livre_play_models

// Função para construir e enviar um email com recomendações de todas as plataformas
pub fn build_all_recommendations(contact_id int, email string,
	amazon_products []amazon_models.AmazonProduct,
	instant_gaming_product instant_gaming_models.InstantGamingProduct,
	livros_gratuitos_product livros_gratuitos_models.LivrosGratuitosProduct,
	mercado_livre_play_product mercado_livre_play_models.MercadoLivrePlayProduct,
	netflix_product netflix_models.NetflixProduct) {
	mut log := logger.Logger.new('logs', 'Teste')
	mut sb := strings.new_builder(300)

	log.info('${@FN} | Iniciando geração de email de recomendações')

	// Verificar se há pelo menos um produto para enviar
	if amazon_products.len == 0 {
		log.info('${@FN} | Nenhum produto para enviar')
		return
	}

	// Gerar o cabeçalho do email
	sb.write_string(generate_html_header('Recomendações MaisFoco.life'))

	log.info('${@FN} | Header gerado')

	dump('(Email)Iniciado recomendação para Amazon')
	for amazon in amazon_products {
		sb.write_string(generate_amazon_html(amazon))
	}

	log.info('${@FN} | Amazon gerada')

	// Adicionar produto do Instant Gaming
	dump('(Email)Iniciado recomendação para Instant Gaming')
	sb.write_string(generate_instant_gaming_html(instant_gaming_product))

	log.info('${@FN} | Instant Gaming gerada')

	if livros_gratuitos_product.title != '' {
		// Adicionar produto de Livros Gratuitos
		dump('(Email)Iniciado recomendação para Livros Gratuitos')
		sb.write_string(generate_livros_gratuitos_html(livros_gratuitos_product))

		log.info('${@FN} | Livros Gratuitos gerada')
	}

	// Adicionar produto do Mercado Livre Play
	dump('(Email)Iniciado recomendação para Mercado Livre Play')
	sb.write_string(generate_mercado_livre_play_html(mercado_livre_play_product))

	log.info('${@FN} | Mercado Livre Play gerada')

	// Adicionar produto da Netflix
	dump('(Email)Iniciado recomendação para Netflix')
	sb.write_string(generate_netflix_html(netflix_product))

	log.info('${@FN} | Netflix gerada')

	dump('(Email)Adicionando informações de adicionais')
	build_infos(email)

	log.info('${@FN} | Informações adicionadas geradas')

	// Adicionar o rodapé do email
	sb.write_string(generate_html_footer())

	log.info('${@FN} | footer gerado')

	// Criar mensagem de email com o HTML
	hemail := email_service.get()
	hemail.send(email, 'Recomendações MaisFoco.life', sb.str()) or {
		log.error('${@FN} | Erro ao enviar email: ${err}')
	}
	repository.update_latest_recomendation(contact_id) or {
		log.error('${@FN} | Erro ao atualizar latest_recomendation: ${err}')
	}
	dump('Email enviado (${email})')
	log.info('${@FN} | Email enviado com sucesso')
}
