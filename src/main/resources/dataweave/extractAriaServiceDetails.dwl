%dw 1.0
%output application/java
---
{
	errorCode: payload.error_code as :string,
	errorMessage: payload.error_msg,
	serviceNumber: payload.service_no,
	serviceLocationName: payload.service_locations.svc_location_name,
	serviceLocationCity: payload.service_locations.svc_location_city,
	serviceLocationAddress1: payload.service_locations.svc_location_address1,
	serviceLocationAddress2: payload.service_locations.svc_location_address2,
	serviceLocationAddress3: payload.service_locations.svc_location_address3,
	serviceLocationAddress3: payload.service_locations.svc_location_address4,	
	serviceLocationState: payload.service_locations.svc_location_state_prov,
	serviceLocationCountry: payload.service_locations.svc_location_country,
	serviceLocationPostalCode: payload.service_locations.svc_location_postal_cd as :string
}