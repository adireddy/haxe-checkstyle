package checks.comments;

import checkstyle.checks.comments.TypeDocCommentCheck;

class TypeDocCommentCheckTest extends CheckTestCase<TypeDocCommentCheckTests> {

	@Test
	public function testDefault() {
		var check = new TypeDocCommentCheck();
		checkComments(check, "TTest");
	}

	@Test
	public function testAbstract() {
		var check = new TypeDocCommentCheck();
		check.tokens = [ABSTRACT_DEF];
		checkComments(check, "ATest");
	}

	@Test
	public function testClass() {
		var check = new TypeDocCommentCheck();
		check.tokens = [CLASS_DEF];
		checkComments(check, "CTest");
	}

	@Test
	public function testEnum() {
		var check = new TypeDocCommentCheck();
		check.tokens = [ENUM_DEF];
		checkComments(check, "ETest");
	}

	@Test
	public function testImterface() {
		var check = new TypeDocCommentCheck();
		check.tokens = [INTERFACE_DEF];
		checkComments(check, "ITest");
	}

	@Test
	public function testTypedef() {
		var check = new TypeDocCommentCheck();
		check.tokens = [TYPEDEF_DEF];
		checkComments(check, "TTest");
	}

	function checkComments(check:TypeDocCommentCheck, name:String, ?pos:PosInfos) {
		assertNoMsg(check, ALL_TYPES_COMMENTED, pos);
		assertMsg(check, EMPTY_COMMENTS, 'Documentation for type "$name" should have at least one extra line of text', pos);
		assertMsg(check, EMPTY_COMMENTS_2, 'Documentation for type "$name" should have at least one extra line of text', pos);
		assertMsg(check, EMPTY_COMMENTS_3, 'Documentation for type "$name" should contain text', pos);
		assertMsg(check, NO_COMMENTS, 'Type "$name" should have documentation', pos);
	}
}

@:enum
abstract TypeDocCommentCheckTests(String) to String {
	var ALL_TYPES_COMMENTED = "
	/**
		comment
	 **/
	abstract ATest {}

	/**
		comment
	 **/
	class CTest {}

	/**
		comment
	 **/
	enum ETest {}

	/**
		comment
	 **/
	interface ITest {}

	/**
		comment
	 **/
	typedef TTest = {}
	";

	var EMPTY_COMMENTS = "
	/**

	 **/
	abstract ATest {}

	/**

	 **/
	class CTest {}

	/**

	 **/
	enum ETest {}

	/**

	 **/
	interface ITest {}

	/**

	 **/
	typedef TTest = {}
	";

	var EMPTY_COMMENTS_2 = "
	/**
	 **/
	abstract ATest {}

	/**
	 **/
	class CTest {}

	/**
	 **/
	enum ETest {}

	/**
	 **/
	interface ITest {}

	/**
	 **/
	typedef TTest = {}
	";

	var EMPTY_COMMENTS_3 = "
	/*

	 */
	abstract ATest {}

	/*

	 */
	class CTest {}

	/*

	 */
	enum ETest {}

	/*

	 */
	interface ITest {}

	/*

	 */
	typedef TTest = {}
	";

	var NO_COMMENTS = "
	abstract ATest {}
	class CTest {}
	enum ETest {}
	interface ITest {}
	typedef TTest = {}
	";
}