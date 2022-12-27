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

struct ApiEndpoints {
    static let baseImageURL = ""
    static let baseUrl = "http://3.144.164.127:8000/api/"
    static let baseUrl1 = "http://3.136.112.232:8000/api/"
    static let userID = "?dworks_id"
    static let login = "auth/login/"
    static let register = "auth/registration"
    static let logout = "auth/logout/"
    static let otp = "auth/verify/otp"
    static let resendOtp = "auth/resend/otp/"
    //Home
    static let homeApi = "homepage"
    static let prefrenceApi = "preference/status"
    //job
    static let createBookMarkJobs = "job/bookmark/"
    static let getJobCategory = "jobcategory"
  
    static let getTopJobs = "job/top/"
    static let customJobs = "custom/user/"
    static let savedJobs = "job/bookmark/"
    static let appliedJobs = "job/apply/"
    static let getNewJobs = "alljobs"
    
    //drop down
    static let getJobsLocation = "job/location/"
    static let getnewsCategory = "job/news/category/"
    static let getQualification = "job/search/higher/qualifiction"
    static let getSpeacilty = "job/department/"
    static let getDesignation = "job/designations/"
    static let recentSearch = "job/search/recent"
 
    //news
    static let getNews = "news"
  
   //Cases
    //user details
   
    static let getTabPost = "tab"
    //complaint
    static let getComplaint = "user/social/"
    static let getComplaintComment = "complaint/comment/"
    static let getComments = "user/social/comment"
    //Question
    static let getAllQuestion =  "all/questions"
    //Profile
    static let getProfileDetails = "group/profile"
    static let getProfile = "auth/register"
    static let profileEdit = "auth/profileupdate"
    static let personalEdit = "user/personal/info"
    static let professionalEdit = "job/profile/"
    static let addExperience = "user/add/exp"
    static let professionalData = "user/profession/info"
    static let addCase = "casesheet"
    static let applyJob = "job/apply/"
   

    static let questions = "comment/question/post/"
    static let complaintFollow = "auth/follow/"
   
    static let jobsCount = "custom/user/"
    static let searchJobs = "job/search/"
    static let trendingQuestion = "popular"
  
    static let userPostedReplied = "ask/question/reply/show"
    static let getBookMarks = "bookmarks"
    //Network
    static let getNetworkConnections = "groups"
    static let getFollow = "auth/follow"
    static let getFollowing = "auth/following"
    static let getRequest = "auth/request/"
    static let getPeoples = "people"
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
    static let jobDetails = "alljobs"
  
    static let getInterest = "connect/dating/interest"
    //Shop
    static let shopData = "sale/product"
    static let shopCategory = "sale/category"
    static let shopBanner = "admin/banner/get?name=shop store image"
    static let shopSale = "sale/userrelatedproducts"
    static let shopRecent = "shopping/product/view"
    static let shopBookmark = "shopping/product/bookmark"
    static let postProduct = "shopping/product/post"
    //Elearning
    static let learningBanner = "admin/banner/get?name=elearningimage"
    static let trendingCourses = "learning/trending"
    static let courses = "learning/category/"
    static let categories = "learning/category/"
    static let courseDetails = "learning/topic"
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
