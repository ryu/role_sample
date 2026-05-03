# ユーザー作成
alice = User.find_or_create_by!(id: 1)
bob   = User.find_or_create_by!(id: 2)

# ロール作成
developer_role       = Role.find_or_create_by!(name: :developer, resource_type: nil, resource_id: nil)
admin_role           = Role.find_or_create_by!(name: :admin,     resource_type: nil, resource_id: nil)
campaign_manager_role = Role.find_or_create_by!(name: :manager,  resource_type: "Campaign", resource_id: nil)
customer1_member_role = Role.find_or_create_by!(name: :member,   resource_type: "Customer", resource_id: 1)
customer1_manager_role = Role.find_or_create_by!(name: :manager, resource_type: "Customer", resource_id: 1)

# alice: developer + admin + Campaign manager
UserRole.find_or_create_by!(user: alice, role: developer_role)
UserRole.find_or_create_by!(user: alice, role: admin_role)
UserRole.find_or_create_by!(user: alice, role: campaign_manager_role)

# bob: Customer id=1 の member（manager_of? が false になることを示すため manager は付与しない）
UserRole.find_or_create_by!(user: bob, role: customer1_member_role)

# Campaign / Customer 作成
campaign1 = Campaign.find_or_create_by!(id: 1, name: "Campaign A")
customer1  = Customer.find_or_create_by!(id: 1, name: "Customer A")
