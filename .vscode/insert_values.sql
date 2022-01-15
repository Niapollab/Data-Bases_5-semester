INSERT INTO repair_bureau.rolling_stock (
    rolling_stock_type,
    rolling_stock_chassis_num,
    rolling_stock_registration_date,
    rolling_stock_mileage) VALUES
        ('carriage', 123, CURRENT_TIMESTAMP, 235235),
        ('truck', 535, CURRENT_TIMESTAMP, 423523),
        ('trailer', 764, CURRENT_TIMESTAMP, 6236),
        ('truck', 124, CURRENT_TIMESTAMP, 3523626),
        ('semitrailer', 653, CURRENT_TIMESTAMP, 214125);

INSERT INTO repair_bureau.detail (
    detail_serial,
    detail_name) VALUES
        (124125, 'Detail 1'),
        (125125, 'Detail 2'),
        (46757, 'Detail 3'),
        (346347, 'Detail 4'),
        (53734734, 'Detail 5'),
        (7346543, 'Detail 6'),
        (35768, 'Detail 7'),
        (4363578, 'Detail 8'),
        (436347, 'Detail 9'),
        (579856, 'Detail 10');

INSERT INTO repair_bureau.employee (
    employee_first_name,
    employee_second_name,
    employee_middle_name) VALUES
        ('Путин', 'Владимир', 'Владимирович'),
        ('Пушкин', 'Александр', 'Сергеевич'),
        ('Паровозов', 'Аркадий', 'Аркадиевич');

INSERT INTO repair_bureau.work (
    work_name,
    work_execution_rate) VALUES
        ('Поменять колеса', '04:00:00'),
        ('Поменять масло', '02:00:00'),
        ('Постучать по капоту с умным видом', '00:02:00'),
        ('Пожать плечами', '00:00:15'),
        ('Попить чай', '12:00:00');

INSERT INTO repair_bureau.storage (
    storage_name) VALUES
        ('Storage 1'),
        ('Storage 2');

INSERT INTO repair_bureau.order (
    manager_employee_id,
    rolling_stock_id,
    order_type) VALUES
        (1, 1, 'planned'),
        (1, 3, 'unplanned'),
        (1, 3, 'planned'),
        (1, 5, 'unplanned'),
        (1, 2, 'planned');
        
INSERT INTO repair_bureau.storage_details (
    storage_id,
    detail_id,
    storage_details_count) VALUES
        (1, 1, 124),
        (2, 1, 253),
        (1, 2, 24),
        (2, 2, 523),
        (1, 3, 35),
        (2, 3, 57),
        (1, 4, 457),
        (2, 4, 854),
        (1, 5, 35),
        (2, 5, 23),
        (1, 6, 535),
        (2, 6, 532),
        (1, 7, 12),
        (2, 7, 125),
        (1, 8, 54),
        (2, 8, 98),
        (1, 9, 588),
        (2, 9, 346),
        (1, 10, 124),
        (2, 10, 201);

INSERT INTO repair_bureau.details_history (
    detail_id,
    writer_employee_id,
    storage_id,
    details_history_type,
    details_history_count) VALUES
        (1, 2, 1, 'repair', 3),
        (2, 2, 2, 'repair', 4),
        (3, 2, 2, 'repair', 1),
        (2, 3, 1, 'repair', 5),
        (2, 3, 2, 'repair', 3),
        (3, 2, 1, 'repair', 4),
        (4, 3, 2, 'repair', 2),
        (5, 3, 2, 'repair', 4),
        (5, 3, 1, 'repair', 4);

INSERT INTO repair_bureau.order_details (
    order_id,
    work_id,
    executor_employee_id) VALUES
        (1, 2, 2),
        (1, 3, 2),
        (1, 5, 2),
        (2, 1, 3),
        (2, 4, 3),
        (3, 1, 2),
        (3, 3, 3),
        (4, 2, 3),
        (5, 5, 3);

INSERT INTO repair_bureau.order_expended (
    order_details_id,
    history_entry_id) VALUES
        (1, 1),
        (1, 2),
        (1, 3),
        (2, 4),
        (2, 5),
        (3, 6),
        (4, 7),
        (5, 8),
        (5, 9);