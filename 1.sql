CREATE OR REPLACE FUNCTION check_equipment_availability()
RETURNS TRIGGER AS $$
BEGIN
    -- Проверяем, нет ли пересекающихся броней для того же оборудования со статусом 'reserved' или 'active'
    IF EXISTS (
        SELECT 1 FROM equipment_rentals
        WHERE equipment_id = NEW.equipment_id
        AND status IN ('reserved', 'active')
        AND (NEW.start_date, NEW.end_date) OVERLAPS (start_date, end_date)
        AND rental_id != COALESCE(NEW.rental_id, -1) -- Исключаем текущую запись при обновлении
    ) THEN
        RAISE EXCEPTION 'Оборудование с ID % уже забронировано на указанный период.', NEW.equipment_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_check_equipment_availability
    BEFORE INSERT OR UPDATE ON equipment_rentals
    FOR EACH ROW
    EXECUTE FUNCTION check_equipment_availability();
