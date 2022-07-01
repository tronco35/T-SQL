Transact-SQL
EXEC dbo.sp_grant_login_to_proxy @login_name = N'DOMAIN\Account'
    , @proxy_name = 'ProxyName';




SELECT ProxyName = sp.name
    , ProxyEnabled = sp.enabled
    , CredentialName = c.name
    , CredentialIdentity = c.credential_identity
FROM dbo.sysproxies sp
    INNER JOIN sys.credentials c ON sp.credential_id = c.credential_id
ORDER BY sp.name;