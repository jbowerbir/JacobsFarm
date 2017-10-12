package ui 
{
	import quiz.Quiz;
	/**
	 * ...
	 * @author Ben Calvin
	 */
	public class QuizSplash extends SplashScreen
	{
		
		public function QuizSplash() 
		{
			super();
		}
		
		public function run(path:String, treatment:Number, round:int):void
		{
			var q:Quiz = new Quiz(path, treatment, round);
				q.x = 0;
				q.y = 0;
				
			addChild(q);
		}
		
	}

}