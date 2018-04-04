/**
 * Copyright 2013-2018 the original author or authors from the JHipster project.
 *
 * This file is part of the JHipster project, see http://www.jhipster.tech/
 * for more information.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package io.github.jhipster.jdl.generator.lib.test

import org.eclipse.xtend.core.compiler.batch.XtendCompilerTester
import org.junit.Test
import static org.junit.Assert.*

/**
 * Extracts an interface for all locally declared public methods.
 * 
 * @author Serano Colameo - Initial contribution and API
 */
class JdlGeneratorTest {
	
	extension XtendCompilerTester compilerTester = XtendCompilerTester.newXtendCompilerTester(class.classLoader)
	
	@Test def void testExtractAnnotation() {
		'''
			import io.github.jhipster.jdl.generator.lib.JdlGeneratorAnnotation
			
			@JdlGeneratorAnnotation
			class MyJdlGeneratorClass {
			}
		'''.compile [
			val extension ctx = transformationContext
			val clazz = findClass('MyJdlGeneratorClass')
			
			assertNotNull(clazz)
			assertFalse(clazz.class.constructors.isNullOrEmpty)
			println(clazz)

//			assertEquals(clazz.implementedInterfaces.head.type, interf)
			
//			interf.declaredMethods.head => [
//				assertEquals('doStuff', simpleName)
//				assertEquals(string, returnType)
//				assertEquals(IllegalArgumentException.newTypeReference, exceptions.head)
//			]
		]
	}
}
