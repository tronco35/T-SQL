exec sp_change_users_login @Action='report'

exec sp_change_users_login @Action='update_one',
@UserNamePattern='cs_odi',
@LoginName='cs_odi';