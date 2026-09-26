require "rails_helper"

RSpec.describe "Tasks", type: :request do
  describe "GET /tasks" do
    it "shows the task list at the root path" do
      task = Task.create!(text: "Buy milk")

      get root_path

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(task.text)
    end
  end

  describe "GET /tasks/:id" do
    it "shows a task" do
      task = Task.create!(text: "Buy milk")

      get task_path(task)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(task.text)
    end
  end

  describe "POST /tasks" do
    it "creates a task" do
      expect {
        post tasks_path, params: { task: { text: "Buy milk" } }
      }.to change(Task, :count).by(1)

      expect(response).to redirect_to(task_path(Task.last))
    end

    it "renders errors for blank text" do
      expect {
        post tasks_path, params: { task: { text: "" } }
      }.not_to change(Task, :count)

      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe "PATCH /tasks/:id" do
    let!(:task) { Task.create!(text: "Buy milk") }

    it "updates a task" do
      patch task_path(task), params: { task: { text: "Buy bread" } }

      expect(response).to redirect_to(task_path(task))
      expect(task.reload.text).to eq("Buy bread")
    end

    it "renders errors for blank text" do
      patch task_path(task), params: { task: { text: "" } }

      expect(response).to have_http_status(:unprocessable_entity)
      expect(task.reload.text).to eq("Buy milk")
    end
  end

  describe "DELETE /tasks/:id" do
    it "deletes a task" do
      task = Task.create!(text: "Buy milk")

      expect {
        delete task_path(task)
      }.to change(Task, :count).by(-1)

      expect(response).to redirect_to(tasks_path)
    end
  end
end
