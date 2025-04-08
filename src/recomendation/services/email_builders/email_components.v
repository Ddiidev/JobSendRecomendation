module email_builders

// Função para gerar o cabeçalho HTML comum para todos os emails
pub fn generate_html_header(title string) string {
	return $tmpl('./views/header.html')
}

// Função para gerar o rodapé HTML comum para todos os emails
pub fn generate_html_footer() string {
	return $tmpl('./views/footer.html')
}
