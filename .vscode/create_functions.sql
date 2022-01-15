CREATE OR REPLACE FUNCTION repair_bureau.insert_new_work_in_order() RETURNS TRIGGER
    AS $$
    BEGIN
        UPDATE repair_bureau.order
        SET order_estimated_service_date = repair_bureau.order.order_estimated_service_date + (SELECT w.work_execution_rate
            FROM repair_bureau.order_details d
            INNER JOIN repair_bureau.work w ON d.work_id = d.work_id
            WHERE d.order_id = NEW.order_id AND w.work_id = NEW.work_id
            GROUP BY d.order_id, w.work_id, w.work_execution_rate)
        WHERE order_id = NEW.order_id;

        RETURN NEW;
    END;
    $$ LANGUAGE 'plpgsql';

CREATE OR REPLACE FUNCTION repair_bureau.drop_work_in_order() RETURNS TRIGGER
    AS $$
    BEGIN
        UPDATE repair_bureau.order
        SET order_estimated_service_date = repair_bureau.order.order_estimated_service_date - (SELECT w.work_execution_rate
            FROM repair_bureau.order_details d
            INNER JOIN repair_bureau.work w ON d.work_id = d.work_id
            WHERE d.order_id = OLD.order_id AND w.work_id = OLD.work_id
            GROUP BY d.order_id, w.work_id, w.work_execution_rate)
        WHERE order_id = OLD.order_id;

        RETURN OLD;
    END;
    $$ LANGUAGE 'plpgsql';