DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS questions;
DROP TABLE IF EXISTS question_follows;
DROP TABLE IF EXISTS replies;
DROP TABLE IF EXISTS question_likes;

CREATE TABLE users (
  id INTEGER PRIMARY KEY,
  fname VARCHAR(255) NOT NULL,
  lname VARCHAR(255) NOT NULL
);

CREATE TABLE questions (
  id INTEGER PRIMARY KEY,
  title VARCHAR(255) NOT NULL,
  body TEXT NOT NULL,
  user_id INTEGER NOT NULL REFERENCES users(id)
);

CREATE TABLE question_follows (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  question_id INTEGER NOT NULL REFERENCES questions(id)
);

CREATE TABLE replies (
  id INTEGER PRIMARY KEY,
  question_id INTEGER NOT NULL REFERENCES questions(id),
  reply_id INTEGER REFERENCES replies(id),
  user_id INTEGER NOT NULL REFERENCES users(id),
  body TEXT NOT NULL
);

CREATE TABLE question_likes (
  id INTEGER PRIMARY KEY,
  user_id INTEGER NOT NULL REFERENCES users(id),
  question_id INTEGER NOT NULL REFERENCES questions(id)
);

INSERT INTO
  users (fname, lname)
VALUES
  ('Chris', 'Tram'),
  ('Todd', 'Smith'),
  ('Conan', 'Tzou');

INSERT INTO
  questions (title, body, user_id)
VALUES
  ('average dog weight', 'Does my dog weigh too much?', 1),
  ('life', 'Whats the meaning of life?', 2),
  ('app academy', 'man this is hard. are we done yet?', 3),
  ('san francisco', 'where is my car', 1),
  ('Whats up?', 'Just like I said in the title.', 1);

INSERT INTO
  question_follows (user_id, question_id)
VALUES
  (1, 1),
  (1, 2),
  (1, 3),
  (2, 4),
  (2, 4),
  (2, 4),
  (2, 4),
  (2, 4),
  (3, 2),
  (3, 3),
  (3, 3),
  (3, 3),
  (3, 3),
  (3, 3);

INSERT INTO
  replies (question_id, reply_id, user_id, body)
VALUES
  (1, NULL, 2, 'This is the first reply. YEs your dog is fat'),
  (1, 1, 1, 'Thats mean'),
  (3, NULL, 3, 'No were not done yet'),
  (3, 3, 1, 'man i cant wait until its over');

INSERT INTO
  question_likes (user_id, question_id)
VALUES
  (1, 2),
  (1, 4),
  (2, 4),
  (3, 4),
  (3, 4),
  (3, 3),
  (2, 2),
  (1, 1);
