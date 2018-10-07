package oms.order;

import java.util.*;
import java.io.Serializable;
import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import oms.movie.Movie;

@XmlAccessorType(XmlAccessType.FIELD)
@XmlRootElement(name = "history", namespace = "http://www.uts.edu.au/31284/oms")
public class Orders implements Serializable {

    @XmlElement(name = "order")
    private ArrayList<Order> historylist = new ArrayList<Order>();

    public ArrayList<Order> getHistoryList() {
        return historylist;
    }

    public void addOrder(Order order) {
        historylist.add(order);
    }

    public void removeOrder(Order order) {
        historylist.remove(order);
    }

    public Order checkId(String id) {
        for (Order order : historylist) {
            if (order.getId().equals(id)) {
                return order;
            }
        }
        return null;
    }

    public Order checkEmail(String email) {
        for (Order order : historylist) {
            if (order.getEmail().equals(email)) {
                return order;
            }
        }
        return null;
    }

    public Order checkTitle(String title) {
        for (Order order : historylist) {
            for (Movie movie : order.getMovies()){
                if (movie.getTitle().equals(title)) {
                    return order;
                }
            }
        }
        return null;
    }

    public Order checkStatus(String status) {
        for (Order order : historylist) {
            if (order.getEmail().equals(status)) {
                return order;
            }
        }
        return null;
    }

}
