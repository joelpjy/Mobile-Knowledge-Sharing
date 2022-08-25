package com.netvirta.mobile_knowledge_sharing_app

data class Quiz(
    private val question: String,
    private val answer: Int,
    private val choices: List<String>
)

val listOfQuestions1 = listOf(
    Quiz(
        question = "Who is not one of the mobile team member??",
        choices = listOf(
            "Yu Long",
            "Karen",
            "JT",
            "Jonathan",
            "Joel",
            "hai",
            "Chris",
        ),
        answer = 4,
    ),
)

val listOfQuestions2 = listOf(
    Quiz(
        question = "Which one is not part of testing regiment?",
        choices = listOf(
            "Unit Testing",
            "Penetration Testing",
            "Instrumental Testing",
            "Performance Testing"
        ),
        answer = 1
    ),

    /**
     * More questionsa nd answers
     * How can mobile CI helps in improving the quality of applications
     * A - Faster feedback loop
     * B - Ensure regression doesn't happen often
     * C - Maintain code quality
     * D - Reduce the involvement of developers in coding
     */

    /**
     * Profiler?
     * Documentation?
     * Code Style?
     * 
     */
)