CREATE DATABASE IF NOT EXISTS todo_test CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
-- Rails parallel tests create todo_test-0, todo_test-1, etc.
GRANT ALL PRIVILEGES ON `todo\_test%`.* TO 'todo'@'%';
