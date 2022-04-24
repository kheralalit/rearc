data "template_file" "task_definition_template" {
  template = file("task_definition.json.tpl")
}
