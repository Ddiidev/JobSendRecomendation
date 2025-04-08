module email_builders

import mercado_livre_play.models as mercado_livre_play_models

// Função para gerar o HTML de um produto do Mercado Livre Play
pub fn generate_mercado_livre_play_html(mercado_livre_play mercado_livre_play_models.MercadoLivrePlayProduct) string {
	return $tmpl('./views/mercado_livre_play.html')
}
