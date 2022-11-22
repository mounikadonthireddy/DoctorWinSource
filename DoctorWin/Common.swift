//
//  Common.swift
//  MvvmDemoApp
//
//  Created by CodeCat15 on 3/14/20.
//  Copyright © 2020 Codecat15. All rights reserved.
//

import Foundation

struct Constants {
    static let ErrorAlertTitle = "Error"
    static let OkAlertTitle = "Ok"
    static let CancelAlertTitle = "Cancel"
}

struct ApiEndpoints
{
    static let baseImageURL = ""
    static let baseUrl = "https://api.doctorworld.live/api/"
    static let baseUrl1 = "http://3.136.112.232:8000/api/"
    static let userID = "?dworks_id"
    static let login = "auth/registration"
    static let logout = "auth/logout/"
    
    static let registration = ""
    static let otp = "auth/otp"
    //    static let resendOtp = "auth/resend/otp/"
    
    static let stories = "banner/job/"
    static let bannerPromotons = "banner/promotional/"
    static let collegeInfo = "college/info/get/"
    static let homeApi = ""
    static let pollLikeApi = ""
    static let articalLikeApi = ""
    static let postLikeApi = ""
    static let complaintLikeApi = "comment/answer/like/"
    static let complaintPostApi = "comment/answer/post/"
    static let complaintquestionLike = "comment/question/like/"
    //    static let complaintquestionLike = "comment/question/like/"
    
    
    //job
    static let getJobs = "job/apply/"
    static let applyJobs = "job/apply/"
    static let getBookMarkJobs = "job/bookmark/"
    static let createBookMarkJobs = "job/bookmark/"
    static let getJobCategory = "job/category/"
    static let applyJobCategory = "job/category/"
    static let deleteJobCategory = "job/category/"
    static let putJobCategory = "job/category/"
    static let getDepartments = "job/department/"
    static let getDesignations = "job/desinations/"
    static let getLikedJobs = "job/like/"
    static let likeJobs = "job/like/"
    static let getJobsLocation = "job/location/"
    static let getnewsCategory = "job/news/category/"
    static let getnewsCategoryArtical = "job/news/category/artical/"
    static let getPostedJobs = "job/post/"
    static let postJob = "job/post/"
    static let getJobProfile = "job/profile/"
    static let postJobProfile = "job/profile/"
    static let searchJob = "job/search/"
    static let graduationJobSearch = "job/search/graduation/"
    static let positionJobSearch = "job/search/position/"
    static let jobSearchResult = "job/search/result/"
    static let specialistJobSearch = "job/search/specialist/"
    static let stateJobSearch = "job/search/state/"
    static let stateLocationJobSearch = "job/search/state/location/"
    static let superSpecialistJobSearch = "job/search/super/specialist/"
    
    static let getTopJobs = "job/top/"
    static let customJobs = "custom/user/"
    static let savedJobs = "job/bookmark/"
    static let appliedJobs = "job/apply/"
    
    //new Job
    static let getNewJobs = "new/job/"
    static let applyNewJobs = "new/job/"
    static let postNewJobs = "new/job/"
    static let deleteNewJobs = "new/job/"
    
    //news
    static let getArtical = "news/artical/post/"
    static let getArticalComment = "news/artical/comment/"
    static let postArticalComment = "news/artical/comment/"
    static let getArticalPost = "news/artical/post/"
    static let getCollegeStory = "news/college/story/"
    static let postCollegeStory = "news/college/story/"
    static let postMultiImageStory = "news/multi_imge/post/"
    static let postedNews = "user/news"
    static let bookmarkNews = "user/news/bookmarks"
    static let likedNews = "user/news/likes"
    static let bookmarkArtical = "user/artical/bookmarks"
    static let likedArtical = "user/artical/likes"
    static let postedArtical = "user/artical"
    static let postedPoll = "user/poll"
    static let pollLike = "user/poll/likes"
    static let pollBookmark = "user/poll/bookmarks"
    
    static let postedCases = "user/case"
    static let bookmarkCases = "user/case/bookmarks"
    static let likedCases = "user/case/likes"
    //poll
    static let getPollComment = "news/poll/comment/"
    static let postPollComment = "news/poll/comment/"
    static let getPollComplaint = "news/test/homepage"
    static let postPollComplaint = "news/poll/complaint/"
    static let postPollPost = "news/poll/post/"
    static let getPollPost = "news/poll/post/"
    static let getPollTest = "news/poll/test/"
    static let postPollVote = "news/poll/vote/"
    static let bookmarkComplaint = "complaint/bookmarks"
    static let bookmarkSocail = "user/social/bookmark"
    static let bookmarkAnswer = "ask/question/reply/bookmark"
    
