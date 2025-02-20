CREATE PROCEDURE Create_User_Roles
    @role_id INT,
    @user_id INT,
    @supply_chain_entity_id UNIQUEIDENTIFIER,
    @supply_chain_type_id INT
AS
BEGIN

  INSERT INTO user_roles (user_id, role_id, supply_chain_type_id, supply_chain_entity_id) 
  VALUES (@user_id, @role_id, @supply_chain_type_id, @supply_chain_entity_id)

END;
GO

