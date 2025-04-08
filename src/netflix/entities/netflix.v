module entities

import time
import netflix.models

@[table: 'NetflixProducts']
pub struct NetflixProduct {
pub:
	id               int @[primary; sql: serial]
	year             int
	title            string
	overview         string
	link             string
	genders          string
	trailer_link     string
	thumbnails_links string
	current_date     time.Time @[omitempty; sql_type: 'TIMESTAMP']
}

pub fn (mut np NetflixProduct) change_current_date(current_date time.Time) {
	np = NetflixProduct{
		...np
		current_date: current_date
	}
}

pub fn (np NetflixProduct) to_model() models.NetflixProduct {
	return models.NetflixProduct{
		id:               np.id
		year:             np.year
		title:            np.title
		overview:         np.overview
		link:             np.link
		genders:          np.genders
		trailer_link:     np.trailer_link
		thumbnails_links: np.thumbnails_links
		current_date:     np.current_date
	}
}
