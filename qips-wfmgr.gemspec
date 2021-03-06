# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{qips-wfmgr}
  s.version = "0.5.13"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Dave Austin", "Andrew Brader"]
  s.date = %q{2010-09-24}
  s.default_executable = %q{static_workflow_test.rb}
  s.description = %q{Workflow Manager is in charge of creating, submitting, and tracking custom workflows.}
  s.email = %q{daustin@mail.med.upenn.edu}
  s.executables = ["static_workflow_test.rb"]
  s.extra_rdoc_files = [
    "README"
  ]
  s.files = [
    ".gitignore",
     "README",
     "Rakefile",
     "VERSION",
     "app/controllers/application_controller.rb",
     "app/controllers/parameters_controller.rb",
     "app/controllers/protocols_controller.rb",
     "app/controllers/sessions_controller.rb",
     "app/controllers/stages_controller.rb",
     "app/controllers/submissions_controller.rb",
     "app/controllers/tasks_controller.rb",
     "app/controllers/workflows_controller.rb",
     "app/helpers/application_helper.rb",
     "app/helpers/protocols_helper.rb",
     "app/helpers/stages_helper.rb",
     "app/helpers/submissions_helper.rb",
     "app/helpers/tasks_helper.rb",
     "app/helpers/workflows_helper.rb",
     "app/models/item.rb",
     "app/models/parameter.rb",
     "app/models/project.rb",
     "app/models/protocol.rb",
     "app/models/role.rb",
     "app/models/stage.rb",
     "app/models/submission.rb",
     "app/models/task.rb",
     "app/models/user.rb",
     "app/models/workflow.rb",
     "app/views/layouts/application.html.erb",
     "app/views/protocols/_form.html.erb",
     "app/views/protocols/_parameter_fields.html.erb",
     "app/views/protocols/edit.html.erb",
     "app/views/protocols/index.html.erb",
     "app/views/protocols/new.html.erb",
     "app/views/protocols/show.html.erb",
     "app/views/protocols/update_options.html.erb",
     "app/views/sessions/new.html.haml",
     "app/views/shared/_heading.html.erb",
     "app/views/stages/edit.html.erb",
     "app/views/stages/index.html.erb",
     "app/views/stages/new.html.erb",
     "app/views/stages/show.html.erb",
     "app/views/submissions/_parameter.html.erb",
     "app/views/submissions/_task.html.erb",
     "app/views/submissions/index.html.erb",
     "app/views/submissions/new.html.erb",
     "app/views/submissions/show.html.erb",
     "app/views/submissions/update_options.html.erb",
     "app/views/tasks/edit.html.erb",
     "app/views/tasks/index.html.erb",
     "app/views/tasks/new.html.erb",
     "app/views/tasks/show.html.erb",
     "app/views/workflows/_protocol.html.erb",
     "app/views/workflows/_stage_fields.html.erb",
     "app/views/workflows/edit.html.erb",
     "app/views/workflows/index.html.erb",
     "app/views/workflows/new.html.erb",
     "app/views/workflows/show.html.erb",
     "bin/static_workflow_test.rb",
     "config/boot.rb",
     "config/cucumber.yml",
     "config/database.yml",
     "config/environment.rb",
     "config/environments/cucumber.rb",
     "config/environments/development.rb",
     "config/environments/production.rb",
     "config/environments/test.rb",
     "config/initializers/backtrace_silencers.rb",
     "config/initializers/inflections.rb",
     "config/initializers/mime_types.rb",
     "config/initializers/new_rails_defaults.rb",
     "config/initializers/ruote.rb",
     "config/initializers/ruote_kit.rb",
     "config/initializers/session_store.rb",
     "config/locales/en.yml",
     "config/routes.rb",
     "db/migrate/20100202214639_create_submissions.rb",
     "db/migrate/20100202214952_create_tasks.rb",
     "db/migrate/20100204184320_create_protocols.rb",
     "db/migrate/20100204184618_create_workflows.rb",
     "db/migrate/20100204184654_create_stages.rb",
     "db/migrate/20100204210112_add_input_output_file_types_executable_args_process_timeout_to_protocol.rb",
     "db/migrate/20100204213756_remove_args_from_protocol.rb",
     "db/migrate/20100204213833_add_default_args_to_protocol.rb",
     "db/migrate/20100204221834_create_parameters.rb",
     "db/migrate/20100205202706_add_input_files_output_folder_to_submission.rb",
     "db/migrate/20100205202756_add_wfid_to_submission.rb",
     "db/migrate/20100205210505_add_protocol_id_to_task.rb",
     "db/migrate/20100205211859_add_executable_args_to_task.rb",
     "db/migrate/20100208200543_add_submission_tag_to_submission.rb",
     "db/migrate/20100216154357_add_queue_to_protocol.rb",
     "db/migrate/20100219200424_add_description_to_protocol.rb",
     "db/migrate/20100301181041_add_pass_vars_to_protocol.rb",
     "db/migrate/20100301182220_remove_pass_vars_from_protocol.rb",
     "db/migrate/20100301182242_add_pass_filenames_to_protocol.rb",
     "db/migrate/20100301204717_add_process_defintion_to_submission.rb",
     "db/migrate/20100305201358_rename_value_hash_remote_value_in_parameter.rb",
     "db/migrate/20100305201821_add_param_values_params_url_params_contents_to_task.rb",
     "db/migrate/20100311204758_add_name_to_task.rb",
     "db/migrate/20100311214508_add_aux_files_to_task.rb",
     "db/migrate/20100331200618_add_exec_output_exec_error_to_task.rb",
     "db/migrate/20100331202235_add_fei_wfid_to_submission.rb",
     "db/migrate/20100401175804_add_default_aux_files_to_protocol.rb",
     "db/migrate/20100401183137_remove_exec_error_from_task.rb",
     "db/migrate/20100401194124_add_last_error_to_submission.rb",
     "db/migrate/20100407195356_add_position_to_parameter.rb",
     "db/migrate/20100514175850_add_role_id_to_protocol.rb",
     "db/migrate/20100514181542_add_role_id_to_task.rb",
     "db/migrate/20100520181617_add_user_id_to_workflow.rb",
     "db/migrate/20100520181647_add_user_id_to_submission.rb",
     "db/migrate/20100521154728_add_project_id_to_submission.rb",
     "db/migrate/20100521161326_remove_output_folder_from_submission.rb",
     "db/migrate/20100521174239_remove_owner_from_submission.rb",
     "db/migrate/20100614202759_rename_pretty_name_to_field_label_in_parameter.rb",
     "db/migrate/20100909165405_add_pretty_input_list_to_submission.rb",
     "db/migrate/20100909165431_add_pretty_aux_list_to_task.rb",
     "db/seeds.rb",
     "doc/README_FOR_APP",
     "features/admin_protocols.feature",
     "features/admin_submissions.feature",
     "features/admin_workflows.feature",
     "features/authenticate_users.feature",
     "features/manage_workflows.feature",
     "features/step_definitions/helper_steps.rb",
     "features/step_definitions/pickle_steps.rb",
     "features/step_definitions/protocol_steps.rb",
     "features/step_definitions/submission_steps.rb",
     "features/step_definitions/user_steps.rb",
     "features/step_definitions/web_steps.rb",
     "features/step_definitions/workflow_steps.rb",
     "features/submit_workflows.feature",
     "features/support/env.rb",
     "features/support/paths.rb",
     "features/support/pickle.rb",
     "lib/authentication.rb",
     "lib/s3_helper.rb",
     "lib/tasks/cucumber.rake",
     "lib/tasks/import.rake",
     "lib/tasks/ruote_kit.rake",
     "pkg/qips-wfmgr-0.1.0.gem",
     "pkg/qips-wfmgr-0.1.1.gem",
     "pkg/qips-wfmgr-0.1.2.gem",
     "pkg/qips-wfmgr-0.1.3.gem",
     "pkg/qips-wfmgr-0.2.0.gem",
     "pkg/qips-wfmgr-0.2.1.gem",
     "pkg/qips-wfmgr-0.2.2.gem",
     "pkg/qips-wfmgr-0.2.3.gem",
     "pkg/qips-wfmgr-0.3.0.gem",
     "pkg/qips-wfmgr-0.3.1.gem",
     "pkg/qips-wfmgr-0.4.0.gem",
     "pkg/qips-wfmgr-0.4.1.gem",
     "pkg/qips-wfmgr-0.4.2.gem",
     "pkg/qips-wfmgr-0.4.3.gem",
     "pkg/qips-wfmgr-0.4.4.gem",
     "public/404.html",
     "public/422.html",
     "public/500.html",
     "public/favicon.ico",
     "public/images/green_atoms.jpg",
     "public/images/handoff.jpg",
     "public/images/qips.png",
     "public/images/rails.png",
     "public/javascripts/SimplyButtons.js",
     "public/javascripts/application.js",
     "public/javascripts/controls.js",
     "public/javascripts/dragdrop.js",
     "public/javascripts/effects.js",
     "public/javascripts/fluo-can.js",
     "public/javascripts/fluo-dial.js",
     "public/javascripts/fluo-json.js",
     "public/javascripts/fluo-tred.js",
     "public/javascripts/jquery-1.4.2.min.js",
     "public/javascripts/jquery-ui-1.8.1.custom.min.js",
     "public/javascripts/jquery-ui.js",
     "public/javascripts/jquery.js",
     "public/javascripts/jrails.js",
     "public/javascripts/prototype.js",
     "public/javascripts/ui.multiselect.js",
     "public/robots.txt",
     "public/stylesheets/application.css",
     "public/stylesheets/common.css",
     "public/stylesheets/scaffold.css",
     "public/stylesheets/ui.multiselect.css",
     "qips-wfmgr.gemspec",
     "script/about",
     "script/console",
     "script/cucumber",
     "script/dbconsole",
     "script/destroy",
     "script/generate",
     "script/performance/benchmarker",
     "script/performance/profiler",
     "script/plugin",
     "script/runner",
     "script/server",
     "test/fixtures/protocols.yml",
     "test/fixtures/stages.yml",
     "test/fixtures/submissions.yml",
     "test/fixtures/tasks.yml",
     "test/fixtures/workflows.yml",
     "test/functional/protocols_controller_test.rb",
     "test/functional/stages_controller_test.rb",
     "test/functional/submissions_controller_test.rb",
     "test/functional/tasks_controller_test.rb",
     "test/functional/workflows_controller_test.rb",
     "test/performance/browsing_test.rb",
     "test/test_helper.rb",
     "test/unit/helpers/protocols_helper_test.rb",
     "test/unit/helpers/stages_helper_test.rb",
     "test/unit/helpers/submissions_helper_test.rb",
     "test/unit/helpers/tasks_helper_test.rb",
     "test/unit/helpers/workflows_helper_test.rb",
     "test/unit/protocol_test.rb",
     "test/unit/stage_test.rb",
     "test/unit/submission_test.rb",
     "test/unit/task_test.rb",
     "test/unit/workflow_test.rb",
     "vendor/plugins/jrails/CHANGELOG",
     "vendor/plugins/jrails/LICENSE",
     "vendor/plugins/jrails/README.rdoc",
     "vendor/plugins/jrails/Rakefile",
     "vendor/plugins/jrails/VERSION.yml",
     "vendor/plugins/jrails/bin/jrails",
     "vendor/plugins/jrails/init.rb",
     "vendor/plugins/jrails/install.rb",
     "vendor/plugins/jrails/javascripts/jquery-ui.js",
     "vendor/plugins/jrails/javascripts/jquery.js",
     "vendor/plugins/jrails/javascripts/jrails.js",
     "vendor/plugins/jrails/javascripts/sources/jrails.js",
     "vendor/plugins/jrails/jrails.gemspec",
     "vendor/plugins/jrails/lib/jquery_selector_assertions.rb",
     "vendor/plugins/jrails/lib/jrails.rb",
     "vendor/plugins/jrails/rails/init.rb",
     "vendor/plugins/jrails/tasks/jrails.rake",
     "vendor/plugins/ruote-kit/.document",
     "vendor/plugins/ruote-kit/Gemfile",
     "vendor/plugins/ruote-kit/README.rdoc",
     "vendor/plugins/ruote-kit/Rakefile",
     "vendor/plugins/ruote-kit/config.ru",
     "vendor/plugins/ruote-kit/lib/ruote-kit.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/application.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/configuration.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/helpers.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/helpers/engine_helpers.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/helpers/form_helpers.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/helpers/launch_item_parser.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/helpers/navigation_helpers.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/helpers/render_helpers.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/images/bg.gif",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/images/bg_button_left.gif",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/images/bg_button_left_cancel.gif",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/images/bg_button_left_submit.gif",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/images/bg_button_right.gif",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/javascripts/SimplyButtons.js",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/javascripts/fluo-can.js",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/javascripts/fluo-dial.js",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/javascripts/fluo-json.js",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/javascripts/fluo-tred.js",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/stylesheets/SimplyButtons.css",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/stylesheets/base.css",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/stylesheets/rk.css",
     "vendor/plugins/ruote-kit/lib/ruote-kit/public/_ruote/stylesheets/style.css",
     "vendor/plugins/ruote-kit/lib/ruote-kit/resources/expressions.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/resources/processes.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/resources/workitems.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/spec/ruote_helpers.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/version.rb",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/expression.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/expressions.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/index.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/launch_process.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/layout.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/process.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/process_failed_to_launch.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/process_launched.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/processes.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/resource_not_found.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/workitem.html.haml",
     "vendor/plugins/ruote-kit/lib/ruote-kit/views/workitems.html.haml",
     "vendor/plugins/ruote-kit/ruote-kit.gemspec",
     "vendor/plugins/ruote-kit/spec/helpers/render_helpers_spec.rb",
     "vendor/plugins/ruote-kit/spec/resources/expressions_spec.rb",
     "vendor/plugins/ruote-kit/spec/resources/index_spec.rb",
     "vendor/plugins/ruote-kit/spec/resources/processes_spec.rb",
     "vendor/plugins/ruote-kit/spec/resources/workitems_spec.rb",
     "vendor/plugins/ruote-kit/spec/ruote-kit_configure_spec.rb",
     "vendor/plugins/ruote-kit/spec/ruote-kit_spec.rb",
     "vendor/plugins/ruote-kit/spec/spec.opts",
     "vendor/plugins/ruote-kit/spec/spec_helper.rb",
     "vendor/plugins/ruote-kit/spec/views/expressions.html.haml_spec.rb",
     "vendor/plugins/ruote-kit/spec/views/launch_process.html.haml_spec.rb",
     "vendor/plugins/ruote-kit/spec/views/process.html.haml_spec.rb",
     "vendor/plugins/ruote-kit/spec/views/process_launched.html.haml_spec.rb",
     "vendor/plugins/ruote-kit/spec/views/processes.html.haml_spec.rb",
     "vendor/plugins/ruote-kit/spec/views/workitems.html.haml_spec.rb"
  ]
  s.homepage = %q{http://github.com/daustin/qips-wfmgr}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.7}
  s.summary = %q{QIPS - Workflow Manager}
  s.test_files = [
    "test/functional/protocols_controller_test.rb",
     "test/functional/stages_controller_test.rb",
     "test/functional/submissions_controller_test.rb",
     "test/functional/tasks_controller_test.rb",
     "test/functional/workflows_controller_test.rb",
     "test/performance/browsing_test.rb",
     "test/test_helper.rb",
     "test/unit/helpers/protocols_helper_test.rb",
     "test/unit/helpers/stages_helper_test.rb",
     "test/unit/helpers/submissions_helper_test.rb",
     "test/unit/helpers/tasks_helper_test.rb",
     "test/unit/helpers/workflows_helper_test.rb",
     "test/unit/protocol_test.rb",
     "test/unit/stage_test.rb",
     "test/unit/submission_test.rb",
     "test/unit/task_test.rb",
     "test/unit/workflow_test.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_runtime_dependency(%q<sinatra>, ["= 0.9.4"])
      s.add_runtime_dependency(%q<sinatra-respond_to>, ["= 0.4.0"])
      s.add_runtime_dependency(%q<json>, [">= 1.2.0"])
      s.add_runtime_dependency(%q<mysql>, [">= 2.1.0"])
      s.add_runtime_dependency(%q<right_aws>, [">= 1.10.0"])
      s.add_runtime_dependency(%q<ruote>, ["= 2.1.7"])
      s.add_runtime_dependency(%q<ruote-amqp>, ["= 2.1.5"])
      s.add_runtime_dependency(%q<ruote-kit>, ["= 2.1.4.1"])
      s.add_development_dependency(%q<rspec-rails>, [">= 1.3.2"])
      s.add_development_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_development_dependency(%q<cucumber>, [">= 0.4.3"])
      s.add_development_dependency(%q<pickle>, [">= 0.1.21"])
      s.add_development_dependency(%q<cucumber-rails>, [">= 0.3.0"])
      s.add_development_dependency(%q<database_cleaner>, [">= 0.5.0"])
      s.add_development_dependency(%q<webrat>, [">= 0.7.0"])
      s.add_development_dependency(%q<capybara>, ["= 0.3.8"])
    else
      s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
      s.add_dependency(%q<sinatra>, ["= 0.9.4"])
      s.add_dependency(%q<sinatra-respond_to>, ["= 0.4.0"])
      s.add_dependency(%q<json>, [">= 1.2.0"])
      s.add_dependency(%q<mysql>, [">= 2.1.0"])
      s.add_dependency(%q<right_aws>, [">= 1.10.0"])
      s.add_dependency(%q<ruote>, ["= 2.1.7"])
      s.add_dependency(%q<ruote-amqp>, ["= 2.1.5"])
      s.add_dependency(%q<ruote-kit>, ["= 2.1.4.1"])
      s.add_dependency(%q<rspec-rails>, [">= 1.3.2"])
      s.add_dependency(%q<rspec>, [">= 1.2.9"])
      s.add_dependency(%q<cucumber>, [">= 0.4.3"])
      s.add_dependency(%q<pickle>, [">= 0.1.21"])
      s.add_dependency(%q<cucumber-rails>, [">= 0.3.0"])
      s.add_dependency(%q<database_cleaner>, [">= 0.5.0"])
      s.add_dependency(%q<webrat>, [">= 0.7.0"])
      s.add_dependency(%q<capybara>, ["= 0.3.8"])
    end
  else
    s.add_dependency(%q<sqlite3-ruby>, [">= 0"])
    s.add_dependency(%q<sinatra>, ["= 0.9.4"])
    s.add_dependency(%q<sinatra-respond_to>, ["= 0.4.0"])
    s.add_dependency(%q<json>, [">= 1.2.0"])
    s.add_dependency(%q<mysql>, [">= 2.1.0"])
    s.add_dependency(%q<right_aws>, [">= 1.10.0"])
    s.add_dependency(%q<ruote>, ["= 2.1.7"])
    s.add_dependency(%q<ruote-amqp>, ["= 2.1.5"])
    s.add_dependency(%q<ruote-kit>, ["= 2.1.4.1"])
    s.add_dependency(%q<rspec-rails>, [">= 1.3.2"])
    s.add_dependency(%q<rspec>, [">= 1.2.9"])
    s.add_dependency(%q<cucumber>, [">= 0.4.3"])
    s.add_dependency(%q<pickle>, [">= 0.1.21"])
    s.add_dependency(%q<cucumber-rails>, [">= 0.3.0"])
    s.add_dependency(%q<database_cleaner>, [">= 0.5.0"])
    s.add_dependency(%q<webrat>, [">= 0.7.0"])
    s.add_dependency(%q<capybara>, ["= 0.3.8"])
  end
end

