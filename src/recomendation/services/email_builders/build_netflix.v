module email_builders

import mf_core.features.netflix.models as netflix_models

// Função para gerar o HTML de um produto da Netflix
pub fn generate_netflix_html(netflix netflix_models.NetflixProduct) string {
	return $tmpl('./views/netflix.html')
}
