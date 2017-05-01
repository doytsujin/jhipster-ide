package io.github.jhipster.jdl.ui.wizard

import com.google.inject.Inject
import org.eclipse.xtext.generator.IFileSystemAccess2
import org.eclipse.xtext.resource.FileExtensionProvider

class JDLNewProjectWizardInitialContents {

	@Inject FileExtensionProvider fileExtensionProvider

	def generateInitialContents(IFileSystemAccess2 fsa) {
		fsa => [
			generateExampleModel
		]
	}

	def private generateExampleModel(IFileSystemAccess2 it) {
		generateFile('''src/model/Model.«fileExtensionProvider.fileExtensions.last»''', 
			'''
				/**
				 * Generated by JHipster IDE plugin
				 */
				
				entity Region {
					regionName String
				}
				
				entity Country {
					countryName String
				    foobar String
				}
				
				// an ignored comment
				/** not an ignored comment */
				entity Location {
					streetAddress String
					postalCode String
					city String
					stateProvince String
				}
				
				entity Department {
					departmentName String required
				}
				
				/**
				 * Task entity.
				 * @author The JHipster team.
				 */
				entity Task {
					title String
					description String
				}
				
				/**
				 * The Employee entity.
				 */
				entity Employee {
					/**
					* The firstname attribute.
					*/
					firstName String
					lastName String
					email String
					phoneNumber String
					hireDate ZonedDateTime
					salary Long
					commissionPct Long
				}
				
				entity Job {
					jobTitle String
					minSalary Long
					maxSalary Long
				}
				
				entity JobHistory {
					startDate ZonedDateTime
					endDate ZonedDateTime
					language Language
				}
				
				enum Language {
				    FRENCH, ENGLISH, SPANISH
				}
				
				relationship OneToOne {
					Country{region} to Region
				}
				
				relationship OneToOne {
					Location{country} to Country
				}
				
				relationship OneToOne {
					Department{location} to Location
				}
				
				relationship ManyToMany {
					Job{task(title)} to Task{job}
				}
				
				// defining multiple OneToMany relationships with comments
				relationship OneToMany {
					Employee{job} to Job,
					/**
					* A relationship
					*/
					Department{employee} to
					/**
					* Another side of the same relationship
					*/
					Employee
				}
				
				relationship ManyToOne {
					Employee{manager} to Employee
				}
				
				// defining multiple oneToOne relationships
				relationship OneToOne {
					JobHistory{job} to Job,
					JobHistory{department} to Department,
					JobHistory{employee} to Employee
				}
				
				// Set pagination options
				paginate JobHistory, Employee with infinite-scroll
				paginate Job with pagination
				
				dto * with mapstruct
				
				// Set service options to all except few
				service all with serviceImpl except Employee, Job
				// Set an angular suffix
				angularSuffix * with mySuffix
			'''
		)
	}

}
