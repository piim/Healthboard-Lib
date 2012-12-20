package models
{
	import ASclasses.Constants;
	
	import events.ApplicationDataEvent;
	import events.ApplicationEvent;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	
	import styles.ChartStyles;

	[Bindable]
	public class ApplicationModel extends EventDispatcher
	{
		public var context:String;
		
		public var fullname:String;
		
		public var patientAlerts:ArrayCollection;
		
		public var chartStyles:ChartStyles;
		
		private var _patientAlertsLoaded:Boolean;
		
		public var today:Date;
		
		public var viewMode:String = Constants.STATE_LOGGED_IN;
		
		public var settings:ArrayCollection;
		
		public var preferences:Preferences;
		
		public var supportedLanguages:ArrayCollection;
		
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