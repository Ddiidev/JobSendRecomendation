module models

import time
import shareds.types

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
	thumbnails_links   types.ThumbLink
	current_date       time.Time @[omitempty; sql_type: 'TIMESTAMP']
}

pub fn (ap AmazonProduct) is_free() bool {
	return ap.price_printed or { 0 } == 0.0 && ap.price_kindle_ebook or { 0 } == 0.0
}
