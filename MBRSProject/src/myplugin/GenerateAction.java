package myplugin;

import java.awt.event.ActionEvent;
import java.io.BufferedWriter;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.nio.file.*;
import java.io.File;

import javax.swing.JFileChooser;
import javax.swing.JOptionPane;

import com.nomagic.magicdraw.actions.MDAction;
import com.nomagic.magicdraw.core.Application;
import com.nomagic.uml2.ext.magicdraw.classes.mdkernel.Package;
import com.thoughtworks.xstream.XStream;
import com.thoughtworks.xstream.io.xml.DomDriver;

import myplugin.analyzer.AnalyzeException;
import myplugin.analyzer.ModelAnalyzer;
import myplugin.generator.BasicGenerator;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.options.GeneratorOptions;
import myplugin.generator.options.ProjectOptions;
import myplugin.utils.GeneratorHandler;
import myplugin.utils.GeneratorMultipleHandler;
import myplugin.utils.TreeCopyFileVisitor;

/** Action that activate code generation */
@SuppressWarnings("serial")
class GenerateAction extends MDAction{
	
	public GenerateAction(String name) {			
		super("", name, null, null);		
	}
	
	public void actionPerformed(ActionEvent evt) {
		
		if (Application.getInstance().getProject() == null) return;
		Package root = Application.getInstance().getProject().getModel();
		
		if (root == null) return;
	
		try {
			Path path = FileSystems.getDefault().getPath("plugins", "myplugin", "be-app");
			String fromDirectory = path.toAbsolutePath().toString().replace('\\', '/');
	        String toToDirectory = "c:/temp/be-app";
			copyDirectoryFileVisitor(fromDirectory, toToDirectory);
			
			path = FileSystems.getDefault().getPath("plugins", "myplugin", "fe-app");
			fromDirectory = path.toAbsolutePath().toString().replace('\\', '/');
	        toToDirectory = "c:/temp/fe-app";
			copyDirectoryFileVisitor(fromDirectory, toToDirectory);
			
			for (GeneratorOptions go : ProjectOptions.getProjectOptions().getGeneratorOptions().values()) {
				if (go.getFilePackage().contains("user")) {
					File directory = new File("c:/temp/" + go.getFilePackage().replace('.', '/'));
					if (directory.isDirectory()) {
						if (directory.list().length == 0) {
							generateFiles(root, go);
						}
					} else {
						generateFiles(root, go);
					}
				} else {
					generateFiles(root, go);
				}
			}

			JOptionPane.showMessageDialog(null, "Code is successfully generated!");

		} catch (AnalyzeException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
	}

	private void generateFiles(Package root, GeneratorOptions go) throws AnalyzeException {
		if(go.getTemplateName() == "types" || go.getTemplateName() == "navbar") {
			GeneratorHandler generator = new GeneratorHandler(go);
			ModelAnalyzer analyzer = new ModelAnalyzer(root, go.getFilePackage());	
			analyzer.prepareModel();

			generator.generate();
		}
		else{
			GeneratorMultipleHandler generator = new GeneratorMultipleHandler(go);
			ModelAnalyzer analyzer = new ModelAnalyzer(root, go.getFilePackage());	
			analyzer.prepareModel();

			generator.generate();
		}
	}
	
	public static void copyDirectoryFileVisitor(String source, String target)
        throws IOException {

        TreeCopyFileVisitor fileVisitor = new TreeCopyFileVisitor(source, target);
        Files.walkFileTree(Paths.get(source), fileVisitor);
    }
}