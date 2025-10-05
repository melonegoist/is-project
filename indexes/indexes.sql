-- 1. Поиск пользователя по email
CREATE INDEX idx_users_email ON users(email);

-- 2. Получение курсов преподавателя (Личный кабинет преподавателя)
CREATE INDEX idx_courses_teacher_id ON courses(teacher_id);

-- 3. Получение записей студента на курсы (Личный кабинет студента)
CREATE INDEX idx_enrollments_user_id ON course_enrollments(user_id);
CREATE INDEX idx_enrollments_course_id ON course_enrollments(course_id);

-- 4. Получение занятий по курсу и дате (Планирование)
CREATE INDEX idx_lessons_course_id_time ON lessons(course_id, start_time);

-- 5. Поиск доступного оборудования по типу (Каталог оборудования)
CREATE INDEX idx_equipment_type_status ON equipment(type, status) WHERE status = 'available';

-- 6. Получение аренды пользователя (Личный кабинет)
CREATE INDEX idx_rentals_user_id ON equipment_rentals(user_id);
CREATE INDEX idx_rentals_equipment_id ON equipment_rentals(equipment_id);

-- 7. Проверка доступности оборудования
CREATE INDEX idx_rentals_equipment_dates_status ON equipment_rentals(equipment_id, status, start_date, end_date);
