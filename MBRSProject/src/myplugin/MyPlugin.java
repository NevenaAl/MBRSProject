package myplugin;

import java.io.File;

import javax.swing.JOptionPane;

import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;

import com.nomagic.actions.NMAction;
import com.nomagic.magicdraw.actions.ActionsConfiguratorsManager;

/** MagicDraw plugin that performes code generation */
public class MyPlugin extends com.nomagic.magicdraw.plugins.Plugin {
	
	String pluginDir = null; 
	
	public void init() {
		JOptionPane.showMessageDialog( null, "Plugin initialization");
		
		pluginDir = getDescriptor().getPluginDirectory().getPath();
		
		// Creating submenu in the MagicDraw main menu 	
		ActionsConfiguratorsManager manager = ActionsConfiguratorsManager.getInstance();		
		manager.addMainMenuConfigurator(new MainMenuConfigurator(getSubmenuActions()));
		
		/** @Todo: load project options (@see myplugin.generator.options.ProjectOptions) from 
		 * ProjectOptions.xml and take ejb generator options */

		configureGenerateOptions();
	}
	
	private void configureGenerateOptions() {
		configureGenerateOption("ejbclass", "",".java", "be-app.src.main.java.com.example.beapp.generated.models", "EJBGenerator");
		configureGenerateOption("service", "Service",".java", "be-app.src.main.java.com.example.beapp.user.services", "EJBServiceGenerator");
		configureGenerateOption("serviceBase", "BaseService",".java", "be-app.src.main.java.com.example.beapp.generated.services", "EJBServiceBaseGenerator");
		configureGenerateOption("controller", "Controller",".java", "be-app.src.main.java.com.example.beapp.user.controllers", "EJBControllerGenerator");
		configureGenerateOption("controllerBase", "BaseController",".java", "be-app.src.main.java.com.example.beapp.generated.controllers", "EJBControllerBaseGenerator");
		configureGenerateOption("interface", "Interface",".java", "be-app.src.main.java.com.example.beapp.user.interfaces", "EJBInterfaceGenerator");
		configureGenerateOption("interfaceBase", "BaseInterface",".java", "be-app.src.main.java.com.example.beapp.generated.interfaces", "EJBInterfaceBaseGenerator");
		configureGenerateOption("repository", "Repository",".java", "be-app.src.main.java.com.example.beapp.user.repositories", "EJBRepositoryGenerator");
		configureGenerateOption("repositoryBase", "BaseRepository",".java", "be-app.src.main.java.com.example.beapp.generated.repositories", "EJBRepositoryBaseGenerator");
		configureGenerateOption("dto", "DTO",".java", "be-app.src.main.java.com.example.beapp.generated.dtos", "EJBDTOGenerator");
		configureGenerateOption("types", "types", ".ts", "fe-app.src.types.generated", "EJBTypesGenerator");
		configureGenerateOption("serviceFrontend", "Service", ".ts", "fe-app.src.services.generated", "EJBServiceFrontedGenerator");
		configureGenerateOption("interfaceFrontend", "Props", ".ts", "fe-app.src.interfaces.generated", "EJBInterfaceFrontendGenerator");
		configureGenerateOption("navbar", "NavBar", ".tsx", "fe-app.src.components.generated", "EJBNavBarGenerator");
		configureGenerateOption("preview", "Preview", ".tsx", "fe-app.src.containers.generated", "EJBPreviewGenerator");
		configureGenerateOption("pop_up", "Popup", ".tsx", "fe-app.src.components.generated", "EJBPopupGenerator");
	}
	
	private void configureGenerateOption(String templateName, String generatedFileTypeName, String generatedFileExtenstion, String generatedFilePackage, String generatorOptionName) {
		String generatedFileName = "{0}" + generatedFileTypeName + generatedFileExtenstion;
		
		GeneratorOptions ejbOptions = new GeneratorOptions("c:/temp", templateName, "templates", generatedFileName, true, generatedFilePackage); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put(generatorOptionName, ejbOptions);
				
		ejbOptions.setTemplateDir(pluginDir + File.separator + ejbOptions.getTemplateDir()); //apsolutna putanja
	}

	private NMAction[] getSubmenuActions()
	{
	   return new NMAction[]{
			new GenerateAction("Generate"),
	   };
	}
	
	public boolean close() {
		return true;
	}
	
	public boolean isSupported() {				
		return true;
	}
}


