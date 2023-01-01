/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.ConvenientEntity;
import com.mycompany.spring_mvc_project_final.repository.ConvenientRepository;
import java.util.ArrayList;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrator
 */
@Service
public class ConvenientServiceImpl implements ConvenientService {

    @Autowired
    private ConvenientRepository convenientRepository;

    @Override
    public List<ConvenientEntity> getConvenients() {
        List<ConvenientEntity> convenients = convenientRepository.findAll();
        if (convenients != null) {
            return convenients;
        }
        return new ArrayList<>();
    }

    @Override
    public List<ConvenientEntity> getConvenients(int page, int size) {
        List<ConvenientEntity> convenients = convenientRepository.getConvenientsAndPaging(PageRequest.of(page, size));
        if (convenients != null) {
            return convenients;
        }
        return new ArrayList<>();
    }

    @Override
    public void saveConvenient(ConvenientEntity convenient) {
        convenientRepository.save(convenient);
    }

    @Override
    public ConvenientEntity getConvenient(long id) {
        return convenientRepository.findById(id).get();
    }

    @Override
    public void deleteConvenient(long id) {
        convenientRepository.deleteById(id);
    }

}
