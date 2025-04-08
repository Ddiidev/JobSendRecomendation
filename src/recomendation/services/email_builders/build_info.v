module email_builders

// Função para gerar o HTML com informações do site
pub fn build_infos(email string) string {
	email_contato := 'contato@maisfoco.life'
	return $tmpl('./views/info.html')
}
