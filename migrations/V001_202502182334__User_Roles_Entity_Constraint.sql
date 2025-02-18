CREATE FUNCTION dbo.fn_UsersEntityExists (@entity_id UNIQUEIDENTIFIER)
RETURNS BIT
AS
BEGIN
    IF EXISTS (SELECT 1 FROM farms WHERE farm_id = @entity_id)
        RETURN 1;

    IF EXISTS (SELECT 1 FROM retailers WHERE retailer_id = @entity_id)
        RETURN 1;

    IF EXISTS (SELECT 1 FROM manufacturers WHERE manufacturer_id = @entity_id)
        RETURN 1;

    RETURN 0;
END;
GO
ALTER TABLE user_roles ADD CONSTRAINT CK_User_Roles_EntityExists CHECK (dbo.fn_UsersEntityExists(supply_chain_entity_id) = 1);