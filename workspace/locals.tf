locals {
  safe_user_names = { for u in databricks_user.users: u.user_name => {
      user_name: u.user_name,
      safe_user_name: replace(replace(replace(split("@", u.user_name)[0], ".", "_"), "-", "_"), "+", "_")
    }
  }
  user_dbs = { 
    for u in local.safe_user_names: u.user_name => { 
      db_name: "${u.safe_user_name}_db",
      safe_user_name: u.safe_user_name,
      dlt_db_name: "${u.safe_user_name}_dlt_db"
    }
  }
}