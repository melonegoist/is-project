INSERT INTO users (email, password_hash, role, first_name, last_name, email_verified) VALUES
('student1@mail.com', 'hash1', 'student', 'Иван', 'Петров', true),
('teacher1@mail.com', 'hash2', 'teacher', 'Анна', 'Сидорова', true),
('admin1@mail.com', 'hash3', 'admin', 'Админ', 'Админов', true);

INSERT INTO profiles (user_id, phone, bio) VALUES
(2, '+79111111111', 'Опытный фотограф с 10-летним стажем.');

INSERT INTO locations (name, address) VALUES
('Студия на Тверской', 'г. Москва, ул. Тверская, д. 1'),
('Онлайн', 'Онлайн');

INSERT INTO courses (title, description, format, skill_level, teacher_id, location_id) VALUES
('Основы фотографии', 'Курс для начинающих.', 'hybrid', 'beginner', 2, 1),
('Портретная съемка', 'Продвинутый курс по портретам.', 'online', 'advanced', 2, 2);

INSERT INTO course_enrollments (user_id, course_id, status) VALUES
(1, 1, 'confirmed');

INSERT INTO lessons (course_id, title, start_time, duration_minutes, location_id) VALUES
(1, 'Первое занятие: Экспозиция', CURRENT_TIMESTAMP + INTERVAL '2 days', 90, 1);

INSERT INTO equipment (name, type, status) VALUES
('Canon EOS R5', 'camera', 'available'),
('Sony FE 24-70mm f/2.8 GM', 'lens', 'available');

INSERT INTO equipment_rentals (user_id, equipment_id, start_date, end_date, status) VALUES
(1, 1, CURRENT_TIMESTAMP + INTERVAL '1 day', CURRENT_TIMESTAMP + INTERVAL '3 days', 'reserved');

INSERT INTO payments (user_id, amount, status, payment_type, entity_id) VALUES
(1, 15000.00, 'completed', 'course', 1),
(1, 5000.00, 'completed', 'equipment', 1);
