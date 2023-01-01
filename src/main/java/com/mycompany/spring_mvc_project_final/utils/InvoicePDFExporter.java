/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.mycompany.spring_mvc_project_final.utils;

import com.lowagie.text.Document;
import com.lowagie.text.Font;
import com.lowagie.text.FontFactory;
import com.lowagie.text.PageSize;
import com.lowagie.text.Paragraph;
import com.lowagie.text.Phrase;
import com.lowagie.text.pdf.PdfPCell;
import com.lowagie.text.pdf.PdfPTable;
import com.lowagie.text.pdf.PdfWriter;
import com.mycompany.spring_mvc_project_final.entities.BookingDetailEntity;
import com.mycompany.spring_mvc_project_final.entities.BookingEntity;
import com.mycompany.spring_mvc_project_final.entities.ServiceBookingEntity;
import java.awt.Color;
import java.io.IOException;
import java.text.ParseException;
import java.util.Date;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Administrator
 */
public class InvoicePDFExporter {

    private BookingEntity booking;

    public InvoicePDFExporter(BookingEntity booking) {
        this.booking = booking;
    }

    private void writeTableHeader(PdfPTable table) {
        PdfPCell cell = new PdfPCell();
        cell.setPadding(5);

        Font font = FontFactory.getFont(FontFactory.HELVETICA);
        font.setColor(Color.BLACK);

        cell.setPhrase(new Phrase("#", font));

        table.addCell(cell);

        cell.setPhrase(new Phrase("", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Quantity", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Price", font));
        table.addCell(cell);

        cell.setPhrase(new Phrase("Unit Price", font));
        table.addCell(cell);
    }

    private void writeTableData(PdfPTable table) throws ParseException {
        int day = (int) ((booking.getCheckout().getTime() - booking.getCheckin().getTime()) / 86400000);

        table.addCell("Booking date:");
        table.addCell(ManagerUtils.formatDateTime(booking.getBookingDate()));
        table.addCell("");
        table.addCell("");
        table.addCell("");

        table.addCell("Checkin:");
        table.addCell(ManagerUtils.formatDate(booking.getCheckin()));
        table.addCell("");
        table.addCell("");
        table.addCell("");

        table.addCell("Checkout:");
        table.addCell(ManagerUtils.formatDate(booking.getCheckout()));
        table.addCell("");
        table.addCell("");
        table.addCell("");

        table.addCell("Numbers of room:");
        table.addCell("");
        table.addCell(booking.getBookingDetails().size() + "");
        table.addCell("");
        table.addCell("");

        table.addCell("Number of rental days:");
        table.addCell("");
        table.addCell(day + "");
        table.addCell("");
        table.addCell("");

        for (BookingDetailEntity bdt : booking.getBookingDetails()) {
            table.addCell("Room:");
            table.addCell("" + bdt.getRoom().getRoomCategory().getName());
            table.addCell("");
            table.addCell("" + ManagerUtils.formatPrice(bdt.getPrice()));
            table.addCell("" + ManagerUtils.formatPrice(bdt.getPrice() * day));

            table.addCell("Service:");
            table.addCell("");
            table.addCell(bdt.getServiceBookings().size() + "");
            table.addCell("");
            table.addCell("");

            for (ServiceBookingEntity svb : bdt.showServiceBookings()) {
                table.addCell("");
                table.addCell("" + svb.getService().getName());
                table.addCell("" + svb.getQuantity());
                table.addCell("" + ManagerUtils.formatPrice(svb.getPrice()));
                table.addCell("" + ManagerUtils.formatPrice(svb.getPrice() * svb.getQuantity()));
            }
        }

        table.addCell("Discount:");
        table.addCell("");
        table.addCell("");
        table.addCell("");
        table.addCell(booking.getDiscount() + "%");

        table.addCell("-------------------------");
        table.addCell("-------------------------");
        table.addCell("-------------------------");
        table.addCell("-------------------------");
        table.addCell("-------------------------");

        table.addCell("");
        table.addCell("");
        table.addCell("");
        table.addCell("Total:");
        table.addCell(ManagerUtils.formatPrice(booking.total()) + "VND");

        table.addCell("Invoice creation date:");
        table.addCell(ManagerUtils.formatDateTime(new Date()));
        table.addCell("");
        table.addCell("");
        table.addCell("");
    }

    public void export(HttpServletResponse response) throws IOException, ParseException {
        Document document = new Document(PageSize.A4);
        PdfWriter.getInstance(document, response.getOutputStream());

        document.open();
        Font font = FontFactory.getFont(FontFactory.HELVETICA_BOLD);
        font.setSize(18);

        Paragraph p = new Paragraph("Receipt", font);
        p.setAlignment(Paragraph.ALIGN_CENTER);

        document.add(p);

        PdfPTable table = new PdfPTable(5);
        table.setWidthPercentage(100f);
        table.setSpacingBefore(10);

        writeTableHeader(table);
        writeTableData(table);

        document.add(table);

        document.close();
    }
}
