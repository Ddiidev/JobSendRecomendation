module email_builders

import amazon.models as amazon_models

// Função para gerar o HTML de um produto da Amazon
fn generate_amazon_html(amazon amazon_models.AmazonProduct) string {
	return $tmpl('./views/amazon.html')
}
