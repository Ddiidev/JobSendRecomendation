module entities

import time
import mercado_livre_play.models

pub type Languages = string

pub fn (l Languages) to_list() []string {
	return l.split(',')
}

pub fn (l Languages) add(languages ...string) Languages {
	return l + ',' + languages.join(',')
}

pub type Subtitles = string

pub fn (s Subtitles) to_list() []string {
	return s.split(',')
}

pub fn (s Subtitles) add(subtitles ...string) Subtitles {
	return s + ',' + subtitles.join(',')
}

@[table: 'MercadoLivrePlayProducts']
pub struct MercadoLivrePlayProduct {
pub:
	id               int @[primary; sql: serial]
	year             int
	geral_evaluation f32
	qtde_evaluation  int
	title            string
	overview         string
	link             string
	genders          string
	languages        string
	subtitles        string
	trailer_link     string
	thumbnails_links string
	current_date     time.Time @[omitempty; sql_type: 'TIMESTAMP']
}

pub fn (mut mlpp MercadoLivrePlayProduct) change_current_date(current_date time.Time) {
	mlpp = MercadoLivrePlayProduct{
		...mlpp
		current_date: current_date
	}
}

pub fn (mlpp MercadoLivrePlayProduct) to_model() models.MercadoLivrePlayProduct {
	return models.MercadoLivrePlayProduct{
		id:               mlpp.id
		year:             mlpp.year
		geral_evaluation: mlpp.geral_evaluation
		qtde_evaluation:  mlpp.qtde_evaluation
		title:            mlpp.title
		overview:         mlpp.overview
		link:             mlpp.link
		genders:          mlpp.genders
		languages:        mlpp.languages
		subtitles:        mlpp.subtitles
		trailer_link:     mlpp.trailer_link
		thumbnails_links: mlpp.thumbnails_links
		current_date:     mlpp.current_date
	}
}
