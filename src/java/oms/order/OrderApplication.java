package oms.order;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.Serializable;
import javax.xml.bind.JAXBContext;
import javax.xml.bind.JAXBException;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;

public class OrderApplication implements Serializable {

    private String filePath;
    private Orders orders;

    public OrderApplication() {

    }

    public OrderApplication(String filePath, Orders orders) {
        super();
        this.filePath = filePath;
        this.orders = orders;

    }

    //Sets the filepath
    public void setFilePath(String filePath) throws JAXBException, FileNotFoundException, IOException {
        JAXBContext jc = JAXBContext.newInstance(Orders.class);
        Unmarshaller u = jc.createUnmarshaller();
        this.filePath = filePath;
        FileInputStream fin = new FileInputStream(filePath);
        orders = (Orders) u.unmarshal(fin);
        fin.close();
    }

    //Gets orders
    public Orders getOrders() {
        return orders;
    }

    //Sets orders
    public void setOrders(Orders orders) throws Exception {
        this.orders = orders;
        updateXML(this.orders, this.filePath);
    }

    //This function updates the XML
    public void updateXML(Orders orders, String filePath) throws Exception {
        this.orders = orders;
        this.filePath = filePath;
        JAXBContext jc = JAXBContext.newInstance(Orders.class);
        Marshaller m = jc.createMarshaller();
        m.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);
        FileOutputStream fout = new FileOutputStream(filePath);
        m.marshal(orders, fout);
        fout.close();
    }
}
