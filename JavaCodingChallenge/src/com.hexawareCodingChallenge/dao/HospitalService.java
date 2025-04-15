package com.hexareCodingChallenge.dao;

import java.util.List;

import com.hexareCodingChallenge.entity.Appointment;
import com.hexareCodingChallenge.entity.Doctor;
import com.hexareCodingChallenge.entity.Patient;

public interface HospitalService {
    Appointment getAppointmentById(int appointmentId);
    List<Appointment> getAppointmentsForPatient(int patientId);
    List<Appointment> getAppointmentsForDoctor(int doctorId);
    boolean scheduleAppointment(Appointment appointment);
    boolean updateAppointment(Appointment appointment);
    boolean cancelAppointment(int appointmentId);
}
