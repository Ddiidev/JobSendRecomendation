module db

import os
import orm
import db.pg
import db.sqlite
import shareds.conf_env
import entities as contacts_entities

pub struct ConnectionDb {
pub:
	conn       orm.Connection
	current_db ?CurrentDb
mut:
	db_sqlite sqlite.DB
	db_pg     pg.DB
}

pub enum CurrentDb {
	sqlite
	pg
}

const executable = os.executable().split(os.path_separator)#[-1..][0]

fn init() {
	mut db := ConnectionDb.new() or { panic(err.str()) }
	if db.current_db == ?CurrentDb(.sqlite) {
		return
	}

	sql db.conn {
		create table contacts_entities.Contact
	} or { panic(err.str()) }

	db.close()
}

pub fn ConnectionDb.new() !ConnectionDb {
	$if test {
		conn := new_mock()!
		return ConnectionDb{
			current_db: .sqlite
			conn:       conn
			db_sqlite:  conn
		}
	} $else {
		conn := new()!
		return ConnectionDb{
			current_db: .pg
			conn:       conn
			db_pg:      conn
		}
	}
}

pub fn (mut cc ConnectionDb) close() {
	match cc.current_db or { return } {
		.sqlite {
			cc.db_sqlite.close() or {}
		}
		.pg {
			cc.db_pg.close()
		}
	}
}

pub fn (cc ConnectionDb) execute(command string) ! {
	match cc.current_db or { return } {
		.sqlite {
			cc.db_sqlite.exec(command)!
		}
		.pg {
			cc.db_pg.exec(command)!
		}
	}
}

fn new() !pg.DB {
	env := conf_env.load_env()

	conf := pg.Config{
		host:     env.host_db
		port:     env.port_db.int()
		user:     env.user_db
		password: env.pass_db
		dbname:   env.name_db
	}

	return pg.connect(conf)!
}

fn new_mock() !sqlite.DB {
	os.mkdir('./db_mock') or {}
	db := sqlite.connect('./db_mock/${executable}_test_db.sqlite')!

	sql db {
		create table contacts_entities.Contact
	} or { panic(err.str()) }

	return db
}

pub fn clear_db_enviroment_test() {
	mut db := ConnectionDb.new() or { panic(err.str()) }

	db.close()

	if os.exists('./db_mock/${executable}_test_db.sqlite') {
		os.rm('./db_mock/${executable}_test_db.sqlite') or {}
	}
}
