module entities

import time
import livros_gratuitos.models

@[table: 'LivrosGratuitosProducts']
pub struct LivrosGratuitosProduct {
pub:
	has_link_pdf         bool
	has_link_read_online bool
	title                string
	author               string
	overview             string
	genders              string
	thumbnail_link       string
	link                 string
	current_date         time.Time @[omitempty; sql_type: 'TIMESTAMP']
}

pub fn (mut lg LivrosGratuitosProduct) change_current_date(current_date time.Time) {
	lg = LivrosGratuitosProduct{
		...lg
		current_date: current_date
	}
}

pub fn (lg LivrosGratuitosProduct) to_model() models.LivrosGratuitosProduct {
	return models.LivrosGratuitosProduct{
		has_link_pdf:         lg.has_link_pdf
		has_link_read_online: lg.has_link_read_online
		title:                lg.title
		author:               lg.author
		overview:             lg.overview
		genders:              lg.genders
		thumbnail_link:       lg.thumbnail_link
		link:                 lg.link
		current_date:         lg.current_date
	}
}
