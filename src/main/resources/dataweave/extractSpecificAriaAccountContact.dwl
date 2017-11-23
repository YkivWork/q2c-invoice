%dw 1.0
%output application/java
%namespace env http://schemas.xmlsoap.org/soap/envelope/
%namespace aria urn:client:api:wsdl:document/literal_wrapped:vers:11.0:aria_complete_m_api
%var responseElement = payload.env#Envelope.env#Body.aria#get_acct_contacts_mResponseElement
%var otherContact= responseElement.*other_contacts[?( $.other_contact_no == flowVars.contactNumber ) ][0]
%var statContact= responseElement.*statement_contacts[?( $.stat_contact_no == flowVars.contactNumber ) ][0]

---

//responseElement.*other_contacts[?( $.other_contact_no == flowVars.contactNumber ) ][0]

{
	contactNumber: statContact.stat_contact_no,
	firstName: statContact.stat_first_name,
	middleInitial: statContact.stat_middle_initial,
	lastName: statContact.stat_last_name,
	companyName: statContact.stat_company_name,
	address1: statContact.stat_address1,
	address2: statContact.stat_address2,
	address3: statContact.stat_address3,
	city: statContact.stat_city,
	locality: statContact.stat_locality,
	stateProvince: statContact.stat_state_prov,
	country: statContact.stat_country,
	postal: statContact.stat_postal_cd,
	phone: statContact.stat_phone,
	phoneExtension: statContact.stat_phone_ext,
	cellPhone: statContact.stat_cell_phone,
	workPhone: statContact.stat_work_phone,
	workPhoneExtension: statContact.stat_work_phone_ext,
	fax: statContact.stat_fax,
	email: statContact.stat_email,
	birthdate: statContact.stat_birthdate
		
} when otherContact == null 
otherwise 
{
	contactNumber: otherContact.other_contact_no,
	firstName: otherContact.other_first_name,
	middleInitial: otherContact.other_middle_initial,
	lastName: otherContact.other_last_name,
	companyName: otherContact.other_company_name,
	address1: otherContact.other_address1,
	address2: otherContact.other_address2,
	address3: otherContact.other_address3,
	city: otherContact.other_city,
	locality: otherContact.other_locality,
	stateProvince: otherContact.other_state_prov,
	country: otherContact.other_country_cd,
	postal: otherContact.other_postal_cd,
	phone: otherContact.other_phone,
	phoneExtension: otherContact.other_phone_ext,
	cellPhone: otherContact.other_cell_phone,
	workPhone: otherContact.other_work_phone,
	workPhoneExtension: otherContact.other_work_phone_ext,
	fax: otherContact.other_fax,
	email: otherContact.other_email,
	birthdate: otherContact.other_birthdate
		
}