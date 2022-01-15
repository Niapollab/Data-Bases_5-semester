CREATE TYPE repair_bureau.rolling_stock_type AS ENUM (
	'truck',
	'passenger',
	'carriage',
	'trailer',
	'semitrailer'
);

CREATE TYPE repair_bureau.order_type AS ENUM (
	'planned',
	'unplanned'
);

CREATE TYPE repair_bureau.history_entry_type AS ENUM (
	'disposal',
	'write-off',
	'repair',
	'acceptance'
);

CREATE TABLE repair_bureau.rolling_stock (
	rolling_stock_id BIGSERIAL NOT NULL,

	rolling_stock_type repair_bureau.rolling_stock_type NOT NULL,
	rolling_stock_chassis_num INTEGER NOT NULL,
	rolling_stock_registration_date TIMESTAMP NOT NULL,
	rolling_stock_mileage INTEGER NOT NULL,

	CONSTRAINT rolling_stock_pk PRIMARY KEY (rolling_stock_id)
);

CREATE TABLE repair_bureau.detail (
	detail_id BIGSERIAL NOT NULL,

	detail_serial BIGINT NOT NULL,
	detail_name VARCHAR(255) NOT NULL,

	CONSTRAINT detail_pk PRIMARY KEY (detail_id)
);

CREATE TABLE repair_bureau.employee (
	employee_id BIGSERIAL NOT NULL,

	employee_first_name VARCHAR(255) NOT NULL,
	employee_second_name VARCHAR(255) NOT NULL,
	employee_middle_name VARCHAR(255),
	employee_employment_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT employee_pk PRIMARY KEY (employee_id)
);

CREATE TABLE repair_bureau.work (
	work_id BIGSERIAL NOT NULL,

	work_name VARCHAR(255) NOT NULL,
	work_execution_rate INTERVAL NOT NULL,

	CONSTRAINT work_pk PRIMARY KEY (work_id)
);

CREATE TABLE repair_bureau.storage (
	storage_id BIGSERIAL NOT NULL,

	storage_name VARCHAR(255) NOT NULL,

	CONSTRAINT storage_pk PRIMARY KEY (storage_id)
);

CREATE TABLE repair_bureau.order (
	order_id BIGSERIAL NOT NULL,

	manager_employee_id BIGINT,
	rolling_stock_id BIGINT,

	order_type repair_bureau.order_type NOT NULL DEFAULT 'unplanned',
	order_created_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	order_estimated_service_date TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT order_pk PRIMARY KEY (order_id),
	CONSTRAINT order_fk0 FOREIGN KEY (manager_employee_id) REFERENCES repair_bureau.employee(employee_id) ON DELETE SET NULL,
	CONSTRAINT order_fk1 FOREIGN KEY (rolling_stock_id) REFERENCES repair_bureau.rolling_stock(rolling_stock_id) ON DELETE SET NULL
);

CREATE TABLE repair_bureau.storage_details (
	storage_details_id BIGSERIAL NOT NULL,

	storage_id BIGINT NOT NULL,
	detail_id BIGINT NOT NULL,

	storage_details_count INTEGER NOT NULL,

	CONSTRAINT storage_details_pk PRIMARY KEY (storage_details_id),
	CONSTRAINT storage_details_fk0 FOREIGN KEY (storage_id) REFERENCES repair_bureau.storage(storage_id),
	CONSTRAINT storage_details_fk1 FOREIGN KEY (detail_id) REFERENCES repair_bureau.detail(detail_id),
	CONSTRAINT unique_storage_id_and_detail_id UNIQUE (storage_id, detail_id)
);

CREATE TABLE repair_bureau.details_history (
	details_history_id BIGSERIAL NOT NULL,

	detail_id BIGINT NOT NULL,
	writer_employee_id BIGINT,
	storage_id BIGINT,

	details_history_type repair_bureau.history_entry_type NOT NULL,
	details_history_count INTEGER NOT NULL,

	CONSTRAINT details_history_pk PRIMARY KEY (details_history_id),
	CONSTRAINT details_history_fk0 FOREIGN KEY (detail_id) REFERENCES repair_bureau.detail(detail_id),
	CONSTRAINT details_history_fk1 FOREIGN KEY (writer_employee_id) REFERENCES repair_bureau.employee(employee_id) ON DELETE SET NULL,
	CONSTRAINT details_history_fk2 FOREIGN KEY (storage_id) REFERENCES repair_bureau.storage(storage_id)
);

CREATE TABLE repair_bureau.order_details (
	order_details_id BIGSERIAL NOT NULL,

	order_id BIGINT NOT NULL,
	work_id BIGINT NOT NULL,
	executor_employee_id BIGINT,

	order_details_acceptance_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	order_details_closed_data TIMESTAMP,

	CONSTRAINT order_details_pk PRIMARY KEY (order_details_id),
	CONSTRAINT order_details_fk0 FOREIGN KEY (order_id) REFERENCES repair_bureau.order(order_id),
	CONSTRAINT order_details_fk1 FOREIGN KEY (work_id) REFERENCES repair_bureau.work(work_id),
	CONSTRAINT order_details_fk2 FOREIGN KEY (executor_employee_id) REFERENCES repair_bureau.employee(employee_id) ON DELETE SET NULL,
	CONSTRAINT unique_order_id_and_work_id UNIQUE (order_id, work_id)
);

CREATE TABLE repair_bureau.order_expended (
	order_expended_id BIGSERIAL NOT NULL,

	order_details_id BIGINT NOT NULL,
	history_entry_id BIGINT NOT NULL,

	CONSTRAINT order_expended_pk PRIMARY KEY (order_expended_id),
	CONSTRAINT order_expended_fk0 FOREIGN KEY (order_details_id) REFERENCES repair_bureau.order_details(order_details_id),
	CONSTRAINT order_expended_fk1 FOREIGN KEY (history_entry_id) REFERENCES repair_bureau.details_history(details_history_id),
	CONSTRAINT unique_order_details_id_and_history_entry_id UNIQUE (order_details_id, history_entry_id)
);