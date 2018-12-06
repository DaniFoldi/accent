defmodule AccentTest.ProjectDeleter do
  use Accent.RepoCase
  require Ecto.Query

  alias Accent.{Repo, Project, Collaborator, ProjectDeleter}

  test "create with language and user" do
    project = %Project{name: "french"} |> Repo.insert!()
    collaborator = %Collaborator{project_id: project.id} |> Repo.insert!()

    assert project
           |> Ecto.assoc(:collaborators)
           |> Repo.all()
           |> Enum.map(& &1.id) === [collaborator.id]

    {:ok, project} = ProjectDeleter.delete(project: project)

    assert Repo.all(Ecto.assoc(project, :collaborators)) === []
  end
end
