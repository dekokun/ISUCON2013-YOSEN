#!/bin/bash
mysql -u isucon << EOF
use isucon;
ALTER TABLE memos add (html_content text, title text);
CREATE INDEX memos_is_private_index  ON memos(is_private);
EOF

mysql -u isucon << EOF
use isucon;
ALTER TABLE memos add index private_createdat_id(is_private,created_at,id);
ALTER TABLE memos add index user(user);
EOF

mysql -u isucon <<EOF
use isucon;
DROP TABLE IF EXISTS count_memos;
CREATE TABLE count_memos (
  id int(11),
  count int(11), 
  PRIMARY KEY (id)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8; 
INSERT INTO count_memos(id, count) VALUES(123, (SELECT count(*) from memos where is_private = 0));
alter table memos add index user_is_private_created_at(user,is_private,created_at);
EOF
