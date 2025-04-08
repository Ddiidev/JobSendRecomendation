module models

import time
import shareds.types

pub struct InstantGamingProduct {
pub:
	id                   int
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
	link                 string
	preview_video        string
	genders              types.Genders
	tags                 types.UserTags
	current_date         time.Time
	images               []InstantGamingProductImage
}

pub fn (igp InstantGamingProduct) get_price() string {
	return '${igp.price:3.2f}'
}

pub fn (igp InstantGamingProduct) get_discount() string {
	return if discount := igp.discount {
		'${discount}'
	} else {
		'0'
	}
}

pub fn (igp InstantGamingProduct) get_old_price() string {
	return if price_old := igp.price_old {
		'${price_old:3.2f}'
	} else {
		'0.00'
	}
}
