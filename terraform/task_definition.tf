resource "aws_ecs_task_definition" "task_definition" {
  family                = "worker"
  container_definitions = data.template_file.task_definition_template.rendered
  execution_role_arn       = aws_iam_role.ecs_role.arn
}
