module models

import time
import shareds.types

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

pub struct MercadoLivrePlayProduct {
pub:
	id               int @[primary; sql: serial]
	year             int
	geral_evaluation f32
	qtde_evaluation  int
	title            string
	overview         string
	link             string
	trailer_link     string
	current_date     time.Time
	languages        Languages
	subtitles        Subtitles
	genders          types.Genders
	thumbnails_links types.ThumbLink
}
