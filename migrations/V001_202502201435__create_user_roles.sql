CREATE LOGIN ${ADMIN_USERNAME} WITH PASSWORD = ${ADMIN_PASSWORD};
GO

CREATE USER ${ADMIN_USERNAME} FOR LOGIN ${ADMIN_USERNAME};
GO

CREATE ROLE AdminRole;
GO

GRANT CONTROL ON DATABASE::beanthere TO AdminRole;
DENY DELETE ON SCHEMA::dbo TO AdminRole;

ALTER ROLE AdminRole ADD MEMBER ${ADMIN_USERNAME};



CREATE LOGIN ${USER_USERNAME} WITH PASSWORD = ${USER_PASSWORD};
GO

CREATE USER ${USER_USERNAME} FOR LOGIN ${USER_USERNAME};
GO

CREATE ROLE ReadOnlyRole;
GO

GRANT SELECT ON SCHEMA::dbo TO ReadOnlyRole;
GO

ALTER ROLE ReadOnlyRole ADD MEMBER ${USER_USERNAME};


