//
//  GeminiResponse.swift
//  ChatApp
//
//  Created by Admin on 12/02/24.
//

import Foundation

struct GeminiResponse: Codable {
    var candidates: [Candidate]?
    var promptFeedback: PromptFeedback?
}

// MARK: - Candidate
struct Candidate: Codable {
    var content: Content?
    var finishReason: String?
    var index: Int?
    var safetyRatings: [SafetyRating]?
}

// MARK: - Content
struct Content: Codable {
    var parts: [Part]?
    var role: String?
}

// MARK: - Part
struct Part: Codable {
    var text: String?
}

// MARK: - SafetyRating
struct SafetyRating: Codable {
    var category, probability: String?
}

// MARK: - PromptFeedback
struct PromptFeedback: Codable {
    var safetyRatings: [SafetyRating]?
}
