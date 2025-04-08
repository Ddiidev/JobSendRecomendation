module models

pub struct ResponseText {
pub mut:
	status int  @[omitempty]
	data   Data @[omitempty]
}

pub struct ExtendedTextMessage {
pub mut:
	text string @[omitempty]
}
