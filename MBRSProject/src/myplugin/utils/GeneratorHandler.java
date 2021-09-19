package myplugin.utils;

import java.io.IOException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.swing.JOptionPane;

import freemarker.template.TemplateException;
import myplugin.generator.BasicGenerator;
import myplugin.generator.fmmodel.FMClass;
import myplugin.generator.fmmodel.FMModel;
import myplugin.generator.fmmodel.FMProperty;
import myplugin.generator.options.GeneratorOptions;

public class GeneratorHandler extends BasicGenerator {

	public GeneratorHandler(GeneratorOptions generatorOptions) {
		super(generatorOptions);
	}

	public void generate() {
		try {
			super.generate();
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
		
		List<FMClass> classes = FMModel.getInstance().getClasses();
		Map<String, Object> context = new HashMap<String, Object>();
		Map<String, Object> allProperties = new HashMap<String, Object>();
		try {
			Writer out = getWriter("", this.getFilePackage());
			if (out != null) {
				context.clear();
				context.put("classes", classes);
				for (int i = 0; i < classes.size(); i++) {
					FMClass cl = classes.get(i);
					allProperties.put(cl.getName(), cl.getProperties());
				}
				context.put("allProperties", allProperties);
				getTemplate().process(context, out);
				out.flush();
			}
		} catch (TemplateException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		} catch (IOException e) {
			JOptionPane.showMessageDialog(null, e.getMessage());
		}
	}
	
}