    //cases
    static let casesLike = "user/social/like"
    static let casesBookmarks = "user/social/bookmark"
    //user
    
    static let getUserExp = "user/add/exp/"
    static let postUserExp = "user/add/exp/"
    static let editUserExp = "user/add/exp/"
    static let deleteUserExp = "user/add/exp/"
    static let getUserAll = "user/all/"
    static let getUserPersonalInfo = "user/personal/info/"
    static let editUserPersonalInfo = "user/personal/info/"
    static let getUserProfessionInfo = "user/profession/info/"
    
    //user details
    static let getUserPostedPosts  = "user/social/"
    static let getUserPostedCases  = "complaint/case"
    static let getUserPostedQuestions  = "ask/question"
    static let getUserPostedAnswers  = "ask/question/reply/show"
    
    //complaint
    static let getComplaint = "user/social/"
    static let getComplaintComment = "complaint/comment/"
    static let getComments = "user/social/comment"
    
    
    static let profileEdit = "job/profile/"
    static let personalEdit = "user/personal/info"
    static let professionalEdit = "job/profile/"
    static let addExperience = "user/add/exp"
    static let professionalData = "user/profession/info"
    
    static let addPoll = "news/poll/post/"
    static let addCase = "complaint/post"
    
    static let applyJob = "job/apply/"
    static let jobLike = "job/like/"
    static let complaintBookmark = "/job/bookmark/"
    static let questions = "comment/question/post/"
    static let complaintLike = "job/like/"
    static let complaintFollow = "auth/follow/"
    static let getQualification = "job/search/higher/qualifiction"
    static let getSpeacilty = "job/department/"
    static let resendOtp = "auth/resend/otp/"
    static let newsCategory = "admin/page/post"
    static let getDesignation = "job/designations/"
    static let recentSearch = "job/search/recent"
    static let jobsCount = "custom/user/"
    static let searchJobs = "job/search/"
    static let trendingQuestion = "ask/question/popular"
    static let userPostedQA = "ask/question"
    static let userPostedReplied = "ask/question/reply/show"
    //Network
    static let getNetworkConnections = "group/create"
    static let getFollow = "auth/follow"
    static let getFollowing = "auth/following"
    static let getRequest = "auth/request/"
    static let getPeoples = "test/connection"
    static let createGroup = "group/create"
    static let postQuestion = "ask/question"
    
    //Requested User
    
    static let userCases = "user/case"
    static let userNews = "user/news"
    static let userArtical = "user/artical"
    static let userDetails = "job/profile/"
    
    //connect
    static let getProfession = "connect/dating/profession"
    static let editProfile = "connect/dating/profile/create/"
    //Carrier
    
    static let jobDetails = "new/job"
    static let hospitalDetails = "new/job/hospital/details"
    static let getInterest = "connect/dating/interest"
    
    //Shop
    static let shopData = "shopping/product/image/"
    static let shopCategory = "shopping/product/category"
    static let shopBanner = "admin/banner/get?name=shop store image"
    static let shopSale = "shopping/product/upload"
    static let shopRecent = "shopping/product/view"
    static let shopBookmark = "shopping/product/bookmark"
    
    //Elearning
    static let learningBanner = "admin/banner/get?name=elearningimage"
    static let trendingCourses = "learning/subject/feature"
    static let courses = "learning/subject/option"
    static let categories = "learning/banner/app/"
    static let courseDetails = "learning/subject/get/"
    static let curriculamDetails = "learning/subject/"
    //MCQ
    static let mcq = "user/question"
    static let attemptedMcq = "user/question/attempt"
    
    //Dating
    static let dating = "connect/dating/recommed/profile"
    static let myLikes = "connect/dating/i/likes/you/"
    static let otherLikes = "connect/dating/you/likes/me/"
    static let likeProfile = "connect/dating/you/likes/me/"
    static let skiprofile = "connect/dating/skip/profile"
    static let undoProfile = "connect/dating/undo/skip/profile"
    
}

class User {
    static let shared = User()
    private init() {
        
    }
    var userID: String = ""
    var token: String = ""
}
