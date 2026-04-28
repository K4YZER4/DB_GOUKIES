CREATE EXTENSION IF NOT EXISTS pgcrypto;
CREATE PROCEDURE "userSchema".controlUsuario(
    IN op INT,
    INOUT p_id uuid ,
    IN p_nombre varchar ,
    IN p_correoElectronico varchar ,
    IN p_contrasenaHash varchar ,
    IN p_monedaCodigo char(3) ,
    INOUT p_cursor refcursor
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF op = 1 THEN
        IF p_id IS NULL THEN
            p_id := gen_random_uuid();
        END IF;
        INSERT INTO "userSchema".usuario (id, nombre, correoElectronico, "contraseñaHash", monedaCodigo)
        VALUES (p_id, p_nombre, p_correoElectronico, p_contrasenaHash, COALESCE(p_monedaCodigo,'MXN'));
        OPEN p_cursor FOR SELECT * FROM "userSchema".usuario WHERE id = p_id;

    ELSIF op = 2 THEN
        IF p_id IS NULL THEN
            OPEN p_cursor FOR SELECT * FROM "userSchema".usuario;
        ELSE
            OPEN p_cursor FOR SELECT * FROM "userSchema".usuario WHERE id = p_id;
        END IF;

    ELSIF op = 3 THEN
        UPDATE "userSchema".usuario
        SET nombre = COALESCE(p_nombre, nombre),
            correoElectronico = COALESCE(p_correoElectronico, correoElectronico),
            "contraseñaHash" = COALESCE(p_contrasenaHash, "contraseñaHash"),
            monedaCodigo = COALESCE(p_monedaCodigo, monedaCodigo)
        WHERE id = p_id;
        OPEN p_cursor FOR SELECT * FROM "userSchema".usuario WHERE id = p_id;

    ELSIF op = 4 THEN
        DELETE FROM "userSchema".usuario WHERE id = p_id;
        OPEN p_cursor FOR SELECT 'deleted'::text AS status, p_id::text AS id;

    ELSE
        RAISE EXCEPTION 'Acción desconocida: %', op;
    END IF;
END;
$$;