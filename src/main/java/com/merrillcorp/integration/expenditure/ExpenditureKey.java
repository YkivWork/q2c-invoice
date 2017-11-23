package com.merrillcorp.integration.expenditure;

public class ExpenditureKey {

	private String businessUnit;
	private String serviceSite;
	private String teamType;
	private String expenditureId;

	public ExpenditureKey() {
	}

	public ExpenditureKey(String businessUnit, String serviceSite, String teamType) {
		this.businessUnit = businessUnit;
		this.serviceSite = serviceSite;
		this.teamType = teamType;
	}

	public String getBusinessUnit() {
		return businessUnit;
	}

	public String getServiceSite() {
		return serviceSite;
	}

	public String getTeamType() {
		return teamType;
	}

	public String getExpenditureId() {
		return expenditureId;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((businessUnit == null) ? 0 : businessUnit.hashCode());
		result = prime * result + ((serviceSite == null) ? 0 : serviceSite.hashCode());
		result = prime * result + ((teamType == null) ? 0 : teamType.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		ExpenditureKey other = (ExpenditureKey) obj;
		if (businessUnit == null) {
			if (other.businessUnit != null)
				return false;
		} else if (!businessUnit.equals(other.businessUnit))
			return false;
		if (serviceSite == null) {
			if (other.serviceSite != null)
				return false;
		} else if (!serviceSite.equals(other.serviceSite))
			return false;
		if (teamType == null) {
			if (other.teamType != null)
				return false;
		} else if (!teamType.equals(other.teamType))
			return false;
		return true;
	}

}
