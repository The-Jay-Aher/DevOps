import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

pipeline {
  agent any
  stages {
    stage('Plugin Management') {
      steps {
        script {
          // define the whitelist
          def pluginManager = Jenkins.instance.pluginManager

          def whitelist = [
    'ant',
    'antisamy-markup-formatter',
    'apache-httpcomponents-client-4-api',
    'asm-api',
    'bootstrap5-api',
    'bouncycastle-api',
    'branch-api',
    'build-failure-analyzer',
    'build-timeout',
    'caffeine-api',
    'checks-api',
    'cloudbees-folder',
    'commons-lang3-api',
    'commons-text-api',
    'credentials-binding',
    'credentials',
    'dark-theme',
    'display-url-api',
    'durable-task',
    'echarts-api',
    'eddsa-api',
    'email-ext',
    'font-awesome-api',
    'git-client',
    'git',
    'github-api',
    'github-branch-source',
    'github',
    'gradle',
    'gson-api',
    'instance-identity',
    'ionicons-api',
    'jackson2-api',
    'jakarta-activation-api',
    'jakarta-mail-api',
    'javax-activation-api',
    'jaxb',
    'jjwt-api',
    'joda-time-api',
    'jquery3-api',
    'json-api',
    'json-path-api',
    'jsoup',
    'junit',
    'ldap',
    'mailer',
    'matrix-auth',
    'matrix-project',
    'metrics',
    'mina-sshd-api-common',
    'mina-sshd-api-core',
    'okhttp-api',
    'pipeline-build-step',
    'pipeline-github-lib',
    'pipeline-graph-view',
    'pipeline-groovy-lib',
    'pipeline-input-step',
    'pipeline-milestone-step',
    'pipeline-model-api',
    'pipeline-model-definition',
    'pipeline-model-extensions',
    'pipeline-stage-step',
    'pipeline-stage-tags-metadata',
    'plain-credentials',
    'plugin-util-api',
    'resource-disposer',
    'scm-api',
    'script-security',
    'snakeyaml-api',
    'ssh-credentials',
    'ssh-slaves',
    'structs',
    'theme-manager',
    'timestamper',
    'token-macro',
    'trilead-api',
    'variant',
    'workflow-aggregator',
    'workflow-api',
    'workflow-basic-steps',
    'workflow-cps',
    'workflow-durable-task-step',
    'workflow-job',
    'workflow-multibranch',
    'workflow-scm-step',
    'workflow-step-api',
    'workflow-support',
    'ws-cleanup'
]

          // get installed plugins
          def installedPlugins = pluginManager.plugins.collect { it.shortName }
          // unsinstall plugins not in the whitelist
          def pluginsToRemove = installedPlugins - whitelist

          def isDirty = false

          if (!pluginsToRemove.isEmpty()) {
            isDirty = true

            pluginsToRemove.each { pluginName ->
              def plugin = pluginManager.getPlugin(pluginName)
              if (plugin) {
                echo "Removing ${pluginName}"
                // pluginManager.doUninstall(plugin)
              }
            }
          }
          // install plugins in the whitelist but not in the installed set
          def pluginsToInstall = whitelist - installedPlugins

          if (!pluginsToInstall.isEmpty()) {
            isDirty = true

            def updateCenter = Jenkins.instance.updateCenter

            pluginsToInstall.each { pluginName ->
              def plugin = updateCenter.getPlugin(pluginName)
              if (plugin) {
                echo "Installing ${pluginName}"
                plugin.deploy()
              }
            }
          }
          // save the instance
          if (isDirty) {
            Jenkins.instance.save()
          }
        }
      }
    }
  }
}
