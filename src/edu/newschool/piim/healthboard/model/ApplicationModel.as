package edu.newschool.piim.healthboard.model
{
	import edu.newschool.piim.healthboard.Constants;
	
	import edu.newschool.piim.healthboard.events.ApplicationDataEvent;
	import edu.newschool.piim.healthboard.events.ApplicationEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import edu.newschool.piim.healthboard.view.styles.ChartStyles;

	[Bindable]
	public class ApplicationModel extends EventDispatcher
	{
		public var context:String;
		
		public var patientAlerts:ArrayCollection;
		
		public var chartStyles:ChartStyles;
		
		private var _patientAlertsLoaded:Boolean;
		
		public var today:Date;
		
		public var viewMode:String = Constants.STATE_LOGGED_IN;
		
		public var settings:ArrayCollection;
		
		public var preferences:Preferences;
		
		public var supportedLanguages:ArrayCollection;
		
		public var user:UserModel;	//	logged-in user
		
		public function ApplicationModel( context:String )
		{
			super();
			
			this.context = context;
			
			patientAlerts = new ArrayCollection();
			
			today = new Date();
			
			supportedLanguages = new ArrayCollection( [ { id:"en_US", label:"English" } ] );
			
			preferences = new Preferences();
		}

		private function dispatchDataLoad( data:* ):void
		{
			var evt:ApplicationDataEvent = new ApplicationDataEvent( ApplicationDataEvent.LOADED, true );
			evt.data = data;
			dispatchEvent( evt );
		}
		
		public function get patientAlertsLoaded():Boolean
		{
			return _patientAlertsLoaded;
		}

		public function set patientAlertsLoaded(value:Boolean):void
		{
			_patientAlertsLoaded = value;
			
			if( _patientAlertsLoaded )
			{
				dispatchDataLoad( patientAlerts );
			}
		}
	}
}