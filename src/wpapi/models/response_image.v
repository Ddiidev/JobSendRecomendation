module models

pub struct ResponseImage {
pub mut:
	status int  @[omitempty]
	data   Data @[omitempty]
}

pub struct Key {
pub mut:
	remote_jid string @[json: 'remoteJid'; omitempty]
	from_me    bool   @[json: 'fromMe'; omitempty]
	id         string @[omitempty]
}

pub struct ImageMessage {
pub mut:
	url                 string @[omitempty]
	mimetype            string @[omitempty]
	caption             string @[omitempty]
	file_sha256         string @[json: 'fileSha256'; omitempty]
	file_length         string @[json: 'fileLength'; omitempty]
	media_key           string @[json: 'mediaKey'; omitempty]
	file_enc_sha256     string @[json: 'fileEncSha256'; omitempty]
	direct_path         string @[json: 'directPath'; omitempty]
	media_key_timestamp string @[json: 'mediaKeyTimestamp'; omitempty]
}

pub struct Message {
pub mut:
	image_message ImageMessage @[json: 'imageMessage'; omitempty]
}

pub struct Data {
pub mut:
	key               Key     @[omitempty]
	message           Message @[omitempty]
	message_timestamp string  @[json: 'messageTimestamp'; omitempty]
	status            string  @[omitempty]
}
