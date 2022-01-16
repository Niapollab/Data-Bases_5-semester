COMMENT ON TYPE repair_bureau.rolling_stock_type IS 'Тип подвижного состава';

COMMENT ON TYPE repair_bureau.rolling_stock_type IS 'Тип заказа';

COMMENT ON TYPE repair_bureau.history_entry_type IS 'Тип записи в истории деталей';

COMMENT ON TABLE repair_bureau.rolling_stock IS 'Таблица подвижных составов';
COMMENT ON COLUMN repair_bureau.rolling_stock.rolling_stock_id IS 'Идентификатор подвижного состава';
COMMENT ON COLUMN repair_bureau.rolling_stock.rolling_stock_type IS 'Тип подвижного состава';
COMMENT ON COLUMN repair_bureau.rolling_stock.rolling_stock_chassis_num IS 'Номер шасси подвижного состава';
COMMENT ON COLUMN repair_bureau.rolling_stock.rolling_stock_registration_date IS 'Дата регистрации подвижного состава';
COMMENT ON COLUMN repair_bureau.rolling_stock.rolling_stock_mileage IS 'Пробег подвижного состава';

COMMENT ON TABLE repair_bureau.detail IS 'Таблица деталей';
COMMENT ON COLUMN repair_bureau.detail.detail_id IS 'Идентификатор детали';
COMMENT ON COLUMN repair_bureau.detail.detail_serial IS 'Серийный номер детали';
COMMENT ON COLUMN repair_bureau.detail.detail_name IS 'Название детали';

COMMENT ON TABLE repair_bureau.employee IS 'Таблица сотрудников';
COMMENT ON COLUMN repair_bureau.employee.employee_id IS 'Идентификатор сотрудника';
COMMENT ON COLUMN repair_bureau.employee.employee_first_name IS 'Имя сотрудника';
COMMENT ON COLUMN repair_bureau.employee.employee_second_name IS 'Фамилия сотрудника';
COMMENT ON COLUMN repair_bureau.employee.employee_middle_name IS 'Отчество сотрудника';
COMMENT ON COLUMN repair_bureau.employee.employee_employment_date IS 'Дата трудоустройства';

COMMENT ON TABLE repair_bureau.work IS 'Таблица с названиями работ и нормами выполнения';
COMMENT ON COLUMN repair_bureau.work.work_id IS 'Идентификатор работы';
COMMENT ON COLUMN repair_bureau.work.work_name IS 'Название работы';
COMMENT ON COLUMN repair_bureau.work.work_execution_rate IS 'Время выполнения работы';

COMMENT ON TABLE repair_bureau.storage IS 'Таблица с информацией о складе';
COMMENT ON COLUMN repair_bureau.storage.storage_id IS 'Идентификатор склада';
COMMENT ON COLUMN repair_bureau.storage.storage_name IS 'Название склада';

COMMENT ON TABLE repair_bureau.order IS 'Таблица очереди заказов. Сюда помещаются заказы, которые будут выполнены в районе заданного времени';
COMMENT ON COLUMN repair_bureau.order.order_id IS 'Идентификатор заказа в очереди';
COMMENT ON COLUMN repair_bureau.order.manager_employee_id IS 'Составитель заказа';
COMMENT ON COLUMN repair_bureau.order.rolling_stock_id IS 'Идентификатор подвижного состава заказчика';
COMMENT ON COLUMN repair_bureau.order.order_type IS 'Тип заказа';
COMMENT ON COLUMN repair_bureau.order.order_created_time IS 'Дата создания';
COMMENT ON COLUMN repair_bureau.order.order_estimated_service_date IS 'Время, в которое заказ должен быть выполнен';

COMMENT ON TABLE repair_bureau.storage_details IS 'Таблица информации о хранилище';
COMMENT ON COLUMN repair_bureau.storage_details.storage_details_id IS 'Идентификатор записи';
COMMENT ON COLUMN repair_bureau.storage_details.storage_id IS 'Идентификатор склада';
COMMENT ON COLUMN repair_bureau.storage_details.detail_id IS 'Идентификатор детали';
COMMENT ON COLUMN repair_bureau.storage_details.storage_details_count IS 'Число деталей на складе';

COMMENT ON TABLE repair_bureau.details_history IS 'Таблица истории деталей. Сюда помещаются все обновления/очистки составов деталей на складах и в резерве';
COMMENT ON COLUMN repair_bureau.details_history.details_history_id IS 'Идентификатор записи';
COMMENT ON COLUMN repair_bureau.details_history.detail_id IS 'Идентификатор детали';
COMMENT ON COLUMN repair_bureau.details_history.writer_employee_id IS 'Идентификатор автора записи';
COMMENT ON COLUMN repair_bureau.details_history.storage_id IS 'Идентификатор склада';
COMMENT ON COLUMN repair_bureau.details_history.details_history_type IS 'Тип обновления';
COMMENT ON COLUMN repair_bureau.details_history.details_history_count IS 'Число деталей на складе';

COMMENT ON TABLE repair_bureau.order_details IS 'Детали выполненных работ по заказам';
COMMENT ON COLUMN repair_bureau.order_details.order_details_id IS 'Идентификатор записи';
COMMENT ON COLUMN repair_bureau.order_details.order_id IS 'Идентификатор заказа';
COMMENT ON COLUMN repair_bureau.order_details.work_id IS 'Идентификатор работы';
COMMENT ON COLUMN repair_bureau.order_details.executor_employee_id IS 'Идентификатор сотрудника';
COMMENT ON COLUMN repair_bureau.order_details.order_details_acceptance_time IS 'Дата начала работы';
COMMENT ON COLUMN repair_bureau.order_details.order_details_closed_data IS 'Дата окончания работы';

COMMENT ON TABLE repair_bureau.order_expended IS 'Таблица израсходованных на заказ деталей';
COMMENT ON COLUMN repair_bureau.order_expended.order_expended_id IS 'Идентификатор записи';
COMMENT ON COLUMN repair_bureau.order_expended.order_details_id IS 'Идентификатор выполненной работы по заказу';
COMMENT ON COLUMN repair_bureau.order_expended.history_entry_id IS 'Запись об израсходованных деталях в таблице отчетности';