/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import com.mycompany.spring_mvc_project_final.repository.PromotionRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

/**
 *
 * @author win
 */
@Service
public class PromotionServiceImpl implements PromotionService {

    @Autowired
    private PromotionRepository promotionRepository;

    @Override
    public List<PromotionEntity> getPromotions() {
        List<PromotionEntity> promotions = promotionRepository.findAll();
        if (promotions != null) {
            return promotions;
        }
        return new ArrayList<>();
    }

    @Override
    public List<PromotionEntity> getPromotions(int page, int size) {
        List<PromotionEntity> promotions = promotionRepository.getPromotionsAndPaging(PageRequest.of(page, size));
        if (promotions != null) {
            return promotions;
        }
        return new ArrayList<>();
    }

    @Override
    public PromotionEntity getCode(String code) {
        return promotionRepository.findByCode(code);
    }

    @Override
    public void savePromotion(PromotionEntity promotion) {
        promotionRepository.save(promotion);
    }

    @Override
    public PromotionEntity getPromotion(long id) {
        return promotionRepository.findById(id).get();
    }

    @Override
    public void deletePromotion(long id) {
        promotionRepository.deleteById(id);
    }
}
