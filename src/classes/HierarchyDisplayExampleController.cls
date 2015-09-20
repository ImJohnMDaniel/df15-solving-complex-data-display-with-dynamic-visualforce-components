public with sharing class HierarchyDisplayExampleController
{
	private HierarchyDisplayDynamicMarkupHelper.HierarchyNode nodeData;

	public HierarchyDisplayExampleController()
	{
		list<DF15DVFC_Hiearchial_Skill__c> skills = new list<DF15DVFC_Hiearchial_Skill__c>();

		skills.addall( [select Id, Name
							, RecordType.name
							, Hierarchy_Parent_Branch__c
							, Hierarchy_Root__c
							, IdChain__c
							, Skill_Name__c
							, External_ID__c
							, Tier__c
							 from DF15DVFC_Hiearchial_Skill__c
							order by tier__c, idchain__c] );


		this.nodeData = new HierarchyDisplayExampleHelper().prepareHierarchyNode( skills );

	}

	public Component.Apex.OutputPanel getTheSkillsPanel()
	{
		return new HierarchyDisplayDynamicMarkupHelper().createMarkup( nodeData );
	}

}