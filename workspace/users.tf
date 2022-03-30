data "databricks_current_user" "me" {}

resource "databricks_group" "isv_summit" {
  display_name               = "isv_summit"
  databricks_sql_access      = true
}

resource "databricks_group" "isv_summit_group" {
  for_each = { for u in range(0, floor(length(local.users) / 10) + (length(local.users) % 10)==0 ? 0 : 1) : u => u }
  display_name               = "isv_summit_${each.key + 1}"
  allow_cluster_create       = false
  allow_instance_pool_create = false
  databricks_sql_access      = true
}

resource "databricks_user" "users" {
  for_each = { for u in range(0, length(local.users)) : u => u }
  user_name = local.users[each.key].uid
  display_name = local.users[each.key].name
}

resource "databricks_group_member" "isv_summit_members" {
  for_each = { for u in range(0, length(databricks_user.users)) : u => tonumber(u) }
  group_id  = databricks_group.isv_summit_group[floor(each.value / 10)].id
  member_id = databricks_user.users[each.value].id
}

resource "databricks_group_member" "isv_summit_member_groups" {
  for_each = databricks_group_member.isv_summit_members
  group_id  = databricks_group.isv_summit.id
  member_id = each.value.group_id
}