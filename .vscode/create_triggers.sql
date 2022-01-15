CREATE TRIGGER tr_insert_new_work_in_order
    AFTER INSERT ON repair_bureau.order_details
    FOR EACH ROW
    EXECUTE PROCEDURE repair_bureau.insert_new_work_in_order();

CREATE TRIGGER tr_update_before_new_work_in_order
    BEFORE UPDATE ON repair_bureau.order_details
    FOR EACH ROW
    EXECUTE PROCEDURE repair_bureau.insert_new_work_in_order();

CREATE TRIGGER tr_update_after_new_work_in_order
    AFTER UPDATE ON repair_bureau.order_details
    FOR EACH ROW
    EXECUTE PROCEDURE repair_bureau.drop_work_in_order();

CREATE TRIGGER tr_drop_work_in_order
    BEFORE DELETE ON repair_bureau.order_details
    FOR EACH ROW
    EXECUTE PROCEDURE repair_bureau.drop_work_in_order();