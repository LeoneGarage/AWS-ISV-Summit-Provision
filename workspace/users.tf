data "databricks_current_user" "me" {}

resource "databricks_group" "isv_summit" {
  display_name               = "isv_summit"
  databricks_sql_access      = true
}

resource "databricks_group" "isv_summit_group" {
  for_each = { for u in range(0, ceil(length(local.users) / 10)) : u => u }
  display_name               = "isv_summit_${each.key + 1}"
  allow_cluster_create       = false
  allow_instance_pool_create = false
  databricks_sql_access      = true
}

resource "databricks_user" "users" {
  for_each = { for u in local.users : u.uid => u if u.uid != data.databricks_current_user.me.user_name }
  user_name = each.value.uid
  display_name = each.value.name
}

resource "databricks_group_member" "isv_summit_members" {
  for_each = { for u in range(0, length(local.all_users)) : u => element(values(local.all_users), u) }
  group_id  = databricks_group.isv_summit_group[floor(each.key / 10)].id
  member_id = each.value.id
}

resource "databricks_group_member" "isv_summit_member_groups" {
  for_each = databricks_group_member.isv_summit_members
  group_id  = databricks_group.isv_summit.id
  member_id = each.value.group_id
}