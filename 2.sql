CREATE OR REPLACE FUNCTION update_equipment_status()
RETURNS TRIGGER AS $$
BEGIN
    -- При создании новой аренды или изменении статуса аренды
    IF (TG_OP = 'INSERT' AND NEW.status IN ('reserved', 'active')) OR
       (TG_OP = 'UPDATE' AND NEW.status != OLD.status) THEN

        IF NEW.status IN ('reserved', 'active') THEN
            UPDATE equipment SET status = 'rented' WHERE equipment_id = NEW.equipment_id;
        ELSIF NEW.status IN ('completed', 'cancelled') THEN
            UPDATE equipment SET status = 'available' WHERE equipment_id = NEW.equipment_id;
        END IF;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER trigger_update_equipment_status
    AFTER INSERT OR UPDATE ON equipment_rentals
    FOR EACH ROW
    EXECUTE FUNCTION update_equipment_status();
