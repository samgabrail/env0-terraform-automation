package env0

allow[msg] {
    trace("Checking if there is at least one approver")
    count(input.approvers) >= 1
    trace("Approvers count: " ++ sprintf("%v", [count(input.approvers)]))
    msg := "approved"
}

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan has no changes
allow[msg] {
    trace("Checking if there are no resources with deletion or creation")
    trace("Input plan: " ++ sprintf("%v", [input.plan]))
    not any_resources_with_deletion
    not any_resources_with_creation
    trace("No resources with deletion or creation")
    msg := "approve automatically for updates only"
}

any_resources_with_updates {
    trace("Checking if there are any resources with updates")
    input.plan.resource_changes[_].change.actions[_] == "update"
}

any_resources_with_deletion {
    trace("Checking if there are any resources with deletion")
    input.plan.resource_changes[_].change.actions[_] == "delete"
}

any_resources_with_creation {
    trace("Checking if there are any resources with creation")
    input.plan.resource_changes[_].change.actions[_] == "create"
}
