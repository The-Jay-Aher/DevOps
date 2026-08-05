import jenkins.*
import jenkins.model.*
import hudson.*
import hudson.model.*

//find all plugins realted to Bitbucket

def pm = Jenkins.instance.pluginManager

def bbPlugins = pm.plugins.findAll { plugin ->
	def description = plugin.getManifest().getMainAttributes().getValue("Long-Name")
  	description && description.toLowerCase().contains("bitbucket")
}

// Iterate over the list and disable each one

bbPlugins.each {plugin ->
  println("Disableing ${plugin.getShortName()}")
  plugin.disable();
}

Jenkins.instance.save();
