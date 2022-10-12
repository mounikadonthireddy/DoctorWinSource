//
//  QuestionsViewModel.swift
//  DoctorWin
//
//  Created by N517325 on 07/12/21.
//

import Foundation
protocol QuestionsViewModelDelegate {
    func didReceiveQuestionData(response: [QuestionModel]?, error: String?)
    func didPostedQuestion(status:Bool, error: String?)
    
}
protocol QAViewModelDelegate {
    func didReceiveTrendingQuestionData(response: [AnswersModel]?, error: String?)
    func didReceiveUserQuestionData(response: [PostedQuestionModel]?, error: String?)
}
protocol RepliesViewModelDelegate {
    func didReceiveUserRepliesData(response: RepliesModel?, error: String?)
}

struct QuestionsViewModel {
    var delegate : QuestionsViewModelDelegate?
    var delegate1 : QAViewModelDelegate?
    var delegate2 : RepliesViewModelDelegate?
    func getQuestionResponseData(userID: String) {
        let resource = QuestionsResource()
        resource.getQuestionData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate?.didReceiveQuestionData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate?.didReceiveQuestionData(response: nil, error: error)
                }
                
            }
            
        }
    }
    func getMostPopularQuestions(userID: String) {
        let resource = QuestionsResource()
        resource.getTrendingQuestionData(userID: userID) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate1?.didReceiveTrendingQuestionData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate1?.didReceiveTrendingQuestionData(response: nil, error: error)
                }
                
            }
            
        }
    }
    func getMostUserPostedQuestions(userID: String, page:Int) {
        let resource = QuestionsResource()
        resource.getUserPostedQuestionData(userID: userID,page: page) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate1?.didReceiveUserQuestionData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate1?.didReceiveUserQuestionData(response: nil, error: error)
                }
                
            }
            
        }
    }
    
    func postQuestion(question: QuestionRequest, userID: String){
        
        let resource = QuestionsResource()
        resource.postQuestion(request:  question, userId: userID) { (response) in
            
            //return the response we get from loginResource
            DispatchQueue.main.async {
                switch response {
                case .success( let data):
                    if data.status == "true"  {
                        self.delegate?.didPostedQuestion(status: true, error: nil)
                    }
                    else {
                        self.delegate?.didPostedQuestion(status: false, error: "error")
                    }
                case .failure(let error):
                    self.delegate?.didPostedQuestion(status: false, error: error)
                    
                }
            }
        }
    }
    func getRepliesPostedQuestions(userID: String, page:Int, questionId: String) {
        let resource = QuestionsResource()
        resource.getUserRepliesPostedQuestions(userID: userID,page: page, questionId:questionId) { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.delegate2?.didReceiveUserRepliesData(response: data, error: nil)
                    
                case .failure(let error):
                    self.delegate2?.didReceiveUserRepliesData(response: nil, error: error)
                }
                
            }
            
        }
    }
    
}
