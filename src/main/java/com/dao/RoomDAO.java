package com.dao;

import com.entities.Rooms;

import java.util.List;

public interface RoomDAO {

    Rooms getRoomById(int id);
    List<Rooms> getAllRooms();

    List<Rooms> getAllAvailableRooms();

    boolean updateRoom(Rooms room);
    boolean deleteRoom(int id);
    boolean addRoom(Rooms room);


}