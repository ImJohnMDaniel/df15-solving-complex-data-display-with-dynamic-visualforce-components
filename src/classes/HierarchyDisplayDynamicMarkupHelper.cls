public class HierarchyDisplayDynamicMarkupHelper
{
	private integer indentionSpacerSize = 8;

	public Component.Apex.OutputPanel createMarkup(final HierarchyNode rootNode)
	{
        Component.Apex.OutputPanel mainPanel = new Component.Apex.OutputPanel(layout='block', styleClass='panel panel-default');
        {
            Component.Apex.OutputPanel panelHeadingRow = new Component.Apex.OutputPanel(layout='block', styleClass='panel-heading');
            {
                Component.Apex.OutputText headingCol1OutputText = new Component.Apex.OutputText(styleClass='panel-title', value='Skills Display');
                panelHeadingRow.childComponents.add( headingCol1OutputText );
            }
            mainPanel.childComponents.add( panelHeadingRow );

            Component.Apex.OutputPanel skillsRootRow = new Component.Apex.OutputPanel(layout='block', styleClass='panel-results');
            {
				Component.Apex.OutputPanel panelBodyRow = new Component.Apex.OutputPanel( layout='block', styleClass='panel-body');
				{
					Component.Apex.OutputText rootOutputText = new Component.Apex.OutputText( value = rootNode.record.Skill_Name__c);
					panelBodyRow.childComponents.add(rootOutputText);
				}
				skillsRootRow.childComponents.add(panelBodyRow);

				if (rootNode.childNodes.size() > 0)
				{
					skillsRootRow.childComponents.addAll( createChildDivs(rootNode.childNodes, 1) );
//					Component.Apex.OutputPanel nodeChildrenPanel = new Component.Apex.OutputPanel( layout='block', styleClass='collapse childrenNode '+currentNodeChildrenName);
//		            {
//		                nodeChildrenPanel.childComponents.addAll( createChildDivs( m_currentTree.getChildNodes(node.idChain), baseAccessString, level+1, currentNodeName) );
//		            }
				}
            }
            mainPanel.childComponents.add( skillsRootRow );

        }

        return mainPanel;
	}

	private List<ApexPages.Component> createChildDivs(list<HierarchyNode> nodes, integer indentionSpacerLength)
	{
		List<ApexPages.Component> rows = new List<ApexPages.Component>();

		string spacer = '+';
		for (integer i = 0; i < (indentionSpacerLength * indentionSpacerSize); i++)
		{
			spacer += '-';
		}
		spacer += ' ';

		for (HierarchyNode node : nodes)
		{
			Component.Apex.OutputPanel panelBodyRow = new Component.Apex.OutputPanel( layout='block', styleClass='panel-body');
			{
				Component.Apex.OutputText nodeOutputText = new Component.Apex.OutputText( value = spacer + node.record.Skill_Name__c);
				panelBodyRow.childComponents.add(nodeOutputText);
			}

			rows.add(panelBodyRow);

			if (node.childNodes.size() > 0)
			{
				rows.addAll( createChildDivs(node.childNodes, indentionSpacerLength + 1) );
			}
		}

		return rows;
	}

	public class HierarchyNode
	{
		public DF15DVFC_Hiearchial_Skill__c record { get; set; }

		public list<HierarchyNode> childNodes { get; set; } { childNodes = new list<HierarchyNode>(); }

		public HierarchyNode( DF15DVFC_Hiearchial_Skill__c record )
		{
			this.record = record;
		}
	}

}