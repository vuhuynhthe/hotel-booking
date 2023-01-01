/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
import com.mycompany.spring_mvc_project_final.repository.RoomRepository;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Service;

/**
 *
 * @author Administrator
 */
@Service
public class RoomServiceImpl implements RoomService {

    @Autowired
    private RoomRepository roomRepository;

    @Override
    public List<RoomEntity> getRooms() {
        List<RoomEntity> rooms = roomRepository.findAll();
        if (rooms != null) {
            return rooms;
        }
        return new ArrayList<>();
    }

    @Override
    public List<RoomEntity> getRooms(int index, int size) {
        List<RoomEntity> rooms = roomRepository.getRoomAndPaging(PageRequest.of(index, size));
        if (rooms != null) {
            return rooms;
        }
        return new ArrayList<>();
    }

    @Override
    public Set<RoomEntity> getRoomsByCategory(long categoryId) {
        Set<RoomEntity> rooms = roomRepository.findByRoomCategory_IdLike(categoryId);
        if (rooms != null) {
            return rooms;
        }
        return new HashSet<>();
    }

    @Override
    public RoomEntity getRoom(long id) {
        return roomRepository.findById(id).get();
    }

    @Override
    public void saveRoom(RoomEntity room) {
        roomRepository.save(room);
    }

    @Override
    public RoomEntity getRoom(String roomNumber) {
        return roomRepository.findByRoomNumberLike(roomNumber);
    }

    @Override
    public Set<RoomEntity> findRoomAvaiable(Date d1, Date d2, long categoryId) {
        Set<RoomEntity> rooms = roomRepository.findRoomAvaiable(d1, d2, categoryId);
        if (rooms != null) {
            return rooms;
        }
        return new HashSet<>();
    }

    @Override
    public Set<RoomEntity> getRoomByStatus(RoomStatus status) {
        Set<RoomEntity> rooms = roomRepository.findByStatusLike(status);
        if (rooms != null) {
            return rooms;
        }
        return new HashSet<>();
    }

    @Override
    public void deleteRoom(long id) {
        roomRepository.deleteById(id);
    }

}
