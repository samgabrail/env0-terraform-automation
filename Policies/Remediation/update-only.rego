#####
# filename: update-only.rego
# purpose: Require approval for any creations or deletions but not for updates.
#####

package env0

cost_approvers := "Approvers_Team" # Cost Approvers Team Name in my account

pending[msg] {
	any_resources_with_creation
	not any_approver_present
	msg := "ask for approval for any creations"
}

pending[msg] {
	any_resources_with_deletion
	not any_approver_present
	msg := "ask for approval for any deletions"
}

allow[msg] {
	any_resources_with_updates
	msg := "automatically allow for any updates"
}

# METADATA
# title: allow if approved by anyone from cost_approveres team
# description: deployment can be approved by someone from cost_approvers team
allow[format(rego.metadata.rule())] {
	any_approver_present
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

any_approver_present {
	input.approvers[_].teams[_].name == cost_approvers
}
