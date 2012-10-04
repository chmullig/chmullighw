/**
 * COMSW1007, Kender, Fall 2012, Assignment 1, Programming Step 1
 * <p>
 * Object oriented Java Hello World application.
 * Execute this class. It news up an instance of the Greeter class and asks it
 * to say hello the constant GREETSUBJECT REPETITIONS times.
 * 
 * @author Chris Mulligan clm2186@columbia.edu
 * @version 0.1
 */

public class Tester {
	
	private static final String GREETSUBJECT = "World";
	private static final int REPETITIONS = 4;

	/**
	 * Main method that should be executed when you wish to say hello to the
	 * world. Creates a Greeter instance with the GREETSUBJECT constant,
	 * then calls greetN to do the greeting REPETITIONS times. 
	 * 
	 * @param args Unused command line arguments.
	 */
	public static void main(String[] args) {
		Greeter myGreeter = new Greeter(GREETSUBJECT);
		myGreeter.greetN(REPETITIONS);
	}

}
