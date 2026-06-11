package com.dao;

import com.entities.Planning;
import java.util.Date;

public interface PlanningDAO {

    boolean isRoomAvailable(int chambreId, Date dateDebut, Date dateFin);

    void addPlanning(Planning planning);

}
