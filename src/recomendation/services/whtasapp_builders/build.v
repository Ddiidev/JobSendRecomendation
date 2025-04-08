module whtasapp_builders

import repository
import amazon.models as amazon_models
import netflix.models as netflix_models
import instant_gaming.models as instant_gaming_models
import livros_gratuitos.models as livros_gratuitos_models
import mercado_livre_play.models as mercado_livre_play_models

// Função para construir e enviar um email com recomendações de todas as plataformas
pub fn build_all_recommendations(contact_id int, whatsapp string,
	amazon_products []amazon_models.AmazonProduct,
	instant_gaming_product instant_gaming_models.InstantGamingProduct,
	livros_gratuitos_product livros_gratuitos_models.LivrosGratuitosProduct,
	mercado_livre_play_product mercado_livre_play_models.MercadoLivrePlayProduct,
	netflix_product netflix_models.NetflixProduct) {
	dump('(Whatapp)Iniciado recomendação para Amazon')
	build_amazon(whatsapp, amazon_products)

	dump('(Whatapp)Iniciado recomendação para Instant Gaming')
	build_instant_gaming(whatsapp, instant_gaming_product)

	dump('(Whatapp)Iniciado recomendação para Livros Gratuitos')
	build_livros_gratuitos(whatsapp, livros_gratuitos_product)

	dump('(Whatapp)Iniciado recomendação para Mercado Livre Play')
	build_mercado_livre_play(whatsapp, mercado_livre_play_product)

	dump('(Whatapp)Iniciado recomendação para Netflix')
	build_netflix(whatsapp, netflix_product)

	dump('(Whatapp)Adicionando informações de adicionais')
	build_infos(whatsapp)

	repository.update_latest_recomendation(contact_id) or {}
}
