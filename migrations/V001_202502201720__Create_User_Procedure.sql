CREATE PROCEDURE Create_User
    @first_name VARCHAR(50),
    @last_name VARCHAR(50),
    @email VARCHAR(150),
    @phone_number VARCHAR(15),
    @user_id INT OUTPUT
AS
BEGIN
    BEGIN TRANSACTION;

        BEGIN TRY

            DECLARE @contact_id INT
                    
            IF EXISTS (SELECT 1 FROM phone_numbers WHERE phone_number = @phone_number)
            BEGIN;
                THROW 50000, 'Phone number already exists', 1;
            END

            IF EXISTS (SELECT 1 FROM emails WHERE email = @email)
            BEGIN;
                THROW 50000, 'email already exists', 1;
            END

            INSERT INTO [contact_details] DEFAULT VALUES; 
            SET @contact_id = SCOPE_IDENTITY();

            INSERT INTO phone_numbers (phone_number, contact_id)
            VALUES (@phone_number, @contact_id);

            INSERT INTO emails (email, contact_id)
            VALUES (@email, @contact_id)

            INSERT INTO [users] (first_name, last_name, contact_id)
            VALUES (@first_name, @last_name, @contact_id);
            SET @user_id = SCOPE_IDENTITY();


            COMMIT TRANSACTION;
        END TRY
        BEGIN CATCH
            ROLLBACK TRANSACTION;
            THROW;
        END CATCH
END;
GO

