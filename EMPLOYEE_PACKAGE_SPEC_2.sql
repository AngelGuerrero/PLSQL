/*=============================================================================+
   Filename: EMPLOYEE_PACKAGE_SPEC.sql
   Component: Package
   Package: EMPLOYEE_PACKAGE
   Designer: Luis �ngel De Santiago Guerrero
   Developer: Luis �ngel De Santiago Guerrero
   Version: 1.0
   Description: Paquete para el manejo de datos en la tabla employees
/*============================================================================*/


/*===================================================================+
    SPECIFICATION PACKAGE
+===================================================================*/

CREATE OR REPLACE PACKAGE EMP_PKG IS

      -- Crea un index del tipo de employees
      TYPE g_emp_type IS TABLE OF employees%rowtype
         INDEX BY PLS_INTEGER;

   /*===============================================================+
      PROCEDURE:    add_employee
      DESCRIPTION:  Agrega un empleado en la tabla employees con argumentos por defecto
      ARGUMENTS:
                  IN p_first_name Recibe el primer nombre del empleado.
                     p_last_name Recibe el apellido o apellidos del empleado.
                     p_deptid Recibe el departamento donde se encontrar� el empleado.
                     p_email Recibe el email del empleado, sin el dominio de la empresa.
                     p_job Recibe el identificador del puesto que se le asignar�.
                     p_mgr Recibe el identificador del manager que se le asignar�.
                     p_sal Recibe el salario que el empleado tendr�.
                     p_commission Recibe la cantidad de comisi�n que el empleado ganar�.
                     p_hd Recibe la fecha en la que el empleado se contrat�, si no se especifica
                          el procidimiento toma la fecha cuando se ejecut� el procedimiento.

                  OUT

      RETURNS:      N/A
      NOTES:

      HISTORY
      Version     Date         Author                    Change Reference
      1.0         21/03/2018   �ngel Guerrero.           1. Creaci�n del procedimiento.
   +================================================================*/
   PROCEDURE add_employee(
                          p_first_name IN employees.first_name%TYPE DEFAULT '',
                          p_last_name IN employees.last_name%TYPE DEFAULT '',
                          p_deptid IN employees.department_id%TYPE DEFAULT 30,
                          p_email IN employees.email%TYPE DEFAULT '',
                          p_job IN employees.job_id%TYPE DEFAULT 'SA_REP',
                          p_mgr IN employees.manager_id%TYPE DEFAULT 145,
                          p_sal IN employees.salary%TYPE DEFAULT 1000,
                          p_commission IN employees.commission_pct%TYPE DEFAULT 0,
                          p_hd IN employees.hire_date%TYPE DEFAULT TRUNC(SYSDATE)
                         );


   /*===============================================================+
      PROCEDURE:    add_employee
      DESCRIPTION:  Agrega un empleado aceptando s�lo unos cu�ntos par�metros.
      ARGUMENTS:
                  IN p_deptid Recibe el identificador del departamento donde se
                              asignar� al empleado a registrar.
                     p_first_name Recibe el nombre del empleado.
                     p_last_name Recibe el apellido del empleado.

                  OUT

      RETURNS:      N/A
      NOTES:        En este procedimiento se reciben los anteriores par�metros,
                    mas sin embargo, internamente se llama a otra funci�n para
                    agregar un empleado, manda llamar al procedimiento que recibe
                    todos los parametros para agregar un empleado.


      HISTORY
      Version     Date         Author                    Change Reference
      1.0         21/03/2018   �ngel Guerrero.           1. Creaci�n de procedimiento.
   +================================================================*/
   PROCEDURE add_employee(
                          p_deptid IN employees.department_id%TYPE,
                          p_first_name IN employees.first_name%TYPE,
                          p_last_name IN employees.last_name%TYPE
                        );


   /*===============================================================+
      PROCEDURE:    get_employee
      DESCRIPTION:  Obtiene un empleado de acuerdo a un identificador
      ARGUMENTS:
                  IN p_emp_id Recibe el identificador del empleado a buscar
                              dentro del procedimiento.

                  OUT x_emp_sal Almacena el salario del empleado a buscar.
                      x_emp_job_id Almacena el puesto del empleado a buscar.

      RETURNS:      N/A
      NOTES:

      HISTORY
      Version     Date         Author                    Change Reference
      1.0         21/03/2018   �ngel Guerrero.           1. Creaci�n del procedimiento
   +================================================================*/
   PROCEDURE get_employee(
                          p_emp_id IN employees.employee_id%TYPE DEFAULT NULL,
                          x_emp_sal OUT employees.salary%TYPE,
                          x_emp_job_id OUT employees.job_id%TYPE
                         );


   /*===============================================================+
      FUNCTION:    get_employee
      DESCRIPTION:  Obtiene un empleado seg�n el identificador del empleado.
      ARGUMENTS:
                  IN p_emp_id Almacena un valor de tipo employee_id de la tabla
                            employees.


                  OUT

      RETURNS:      employees%ROWTYPE
      NOTES:

      HISTORY
      Version     Date         Author                    Change Reference
      1.0         21/03/2018   �ngel Guerrero.           1. Creaci�n de la funci�n.
   +================================================================*/
   FUNCTION get_employee(p_emp_id IN employees.employee_id%TYPE)
      RETURN employees%ROWTYPE;


   /*===============================================================+
      FUNCTION:    get_employee
      DESCRIPTION:  Obtiene el empleado seg�n el apellido de �ste.
      ARGUMENTS:
                  IN p_family_name Almacena el apellido del empleado.

                  OUT

      RETURNS:      employees%ROWTYPE
      NOTES:

      HISTORY
      Version     Date         Author                    Change Reference
      1.0         21/03/2018   �ngel Guerrero.           1. Creaci�n de la funci�n.
   +================================================================*/
   FUNCTION get_employee(p_family_name IN employees.last_name%TYPE)
      RETURN employees%ROWTYPE;


   /*===============================================================+
      FUNCTION:    print_employee
      DESCRIPTION:  Imprime los datos de un empleado.
      ARGUMENTS:
                  IN p_employee Recibe un empleado de tipo employees.

                  OUT

      RETURNS:      VARCHAR2
      NOTES:

      HISTORY
      Version     Date         Author                    Change Reference
      1.0         21/03/2018   �ngel Guerrero.           1. Creaci�n de la funci�n.
   +================================================================*/
   FUNCTION print_employee(p_employee IN employees%ROWTYPE)
      RETURN VARCHAR2;


   /*===============================================================+
      PROCEDURE:    init_depts
      DESCRIPTION:  Procedimiento que crea una tabla en el esquema de ORA01
      ARGUMENTS:
                  IN

                  OUT

      RETURNS:      N/A
      NOTES:         Este procedimiento llama a una funci�n despu�s de que crea
                     una tabla para llenarla con datos v�lidos.

      HISTORY
      Version     Date         Author                    Change Reference
      1.0         21/03/2018   �ngel Guerrero.           1. Creacion del procedimiento
   +================================================================*/
   PROCEDURE init_depts;


   PROCEDURE get_employees(p_dept_id employees.department_id%type);
   
   
   PROCEDURE show_employees;

END EMP_PKG;
