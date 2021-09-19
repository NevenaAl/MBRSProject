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
		configureGenerateOptionBE("ejbclass", "", "be-app.src.main.java.com.example.beapp.generated.models", "EJBGenerator");
		configureGenerateOptionBE("service", "Service", "be-app.src.main.java.com.example.beapp.user.services", "EJBServiceGenerator");
		configureGenerateOptionBE("serviceBase", "BaseService", "be-app.src.main.java.com.example.beapp.generated.services", "EJBServiceBaseGenerator");
		configureGenerateOptionBE("controller", "sController", "be-app.src.main.java.com.example.beapp.user.controllers", "EJBControllerGenerator");
		configureGenerateOptionBE("controllerBase", "sBaseController", "be-app.src.main.java.com.example.beapp.generated.controllers", "EJBControllerBaseGenerator");
		configureGenerateOptionBE("interface", "Interface", "be-app.src.main.java.com.example.beapp.user.interfaces", "EJBInterfaceGenerator");
		configureGenerateOptionBE("interfaceBase", "BaseInterface", "be-app.src.main.java.com.example.beapp.generated.interfaces", "EJBInterfaceBaseGenerator");
		configureGenerateOptionBE("repository", "Repository", "be-app.src.main.java.com.example.beapp.user.repositories", "EJBRepositoryGenerator");
		configureGenerateOptionBE("repositoryBase", "BaseRepository", "be-app.src.main.java.com.example.beapp.generated.repositories", "EJBRepositoryBaseGenerator");
		configureGenerateOptionBE("dto", "DTO", "be-app.src.main.java.com.example.beapp.generated.dtos", "EJBDTOGenerator");
		configureGenerateOptionFE("types", "types", ".ts", "fe-app.src.types.generated", "EJBTypesGenerator");
		configureGenerateOptionFE("serviceFrontend", "Service", ".ts", "fe-app.src.services.generated", "EJBServiceFrontedGenerator");
		configureGenerateOptionFE("interfaceFrontend", "Props", ".ts", "fe-app.src.interfaces.generated", "EJBInterfaceFrontendGenerator");
		configureGenerateOptionFE("navbar", "NavBar", ".tsx", "fe-app.src.components.generated", "EJBNavBarGenerator");
		configureGenerateOptionFE("preview", "Preview", ".tsx", "fe-app.src.containers.generated", "EJBPreviewGenerator");
		configureGenerateOptionFE("pop_up", "Popup", ".tsx", "fe-app.src.components.generated", "EJBPopupGenerator");
	}
	
	private void configureGenerateOptionBE(String templateName, String generatedJavaFileTypeName, String generatedJavaFilePackage, String generatorOptionName) {
		String generatedJavaFileName = "{0}" + generatedJavaFileTypeName + ".java";
		
		GeneratorOptions ejbOptions = new GeneratorOptions("c:/temp", templateName, "templates", generatedJavaFileName, true, generatedJavaFilePackage); 				
		ProjectOptions.getProjectOptions().getGeneratorOptions().put(generatorOptionName, ejbOptions);
				
		ejbOptions.setTemplateDir(pluginDir + File.separator + ejbOptions.getTemplateDir()); //apsolutna putanja
	}
	
	private void configureGenerateOptionFE(String templateName, String generatedFileTypeName, String generatedFileExtenstion, String generatedFilePackage, String generatorOptionName) {
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


