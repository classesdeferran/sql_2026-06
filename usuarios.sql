# Usuario activo
SELECT USER();

# Eliminación de usuarios
DROP USER IF EXISTS 'clinica_auxiliar'@'localhost';


# Creación de usuarios
CREATE USER IF NOT EXISTS
	'clinica_admin'@'%' IDENTIFIED BY 'admin',
	'clinica_auxiliar'@'localhost' IDENTIFIED BY 'auxiliar';

# Concesión de permisos
# todos los permisos    
GRANT ALL PRIVILEGES ON clinica.* TO 'clinica_admin'@'%';
# sólo algunos permisos
GRANT SELECT, INSERT, UPDATE ON clinica.* TO 'clinica_auxiliar'@'localhost';

# Retirar permisos
REVOKE SELECT ON clinica.* FROM 'clinica_auxiliar'@'localhost';
REVOKE ALL PRIVILEGES, GRANT OPTION FROM 'clinica_auxiliar'@'localhost';

GRANT EXECUTE ON PROCEDURE clinica.crear_consulta TO 'clinica_auxiliar'@'localhost';
GRANT EXECUTE ON clinica.* TO 'clinica_auxiliar'@'localhost';

# Ver los permisos de un usuario
SHOW GRANTS FOR 'clinica_auxiliar'@'localhost';
SHOW GRANTS FOR 'clinica_admin'@'%';

# Asignar al usuario solo permisos para utilizar las vistas
GRANT SELECT ON clinica.vista_doctores TO 'clinica_auxiliar'@'localhost';
GRANT SELECT ON clinica.usuarios_consultas_doctores TO 'clinica_auxiliar'@'localhost';

# Crear usuarios individuales de la base de datos (no roles, como admin o auxiliar) 
# mediante vistas les concedemos permisos de acceso SOLO a sus propios datos,
# no a los de otros usuarios 
CREATE USER 'LELT-8259'@'localhost' IDENTIFIED BY 'peterparker';
GRANT SELECT ON clinica.usuarios_consultas_personalizada TO 'LELT-8259'@'localhost';
CREATE USER 'SJPB-3489'@'localhost' IDENTIFIED BY 'peterparker';
GRANT SELECT ON clinica.usuarios_consultas_personalizada TO 'SJPB-3489'@'localhost';

