/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.service;

import com.mycompany.spring_mvc_project_final.entities.RoomEntity;
import com.mycompany.spring_mvc_project_final.enums.RoomStatus;
import java.util.Date;
import java.util.List;
import java.util.Set;

/**
 *
 * @author Administrator
 */
public interface RoomService {

    public List<RoomEntity> getRooms();

    public List<RoomEntity> getRooms(int index, int size);

    public Set<RoomEntity> getRoomsByCategory(long categoryId);

    public RoomEntity getRoom(long id);

    public RoomEntity getRoom(String roomNumber);

    public void saveRoom(RoomEntity room);

    public Set<RoomEntity> findRoomAvaiable(Date d1, Date d2, long id);

    public Set<RoomEntity> getRoomByStatus(RoomStatus status);

    public void deleteRoom(long id);
}
