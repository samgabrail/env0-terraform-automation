package env0

# allow[msg] {
#     count(input.approvers) >= 1
#     msg := "approved"
# }

# METADATA
# title: allow if no monthly cost
# description: approve automatically if the plan has no changes
pending[msg] {
    any_resources_with_creation
    msg := "ask for approval for any creations"
}

pending[msg] {
    any_resources_with_deletion
    msg := "ask for approval for any deletions"
}

allow[msg] {
    any_resources_with_updates
    msg := "automatically allow for any updates"
}

any_resources_with_updates {
    input.plan.resource_changes[_].change.actions[_] == "update"
}

any_resources_with_deletion {
    input.plan.resource_changes[_].change.actions[_] == "delete"
}

any_resources_with_creation {
    input.plan.resource_changes[_].change.actions[_] == "create"
}
