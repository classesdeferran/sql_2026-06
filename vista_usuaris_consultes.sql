CREATE 
    ALGORITHM = UNDEFINED 
    DEFINER = `root`@`localhost` 
    SQL SECURITY DEFINER
VIEW `clinica3`.`usuarios_consultas_doctores` AS
    SELECT 
        CONCAT(`u`.`nombre_usuario`,
                ' ',
                `u`.`apellido_usuario`) AS `usuario`,
        `u`.`fecha_nacimiento` AS `fecha_nacimiento`,
        `u`.`dni` AS `dni`,
        `p`.`nombre_poblacion` AS `nombre_poblacion`,
        COALESCE(`u`.`tel_movil`,
                `u`.`tel_fijo`,
                'No tenemos datos de contacto') AS `contacto`,
        `c`.`fecha_concertada` AS `fecha_concertada`,
        CONCAT(`d`.`nombre_doctor`,
                ' ',
                `d`.`apellido_doctor`) AS `doctor`,
        `d`.`especialidad` AS `especialidad`
    FROM
        (((`clinica3`.`poblaciones` `p`
        JOIN `clinica3`.`usuarios` `u` ON ((`p`.`id_poblacion` = `u`.`id_poblacion`)))
        JOIN `clinica3`.`consultas` `c` ON ((`u`.`id_usuario` = `c`.`id_usuario`)))
        JOIN `clinica3`.`doctores` `d` ON ((`c`.`id_doctor` = `d`.`id_doctor`)))