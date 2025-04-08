module entities

import time
import instant_gaming.models

@[table: 'InstantGamingProducts']
pub struct InstantGamingProduct {
pub:
	id                   int @[primary; sql: serial]
	price                f64
	qtde_review          int
	price_old            ?f64
	discount             ?int
	review_general       string
	title                string
	about                string
	activating_plataform string
	studio               string
	publisher            string
	genders              string
	tags                 string
	link                 string
	preview_video        string
	current_date         time.Time                   @[omitempty; sql_type: 'TIMESTAMP']
	images               []InstantGamingProductImage @[fkey: 'parent_id']
}

pub fn (mut igp InstantGamingProduct) change_current_date(current_date time.Time) {
	igp = InstantGamingProduct{
		...igp
		current_date: current_date
	}
}

pub fn (igp InstantGamingProduct) to_model() models.InstantGamingProduct {
	return models.InstantGamingProduct{
		id:                   igp.id
		price:                igp.price
		qtde_review:          igp.qtde_review
		price_old:            igp.price_old
		discount:             igp.discount
		review_general:       igp.review_general
		title:                igp.title
		about:                igp.about
		activating_plataform: igp.activating_plataform
		studio:               igp.studio
		publisher:            igp.publisher
		genders:              igp.genders
		tags:                 igp.tags
		link:                 igp.link
		preview_video:        igp.preview_video
		current_date:         igp.current_date
		images:               igp.images.to_model()
	}
}
