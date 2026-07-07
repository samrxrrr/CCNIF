from ccnif.state import ProjectState

state = ProjectState()
state.update_stage("download")
state.save()

print(state.state)
