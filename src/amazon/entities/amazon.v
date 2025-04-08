module entities

import time
import amazon.models

@[table: 'AmazonProducts']
pub struct AmazonProduct {
pub:
	id                 int @[primary; sql: serial]
	geral_evaluation   f32
	qtde_evaluation    int
	price_printed      ?f64
	price_kindle_ebook ?f64
	link               string
	title              string
	author             string
	sinopse            string
	images_links       string
	thumbnails_links   string
	current_date       time.Time @[omitempty; sql_type: 'TIMESTAMP']
}

pub fn (mut ap AmazonProduct) change_current_date(current_date time.Time) {
	ap = AmazonProduct{
		...ap
		current_date: current_date
	}
}

pub fn (ap AmazonProduct) to_model() models.AmazonProduct {
	return models.AmazonProduct{
		id:                 ap.id
		geral_evaluation:   ap.geral_evaluation
		qtde_evaluation:    ap.qtde_evaluation
		price_printed:      ap.price_printed
		price_kindle_ebook: ap.price_kindle_ebook
		link:               ap.link
		title:              ap.title
		author:             ap.author
		sinopse:            ap.sinopse
		images_links:       ap.images_links
		thumbnails_links:   ap.thumbnails_links
		current_date:       ap.current_date
	}
}
