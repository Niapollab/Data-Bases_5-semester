CREATE TYPE repair_bureau.rolling_stock_type AS ENUM (
	'truck',
	'passenger',
	'carriage',
	'trailer',
	'semitrailer'
);
COMMENT ON TYPE repair_bureau.rolling_stock_type IS 'Тип подвижного состава';

CREATE TYPE repair_bureau.history_entry_type AS ENUM (
	'disposal',
	'write-off',
	'repair',
	'acceptance'
);
COMMENT ON TYPE repair_bureau.history_entry_type IS 'Тип записи в истории деталей';

CREATE TABLE repair_bureau.detail (
	id bigserial NOT NULL,
	serial bigint NOT NULL,
	name text NOT NULL,

	CONSTRAINT detail_pk PRIMARY KEY (id)
);
COMMENT ON TABLE repair_bureau.detail IS 'Таблица деталей';
COMMENT ON COLUMN repair_bureau.detail.id IS 'Идентификатор детали';
COMMENT ON COLUMN repair_bureau.detail.serial IS 'Серийный номер детали';
COMMENT ON COLUMN repair_bureau.detail.name IS 'Название детали';

CREATE TABLE repair_bureau.rolling_stock (
	id bigserial NOT NULL,

	type repair_bureau.rolling_stock_type NOT NULL,
	chassis_num integer NOT NULL,
	registration_date timestamp NOT NULL,
	mileage integer NOT NULL,

	CONSTRAINT rolling_stock_pk PRIMARY KEY (id)
);
COMMENT ON TABLE repair_bureau.rolling_stock IS 'Таблица подвижных составов';
COMMENT ON COLUMN repair_bureau.rolling_stock.id IS 'Идентификатор подвижного состава';
COMMENT ON COLUMN repair_bureau.rolling_stock.type IS 'Тип подвижного состава';
COMMENT ON COLUMN repair_bureau.rolling_stock.chassis_num IS 'Номер шасси подвижного состава';
COMMENT ON COLUMN repair_bureau.rolling_stock.registration_date IS 'Дата регистрации подвижного состава';
COMMENT ON COLUMN repair_bureau.rolling_stock.mileage IS 'Пробег подвижного состава';

CREATE TABLE repair_bureau.employee (
	id bigserial NOT NULL,

	first_name varchar(255) NOT NULL,
	second_name varchar(255) NOT NULL,
	middle_name varchar(255) NOT NULL,
	employment_date timestamp NOT NULL,

	CONSTRAINT employee_pk PRIMARY KEY (id)
);
COMMENT ON TABLE repair_bureau.employee IS 'Таблица сотрудников';
COMMENT ON COLUMN repair_bureau.employee.id IS 'Идентификатор сотрудника';
COMMENT ON COLUMN repair_bureau.employee.first_name IS 'Имя сотрудника';
COMMENT ON COLUMN repair_bureau.employee.second_name IS 'Фамилия сотрудника';
COMMENT ON COLUMN repair_bureau.employee.middle_name IS 'Отчество сотрудника';
COMMENT ON COLUMN repair_bureau.employee.employment_date IS 'Дата трудоустройства';

CREATE TABLE repair_bureau.maintenance_order (
	id bigserial NOT NULL,
	id_rolling_stock bigserial,

	name text NOT NULL,
	is_planned boolean NOT NULL,
	estimated_service_date timestamp NOT NULL,

	CONSTRAINT maintenance_order_pk PRIMARY KEY (id),
	CONSTRAINT maintenance_order_fk0 FOREIGN KEY (id_rolling_stock) REFERENCES repair_bureau.rolling_stock(id) ON DELETE SET NULL
);
COMMENT ON TABLE repair_bureau.maintenance_order IS 'Таблица очереди заказов. Сюда помещаются заказы, которые будут выполнены в районе заданного времени';
COMMENT ON COLUMN repair_bureau.maintenance_order.id IS 'Идентификатор заказа в очереди';
COMMENT ON COLUMN repair_bureau.maintenance_order.id_rolling_stock IS 'Идентификатор подвижного состава заказчика';
COMMENT ON COLUMN repair_bureau.maintenance_order.name IS 'Название работы';
COMMENT ON COLUMN repair_bureau.maintenance_order.is_planned IS 'Является ли работа запланированной или вынужденной';
COMMENT ON COLUMN repair_bureau.maintenance_order.estimated_service_date IS 'Время, в которое заказ должен быть выполнен';

