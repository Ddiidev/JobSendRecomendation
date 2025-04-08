module email_builders

import instant_gaming.models as instant_gaming_models

// Função para gerar o HTML de um produto do Instant Gaming
pub fn generate_instant_gaming_html(instant_gaming instant_gaming_models.InstantGamingProduct) string {
	return $tmpl('./views/instant_gaming.html')
}
