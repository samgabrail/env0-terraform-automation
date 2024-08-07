package env0

allow[msg] {
    count(input.approvers) >= 1
    msg := "approved"
}

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan has no changes
allow[msg] {
    print("resource changes in allow")
    print(input.plan.resource_changes)
    not any_resources_with_deletion
    not any_resources_with_creation
    msg := "approve automatically for updates only"
}

any_resources_with_updates {
    print("resource changes in updates")
    print(input.plan.resource_changes)
    input.plan.resource_changes[_].change.actions[_] == "update"
}

any_resources_with_deletion {
    input.plan.resource_changes[_].change.actions[_] == "delete"
}

any_resources_with_creation {
    input.plan.resource_changes[_].change.actions[_] == "create"
}

