/** 
 * Copyright 2013-2018 the original author or authors from the JHipster project.
 * This file is part of the JHipster project, see http://www.jhipster.tech/
 * for more information.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package io.github.jhipster.jdl.generator.lib

import io.github.jhipster.jdl.JDLStandaloneSetup
import io.github.jhipster.jdl.jdl.JdlDomainModel
import java.io.File
import java.nio.file.Path
import org.apache.log4j.Logger
import org.eclipse.emf.common.util.EList
import org.eclipse.emf.common.util.URI
import org.eclipse.emf.ecore.EObject
import org.eclipse.emf.ecore.resource.Resource
import org.eclipse.emf.ecore.resource.impl.ResourceSetImpl

/** 
 * @author Serano Colameo - Initial contribution and API
 */
interface IJdlStandaloneGenerator {
 	def void doGenerate(JdlDomainModel model)
}
 
abstract class JdlStandaloneGenerator implements IJdlStandaloneGenerator {
	val logger = Logger.getLogger(JdlStandaloneGenerator)

	protected new() {
		initialize
	}

	def private void initialize() {
		try {
			logger.info('Initializing JDL standalone infrastructure...')
			new JDLStandaloneSetup().createInjectorAndDoEMFRegistration()
		} catch (Exception ex) {
			logger.error('Could not initialize JDL standalone infrastructure!', ex)
		}
	}

	def public JdlDomainModel load(String jdlFileName) {
		load(new File(jdlFileName).toPath)
	}

	def public JdlDomainModel load(Path jdlFilePath) {
		try {
			var URI uri = URI.createURI(jdlFilePath.toFile().toURI().toString())
			var Resource resource = new ResourceSetImpl().getResource(uri, true)
			var EList<EObject> contents = if(resource !== null) resource.getContents() else null
			var EObject element = IterableExtensions.<EObject>head(contents)
			return if ((element instanceof JdlDomainModel)) ((element as JdlDomainModel)) else null
		} catch (Exception ex) {
			logger.error('''Could not load JDL file «jdlFilePath»!''', ex)
			return null
		}
	}
}
