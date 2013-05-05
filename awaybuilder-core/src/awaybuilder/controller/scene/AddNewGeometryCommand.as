package awaybuilder.controller.scene
{
	import awaybuilder.controller.events.DocumentModelEvent;
	import awaybuilder.controller.history.HistoryCommandBase;
	import awaybuilder.controller.scene.events.SceneEvent;
	import awaybuilder.model.DocumentModel;
	import awaybuilder.model.vo.scene.GeometryVO;

	public class AddNewGeometryCommand extends HistoryCommandBase
	{
		[Inject]
		public var event:SceneEvent;
		
		[Inject]
		public var document:DocumentModel;
		
		override public function execute():void
		{
			var oldValue:GeometryVO = event.oldValue as GeometryVO;
			var newValue:GeometryVO = event.newValue as GeometryVO;
			
			if( event.isUndoAction )
			{
				document.removeAsset( document.geometry, oldValue );
			}
			else 
			{
				document.geometry.addItemAt( newValue, 0 );
			}
			
			addToHistory( event );
			
			this.dispatch(new DocumentModelEvent(DocumentModelEvent.DOCUMENT_UPDATED));
			document.empty = false;
			document.edited = true;
		}
		
	}
}