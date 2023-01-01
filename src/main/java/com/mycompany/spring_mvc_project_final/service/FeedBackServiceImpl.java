/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.FeedbackEntity;
import com.mycompany.spring_mvc_project_final.repository.FeedBackRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author win
 */
@Service
public class FeedBackServiceImpl implements FeedBackService {

    @Autowired
    private FeedBackRepository feedBackRepository;

    @Override
    public List<FeedbackEntity> getFeedBack() {
        List<FeedbackEntity> feedbacks = feedBackRepository.findAll();
        if (feedbacks != null) {
            return feedbacks;
        }
        return new ArrayList<>();
    }

    @Override
    public void save(FeedbackEntity feed) {
        feedBackRepository.save(feed);
    }

    @Override
    public FeedbackEntity getEmail(String email) {
        return feedBackRepository.findByEmailLike(email);
    }

    @Override
    public List<FeedbackEntity> getTop5() {
        List<FeedbackEntity> feedbacks = feedBackRepository.findTop5ByOrderByCreateDateDesc();
        if (feedbacks != null) {
            return feedbacks;
        }
        return new ArrayList<>();
    }
}
