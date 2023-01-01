/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.entities;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import org.hibernate.annotations.LazyCollection;
import org.hibernate.annotations.LazyCollectionOption;

/**
 *
 * @author Administrator
 */
@Entity
@Table(name = "booking_detail")
public class BookingDetailEntity implements Serializable {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @ManyToOne
    @JoinColumn(name = "booking_id")
    private BookingEntity booking;

    @ManyToOne
    @JoinColumn(name = "room_id")
    private RoomEntity room;

    @OneToMany(mappedBy = "bookingDetail", cascade = CascadeType.ALL, orphanRemoval = true)
    @LazyCollection(LazyCollectionOption.FALSE)
    private List<ServiceBookingEntity> serviceBookings = new ArrayList<>();

    @OneToMany(mappedBy = "bookingDetail", cascade = CascadeType.ALL, orphanRemoval = true)
    @LazyCollection(LazyCollectionOption.FALSE)
    private Set<VisitorEntity> visitors = new HashSet<>();

    private double price;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    public BookingEntity getBooking() {
        return booking;
    }

    public void setBooking(BookingEntity booking) {
        this.booking = booking;
    }

    public RoomEntity getRoom() {
        return room;
    }

    public void setRoom(RoomEntity room) {
        this.room = room;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public List<ServiceBookingEntity> getServiceBookings() {
        return serviceBookings;
    }

    public void setServiceBookings(List<ServiceBookingEntity> serviceBookings) {
        this.serviceBookings = serviceBookings;
    }

    public Set<VisitorEntity> getVisitors() {
        return visitors;
    }

    public void setVisitors(Set<VisitorEntity> visitors) {
        this.visitors = visitors;
    }

    public List<ServiceBookingEntity> showServiceBookings() {
        Map<Long, ServiceBookingEntity> m = new HashMap<>();
        for (ServiceBookingEntity elem : this.serviceBookings) {
            ServiceBookingEntity oldElem = m.put(elem.getService().getId(), elem);
            if (oldElem != null) {
                elem.setQuantity(elem.getQuantity() + oldElem.getQuantity());
            }
        }

        return new ArrayList<>(m.values());
    }
}
