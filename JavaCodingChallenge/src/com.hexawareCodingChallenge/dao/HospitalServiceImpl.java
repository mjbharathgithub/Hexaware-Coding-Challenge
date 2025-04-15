package com.hexareCodingChallenge.dao;


import java.sql.*;
import java.util.*;

import com.hexareCodingChallenge.entity.Appointment;
import com.hexareCodingChallenge.util.DBConnUtil;


public class HospitalServiceImpl implements HospitalService {

    private Connection conn;

    public HospitalServiceImpl() {
        try {
            conn = DBConnUtil.getConnection();
        } catch (Exception e) {
            System.out.println("Error initializing DB connection: " + e.getMessage());
        }
    }

    @Override
    public Appointment getAppointmentById(int appointmentId) {
        Appointment appointment = null;
        String query = "select * from appointment where appointment_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, appointmentId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                appointment = new Appointment(
                    rs.getInt("appointment_id"),
                    rs.getInt("patient_id"),
                    rs.getInt("doctor_id"),
                    rs.getString("appointment_date"),
                    rs.getString("description")
                );
            }
        } catch (SQLException e) {
        	System.err.println(e.getMessage());
        }
        return appointment;
    }

    @Override
    public List<Appointment> getAppointmentsForPatient(int patientId) {
        List<Appointment> list = new ArrayList<>();
        String query = "select * from appointment where patient_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, patientId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Appointment(
                    rs.getInt("appointment_id"),
                    rs.getInt("patient_id"),
                    rs.getInt("doctor_id"),
                    rs.getString("appointment_date"),
                    rs.getString("description")
                ));
            }
        } catch (SQLException e) {
        	System.err.println(e.getMessage());
        }
        return list;
    }

    @Override
    public List<Appointment> getAppointmentsForDoctor(int doctorId) {
        List<Appointment> list = new ArrayList<>();
        String query = "select * from appointment where doctor_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, doctorId);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                list.add(new Appointment(
                    rs.getInt("appointment_id"),
                    rs.getInt("patient_id"),
                    rs.getInt("doctor_id"),
                    rs.getString("appointment_date"),
                    rs.getString("description")
                ));
            }
        } catch (SQLException e) {
        	System.err.println(e.getMessage());
        }
        return list;
    }

    @Override
    public boolean scheduleAppointment(Appointment appointment) {
        String query = "insert into appointment(patient_id, doctor_id, appointment_date, description) values (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(query,Statement.RETURN_GENERATED_KEYS)) {
            stmt.setInt(1, appointment.getPatientId());
            stmt.setInt(2, appointment.getDoctorId());
            stmt.setString(3, appointment.getAppointmentDate());
            stmt.setString(4, appointment.getDescription());
            int rows = stmt.executeUpdate();
            ResultSet generatedKeys = stmt.getGeneratedKeys(); 
            if (generatedKeys.next()) {
                appointment.setAppointmentId((generatedKeys.getInt(1))); 
//                System.out.println("Appointment ID : "+ appointment.getAppointmentId());
            }
            return rows > 0;
        } catch (SQLException e) {
        	System.err.println(e.getMessage());
        }
        return false;
    }

    @Override
    public boolean updateAppointment(Appointment appointment) {
        String query = "update appointment set patient_id=?, doctor_id=?, appointment_date=?, description=? where appointment_id=?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, appointment.getPatientId());
            stmt.setInt(2, appointment.getDoctorId());
            stmt.setString(3, appointment.getAppointmentDate());
            stmt.setString(4, appointment.getDescription());
            stmt.setInt(5, appointment.getAppointmentId());
            int rows = stmt.executeUpdate();
            
            
            return rows > 0;
        } catch (SQLException e) {
        	System.err.println(e.getMessage());
        }
        return false;
    }

    @Override
    public boolean cancelAppointment(int appointmentId) {
        String query = "delete from appointment where appointment_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(query)) {
            stmt.setInt(1, appointmentId);
            int rows = stmt.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
        	System.err.println(e.getMessage());
        }
        return false;
    }
}
