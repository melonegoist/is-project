CREATE OR REPLACE PROCEDURE process_successful_payment(
    p_payment_id INTEGER
)
AS $$
DECLARE
    v_payment_record RECORD;
BEGIN
    -- Получаем информацию о платеже
    SELECT * INTO v_payment_record FROM payments WHERE payment_id = p_payment_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Платеж с ID % не найден.', p_payment_id;
    END IF;

    IF v_payment_record.status != 'pending' THEN
        RAISE EXCEPTION 'Платеж уже обработан.';
    END IF;

    -- Обновляем статус платежа
    UPDATE payments SET status = 'completed' WHERE payment_id = p_payment_id;

    -- В зависимости от типа платежа, подтверждаем соответствующую сущность
    IF v_payment_record.payment_type = 'course' THEN
        UPDATE course_enrollments
        SET status = 'confirmed'
        WHERE enrollment_id = v_payment_record.entity_id
        AND user_id = v_payment_record.user_id; -- Добавляем проверку на владельца

    ELSIF v_payment_record.payment_type = 'equipment' THEN
        -- Подтверждаем аренду оборудования (меняем статус, если была предварительная бронь)
        UPDATE equipment_rentals
        SET status = 'active'
        WHERE rental_id = v_payment_record.entity_id
        AND user_id = v_payment_record.user_id;
    END IF;

END;
$$ LANGUAGE plpgsql;
