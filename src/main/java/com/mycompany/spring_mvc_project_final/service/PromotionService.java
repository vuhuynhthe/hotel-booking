/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.PromotionEntity;
import java.util.List;

/**
 *
 * @author Administrator
 */
public interface PromotionService {

    public List<PromotionEntity> getPromotions();

    public List<PromotionEntity> getPromotions(int page, int size);

    public PromotionEntity getCode(String code);

    public void savePromotion(PromotionEntity promotion);

    public PromotionEntity getPromotion(long id);

    public void deletePromotion(long id);
}
