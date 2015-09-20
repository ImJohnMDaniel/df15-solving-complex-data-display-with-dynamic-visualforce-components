public class HierarchyDisplayExampleHelper
{
	private map<id, list<DF15DVFC_Hiearchial_Skill__c>> skillRecordPresortMap = new map<id, list<DF15DVFC_Hiearchial_Skill__c>>();

	public HierarchyDisplayDynamicMarkupHelper.HierarchyNode prepareHierarchyNode( final list<DF15DVFC_Hiearchial_Skill__c> skillRecords )
	{
		HierarchyDisplayDynamicMarkupHelper.HierarchyNode nodeData = null;

		for (DF15DVFC_Hiearchial_Skill__c skillRecord : skillRecords )
		{
			system.debug (skillRecord);
			if ( integer.valueOf(skillRecord.tier__c) == 1 )
			{
				nodeData = new HierarchyDisplayDynamicMarkupHelper.HierarchyNode( skillRecord );
				continue;
			}
			else if ( ! this.skillRecordPresortMap.containsKey( skillRecord.Hierarchy_Parent_Branch__c ) )
			{
				this.skillRecordPresortMap.put( skillRecord.Hierarchy_Parent_Branch__c, new list<DF15DVFC_Hiearchial_Skill__c>() );
			}

			this.skillRecordPresortMap.get( skillRecord.Hierarchy_Parent_Branch__c ).add( skillRecord );
			system.debug ('count for '+skillRecord.Hierarchy_Parent_Branch__c + ' is ' +this.skillRecordPresortMap.get( skillRecord.Hierarchy_Parent_Branch__c ).size());
		}

		nodeData.childNodes.addAll( prepareChildNodes( this.skillRecordPresortMap.get( nodeData.record.id ) ) );

		return nodeData;

	}


	private list<HierarchyDisplayDynamicMarkupHelper.HierarchyNode> prepareChildNodes(list<DF15DVFC_Hiearchial_Skill__c> childRecords)
	{
		list<HierarchyDisplayDynamicMarkupHelper.HierarchyNode> childNodes = new list<HierarchyDisplayDynamicMarkupHelper.HierarchyNode>();

		HierarchyDisplayDynamicMarkupHelper.HierarchyNode aNode = null;

		for (DF15DVFC_Hiearchial_Skill__c childRecord : childRecords)
		{
			aNode = new HierarchyDisplayDynamicMarkupHelper.HierarchyNode( childRecord );

			if (this.skillRecordPresortMap.containsKey( aNode.record.id ))
			{
				aNode.childNodes.addAll( prepareChildNodes( this.skillRecordPresortMap.get( aNode.record.id ) ) );
			}

			childNodes.add( aNode );
		}

		return childNodes;
	}
}