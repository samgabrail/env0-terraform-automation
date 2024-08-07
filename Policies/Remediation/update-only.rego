#####
# filename: update-only.rego
# purpose: Require approval for any creations or deletions but not for updates.
#####

package env0

cost_approvers := "Approvers_Team" # Cost Approvers Team Name in my account

# Pending approval for any creations without approvers
pending[msg] {
    any_resources_with_creation
    not any_approver_present
    msg := "ask for approval for any creations"
    trace("Resources with creation detected, asking for approval.")
}

# Pending approval for any deletions without approvers
pending[msg] {
    any_resources_with_deletion
    not any_approver_present
    msg := "ask for approval for any deletions"
    trace("Resources with deletion detected, asking for approval.")
}

# Allow for any updates
allow[msg] {
    any_resources_with_updates
    msg := "automatically allow for any updates"
    trace("Resources with updates detected, automatically allowing.")
}

# Allow if any approver is present
allow[msg] {
    any_approver_present
    msg := "Allowing approvers"
    trace("Approver present, allowing.")
}

# Check if there are any resources with updates
any_resources_with_updates {
    input.plan.resource_changes[_].change.actions[_] == "update"
    trace("Update action detected in resource changes.")
}

# Check if there are any resources with deletions
any_resources_with_deletion {
    input.plan.resource_changes[_].change.actions[_] == "delete"
    trace("Delete action detected in resource changes.")
}

# Check if there are any resources with creations
any_resources_with_creation {
    input.plan.resource_changes[_].change.actions[_] == "create"
    trace("Create action detected in resource changes.")
}

# Check if any approver is present
any_approver_present {
    input.approvers[_].teams[_].name == cost_approvers
    trace("Approver from cost_approvers team detected.")
}
