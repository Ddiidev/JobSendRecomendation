module models

import time
import shareds.types

pub struct NetflixProduct {
pub:
	id               int @[primary; sql: serial]
	year             int
	title            string
	overview         string
	link             string
	trailer_link     string
	genders          types.Genders
	thumbnails_links types.ThumbLink
	current_date     time.Time
}
