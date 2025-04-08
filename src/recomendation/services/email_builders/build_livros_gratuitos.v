module email_builders

import livros_gratuitos.models as livros_gratuitos_models

// Função para gerar o HTML de um produto de Livros Gratuitos
pub fn generate_livros_gratuitos_html(livro_gratuito livros_gratuitos_models.LivrosGratuitosProduct) string {
	return $tmpl('./views/livros_gratuitos.html')
}
