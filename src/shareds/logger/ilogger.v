module logger

@[noinit]
pub interface ILogger {
	path string
	name string
mut:
	info(msg string)
	error(msg string)
	debug(msg string)
	warn(msg string)
}