CREATE TABLE repair_bureau.maintenance_report (
	id bigserial NOT NULL,
	id_order bigserial NOT NULL,
	id_executor bigserial,

	closing_date timestamp NOT NULL,

	CONSTRAINT maintenance_report_pk PRIMARY KEY (id),
	CONSTRAINT maintenance_report_fk0 FOREIGN KEY (id_order) REFERENCES repair_bureau.maintenance_order(id) ON DELETE CASCADE,
	CONSTRAINT maintenance_report_fk1 FOREIGN KEY (id_executor) REFERENCES repair_bureau.employee(id) ON DELETE SET NULL,

	CONSTRAINT unique_order_and_executor UNIQUE (id_order, id_executor)
);
COMMENT ON TABLE repair_bureau.maintenance_report IS 'Таблица выполненных отчетов о заказах';
COMMENT ON COLUMN repair_bureau.maintenance_report.id IS 'Идентификатор выполненного отчета о заказе';
COMMENT ON COLUMN repair_bureau.maintenance_report.id_order IS 'Идентификатор заказа в очереди';
COMMENT ON COLUMN repair_bureau.maintenance_report.id_executor IS 'Исполнитель заказа';
COMMENT ON COLUMN repair_bureau.maintenance_report.closing_date IS 'Время закрытия заказа';

CREATE TABLE repair_bureau.details_history (
	id bigserial NOT NULL,
	detail_id bigserial NOT NULL,
	id_writer bigserial,

	type repair_bureau.history_entry_type NOT NULL,
	
	count integer NOT NULL,

	CONSTRAINT details_history_pk PRIMARY KEY (id),
	CONSTRAINT details_history_fk0 FOREIGN KEY (detail_id) REFERENCES repair_bureau.detail(id) ON DELETE RESTRICT,
	CONSTRAINT details_history_fk1 FOREIGN KEY (id_writer) REFERENCES repair_bureau.employee(id) ON DELETE SET NULL
);
COMMENT ON TABLE repair_bureau.details_history IS 'Таблица истории деталей. Сюда помещаются все обновления/очистки составов деталей на складах и в резерве';
COMMENT ON COLUMN repair_bureau.details_history.id IS 'Идентификатор записи';
COMMENT ON COLUMN repair_bureau.details_history.id_writer IS 'Идентификатор автора записи';
COMMENT ON COLUMN repair_bureau.details_history.type IS 'Тип обновления';
COMMENT ON COLUMN repair_bureau.details_history.detail_id IS 'Идентификатор номер детали';
COMMENT ON COLUMN repair_bureau.details_history.count IS 'Число деталей на складе';

CREATE TABLE repair_bureau.expended_resources (
	id_report bigserial,
	id_details_history_entry bigserial NOT NULL,

	CONSTRAINT expended_resources_fk0 FOREIGN KEY (id_report) REFERENCES repair_bureau.maintenance_report(id) ON DELETE SET NULL,
	CONSTRAINT expended_resources_fk1 FOREIGN KEY (id_details_history_entry) REFERENCES repair_bureau.details_history(id) ON DELETE RESTRICT,

	CONSTRAINT unique_report_and_details_history_entry UNIQUE (id_report, id_details_history_entry)
);
COMMENT ON TABLE repair_bureau.expended_resources IS 'Таблица израсходованных на заказ деталей';
COMMENT ON COLUMN repair_bureau.expended_resources.id_report IS 'Идентификатор отчета';
COMMENT ON COLUMN repair_bureau.expended_resources.id_details_history_entry IS 'Запись об израсходованных деталях в таблице отчетности';

CREATE TABLE repair_bureau.remote_resources (
	detail_id bigserial NOT NULL,
	storage bigserial NOT NULL,
	count integer NOT NULL,

	CONSTRAINT remote_resources_fk0 FOREIGN KEY (detail_id) REFERENCES repair_bureau.detail(id) ON DELETE RESTRICT,
	CONSTRAINT unique_detail_serial_and_storage UNIQUE (detail_id, storage)
);
COMMENT ON TABLE repair_bureau.remote_resources IS 'Таблица ресурсов на удаленных складах';
COMMENT ON COLUMN repair_bureau.remote_resources.detail_id IS 'Идентификатор номер детали';
COMMENT ON COLUMN repair_bureau.remote_resources.count IS 'Число деталей';
COMMENT ON COLUMN repair_bureau.remote_resources.storage IS 'Идентификатор склада';