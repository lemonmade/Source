//
//  XMLElement+ExtensionsTests.swift
//  Source
//
//  Created by Chris Sauve on 2016-01-14.
//  Copyright © 2016 lemonmade. All rights reserved.
//

import XCTest
import Fuzi
@testable import Source

class XMLElement_ExtensionsTests: XCTestCase {
	
	let document = try! HTMLDocument(string: "<html><body><div></div><div></div></body></html>")

	func testDepthRootIsZero() {
		let root = document.root!
		XCTAssertEqual(root.depth, 0)
	}
	
	func testDepthIsNumberOfLevelsFromRoot() {
		let body = document.body!
		XCTAssertEqual(body.depth, 1)
		
		let firstDiv = body.children.first!
		XCTAssertEqual(firstDiv.depth, 2)
		
		let secondDiv = body.children.last!
		XCTAssertEqual(secondDiv.depth, 2)
	}
	
	func testIsEmpty() {
		let root = document.root!
		XCTAssertFalse(root.isEmpty)
		
		let body = document.body!
		XCTAssertFalse(body.isEmpty)
		
		let firstDiv = body.children.first!
		XCTAssertTrue(firstDiv.isEmpty)
		
		let secondDiv = body.children.last!
		XCTAssertTrue(secondDiv.isEmpty)
	}
	
	func testTokenList() {
		let attributeString = "data-foo=\"bar\" data-baz=\"qux\""
		let document = try! HTMLDocument(string: "<html><body><div \(attributeString)></div></body></html>")
		let element = document.body!.children.last!
		
		let expectedTokenList = [
			Token(content: "<div", scope: .Tag),
			Token(content: " data-foo=", scope: .AttributeName),
			Token(content: "\"bar\"", scope: .AttributeValue),
			Token(content: " data-baz=", scope: .AttributeName),
			Token(content: "\"qux\"", scope: .AttributeValue),
			Token(content: " />", scope: .Tag)
		]
		
		XCTAssertEqual(element.tokenList.count, expectedTokenList.count)
		element.tokenList.enumerate().forEach { index, token in
			XCTAssert(expectedTokenList.contains(token))
		}
	}
	
	func testTokenListWithNonEmptyLastChild() {
		let document = try! HTMLDocument(string: "<html><body><div /></body></html>")
		XCTAssertEqual(document.body!.tokenList.last, Token(content: ">", scope: .Tag))
	}
	
	func testUniqueSelectorUsesAnID() {
		let id = "MyID"
		let document = try! HTMLDocument(string: "<html><body><div id=\"\(id)\" /></body></html>")
		let node = document.body!.children.last!
		XCTAssertEqual(node.uniqueSelector, "#\(id)")
	}
	
	func testUniqueSelectorUsesAPathFromTheRoot() {
		let node = document.body!.children.last!
		XCTAssertEqual(node.uniqueSelector, "html > body:nth-child(1) > div:nth-child(2)")
	}
	
	func testUniqueSelectorForRoot() {
		XCTAssertEqual(document.root!.uniqueSelector, "html")
	}
	
	func testUniqueSelectorWithIntermediateID() {
		let id = "MyID"
		let document = try! HTMLDocument(string: "<html><body><div id=\"\(id)\"><span /></div></body></html>")
		let node = document.body!.children.first!.children.first!
		XCTAssertEqual(node.uniqueSelector, "#\(id) > span:nth-child(1)")
	}

}
