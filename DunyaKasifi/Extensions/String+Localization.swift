import Foundation

extension String {
    
    static let appTitle = NSLocalizedString("AppTitle", comment: "The title of the application")
    static let welcomeMessage = NSLocalizedString("WelcomeMessage", comment: "Welcome message for the user")
    static let loginButton = NSLocalizedString("LoginButton", comment: "Login button title")
    static let signUpButton = NSLocalizedString("SignUpButton", comment: "Sign up button title")
    static let logoutButton = NSLocalizedString("LogoutButton", comment: "Logout button title")
    
    static let settingsTitle = NSLocalizedString("SettingsTitle", comment: "Title for the settings screen")
    static let languagePreference = NSLocalizedString("LanguagePreference", comment: "Language preference label")
    static let notifications = NSLocalizedString("Notifications", comment: "Notifications setting label")
    
    static let homeTitle = NSLocalizedString("HomeTitle", comment: "Home screen title")
    static let exploreButton = NSLocalizedString("ExploreButton", comment: "Explore button in the home screen")
    static let searchPlaceholder = NSLocalizedString("SearchPlaceholder", comment: "Search field placeholder")
    
    static let profileTitle = NSLocalizedString("ProfileTitle", comment: "Profile screen title")
    static let editProfileButton = NSLocalizedString("EditProfileButton", comment: "Button to edit the profile")
    static let userInfoLabel = NSLocalizedString("UserInfoLabel", comment: "Label for user information")
    
    static let errorMessageNoInternet = NSLocalizedString("ErrorMessageNoInternet", comment: "Error message when no internet connection")
    static let errorMessageInvalidCredentials = NSLocalizedString("ErrorMessageInvalidCredentials", comment: "Error message for invalid credentials")
    static let errorMessageUnexpected = NSLocalizedString("ErrorMessageUnexpected", comment: "Unexpected error message")
    
    static let missionListTitle = NSLocalizedString("MissionListTitle", comment: "Title for the mission list screen")
    static let missionCompleted = NSLocalizedString("MissionCompleted", comment: "Message shown when a mission is completed")
    static let missionProgress = NSLocalizedString("MissionProgress", comment: "Message showing mission progress")
    
    static let rewardEarned = NSLocalizedString("RewardEarned", comment: "Message showing a reward has been earned")
    static let rewardPoints = NSLocalizedString("RewardPoints", comment: "Reward points message")
    
    static let countryInfoTitle = NSLocalizedString("CountryInfoTitle", comment: "Country information screen title")
    static let countryDetails = NSLocalizedString("CountryDetails", comment: "Details of the selected country")
    
    static let languageEnglish = NSLocalizedString("LanguageEnglish", comment: "English language option")
    static let languageSpanish = NSLocalizedString("LanguageSpanish", comment: "Spanish language option")
    static let languageFrench = NSLocalizedString("LanguageFrench", comment: "French language option")
    static let languageGerman = NSLocalizedString("LanguageGerman", comment: "German language option")
    static let languageTurkish = NSLocalizedString("LanguageTurkish", comment: "Turkish language option")
    
    static let countryInfo = NSLocalizedString("CountryInfo", comment: "Country information")
    static let landmarkName = NSLocalizedString("LandmarkName", comment: "Name of a landmark")
    static let cityName = NSLocalizedString("CityName", comment: "City name")
    
    static let logoutConfirmationMessage = NSLocalizedString("LogoutConfirmationMessage", comment: "Confirmation message for logout action")
    static let logoutConfirmationTitle = NSLocalizedString("LogoutConfirmationTitle", comment: "Confirmation title for logout action")
    static let logoutCancelButton = NSLocalizedString("LogoutCancelButton", comment: "Cancel button for logout action")
    static let logoutConfirmButton = NSLocalizedString("LogoutConfirmButton", comment: "Confirm button for logout action")
    
    static let settingsLanguage = NSLocalizedString("SettingsLanguage", comment: "Language setting in the settings screen")
    static let settingsNotifications = NSLocalizedString("SettingsNotifications", comment: "Notifications setting in the settings screen")
    
    static let privacyPolicyTitle = NSLocalizedString("PrivacyPolicyTitle", comment: "Privacy Policy screen title")
    static let termsOfServiceTitle = NSLocalizedString("TermsOfServiceTitle", comment: "Terms of Service screen title")
    
    static let helpCenterTitle = NSLocalizedString("HelpCenterTitle", comment: "Help Center screen title")
    static let helpCenterFAQ = NSLocalizedString("HelpCenterFAQ", comment: "FAQ section in the help center")
    
