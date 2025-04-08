module logger

import os
import log
import time

@[noinit]
pub struct Logger {
pub:
	path string
	name string
mut:
	tlog &log.ThreadSafeLog
}

pub fn Logger.new(path string, name string) Logger {
	if path == '-test-' && name == '-test-' {
		return Logger{
			path: '-test-'
			name: '-test-'
			tlog: log.new_thread_safe_log()
		}
	}

	if !os.exists(path) {
		os.mkdir(path) or { panic('Failed to create directory') }
	}
	mut l := Logger{
		path: path
		name: name
		tlog: log.new_thread_safe_log()
	}
	l.resolver_path_name_file()

	return l
}

pub fn (mut logger Logger) info(msg string) {
	if logger.path == '-test-' && logger.name == '-test-' {
		return
	}
	logger.resolver_path_name_file()
	logger.tlog.info(msg)
}

pub fn (mut logger Logger) error(msg string) {
	if logger.path == '-test-' && logger.name == '-test-' {
		return
	}
	logger.tlog.error(msg)
}

pub fn (mut logger Logger) debug(msg string) {
	if logger.path == '-test-' && logger.name == '-test-' {
		return
	}
	logger.tlog.debug(msg)
}

pub fn (mut logger Logger) warn(msg string) {
	if logger.path == '-test-' && logger.name == '-test-' {
		return
	}
	logger.tlog.warn(msg)
}

fn (mut logger Logger) resolver_path_name_file() {
	path_final := resolver_path_name_file(logger.path, logger.name)

	if logger.tlog.output_file_name != path_final {
		logger.tlog.set_output_path(path_final)
	}
}

fn resolver_path_name_file(path string, name string) string {
	current_hour := '${time.now().hour}h'
	return os.join_path(path, '${name}-${current_hour}.log')
}
