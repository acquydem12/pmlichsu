package CFramework.CComponent
{
	public interface ITreeNodeView
	{
		function ITreeNodeView( treeNode:CTreeView );
		function show():void;
		function hide():void;
	}
}