    static let ratingPromptTitle = NSLocalizedString("RatingPromptTitle", comment: "Rating prompt title")
    static let ratingPromptMessage = NSLocalizedString("RatingPromptMessage", comment: "Message asking users to rate the app")
    static let ratingPromptCancelButton = NSLocalizedString("RatingPromptCancelButton", comment: "Cancel button in the rating prompt")
    static let ratingPromptSubmitButton = NSLocalizedString("RatingPromptSubmitButton", comment: "Submit button in the rating prompt")
    
    static let newMessageNotification = NSLocalizedString("NewMessageNotification", comment: "Notification for a new message")
    static let messageReceived = NSLocalizedString("MessageReceived", comment: "Message received notification")
    
    static let appName = NSLocalizedString("AppName", comment: "The name of the app")
    
    static let onboardingWelcomeMessage = NSLocalizedString("OnboardingWelcomeMessage", comment: "Welcome message during onboarding")
    static let onboardingContinueButton = NSLocalizedString("OnboardingContinueButton", comment: "Continue button during onboarding")
    
    static let tutorialStartButton = NSLocalizedString("TutorialStartButton", comment: "Start tutorial button")
    static let tutorialSkipButton = NSLocalizedString("TutorialSkipButton", comment: "Skip tutorial button")
    
    static let tutorialStep1 = NSLocalizedString("TutorialStep1", comment: "Tutorial step 1 description")
    static let tutorialStep2 = NSLocalizedString("TutorialStep2", comment: "Tutorial step 2 description")
    static let tutorialStep3 = NSLocalizedString("TutorialStep3", comment: "Tutorial step 3 description")
    
    static let appUpdateRequiredMessage = NSLocalizedString("AppUpdateRequiredMessage", comment: "Message telling the user an app update is required")
    static let appUpdateNowButton = NSLocalizedString("AppUpdateNowButton", comment: "Button to update the app")
    static let appUpdateLaterButton = NSLocalizedString("AppUpdateLaterButton", comment: "Button to update later")
    
    static let networkErrorMessage = NSLocalizedString("NetworkErrorMessage", comment: "Network error message")
    
    static let feedbackThankYou = NSLocalizedString("FeedbackThankYou", comment: "Thank you message for feedback")
    static let feedbackErrorMessage = NSLocalizedString("FeedbackErrorMessage", comment: "Error message during feedback submission")
    
    static let errorLoadingContent = NSLocalizedString("ErrorLoadingContent", comment: "Error message for loading content")
    static let tryAgainButton = NSLocalizedString("TryAgainButton", comment: "Try again button")
    
    static let viewDetailsButton = NSLocalizedString("ViewDetailsButton", comment: "View details button")
    static let closeButton = NSLocalizedString("CloseButton", comment: "Close button")
    
    static let itemNotFoundMessage = NSLocalizedString("ItemNotFoundMessage", comment: "Message shown when item is not found")
    static let itemNotFoundRetryButton = NSLocalizedString("ItemNotFoundRetryButton", comment: "Retry button when item is not found")
    
    static let languageSettingChangedMessage = NSLocalizedString("LanguageSettingChangedMessage", comment: "Message shown when the language setting is changed")
    static let restartAppMessage = NSLocalizedString("RestartAppMessage", comment: "Message asking to restart the app after language change")
    
    static let feedbackRequestMessage = NSLocalizedString("FeedbackRequestMessage", comment: "Message asking for feedback")
    static let feedbackRequestTitle = NSLocalizedString("FeedbackRequestTitle", comment: "Title for feedback request")
    
    static let retryButton = NSLocalizedString("RetryButton", comment: "Retry button label")
    
    static let sessionExpiredMessage = NSLocalizedString("SessionExpiredMessage", comment: "Message shown when session has expired")
    
    static let noResultsFoundMessage = NSLocalizedString("NoResultsFoundMessage", comment: "Message shown when no results are found")
    
    static let placeholderTextField = NSLocalizedString("PlaceholderTextField", comment: "Placeholder text in the search field")
    
    static let actionRequiredTitle = NSLocalizedString("ActionRequiredTitle", comment: "Action required title")
    static let actionRequiredMessage = NSLocalizedString("ActionRequiredMessage", comment: "Action required message")
    
    static let sessionTimeoutMessage = NSLocalizedString("SessionTimeoutMessage", comment: "Message indicating session timeout")
    
    static let submitFeedbackButton = NSLocalizedString("SubmitFeedbackButton", comment: "Submit feedback button")
    
    static let homeScreenTitle = NSLocalizedString("HomeScreenTitle", comment: "Home screen title")
    
    static let taskCompletedMessage = NSLocalizedString("TaskCompletedMessage", comment: "Message indicating task completion")
}
// Placeholder for \(file) content.
