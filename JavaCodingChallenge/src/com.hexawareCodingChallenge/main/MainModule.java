package com.hexareCodingChallenge.main;
import java.util.InputMismatchException;
import java.util.List;
import java.util.Scanner;

import com.hexareCodingChallenge.dao.HospitalService;
import com.hexareCodingChallenge.dao.HospitalServiceImpl;
import com.hexareCodingChallenge.entity.Appointment;
import com.hexareCodingChallenge.entity.Patient;
import com.hexareCodingChallenge.exception.PatientNumberNotFoundException;

public class MainModule {

    public static void main(String[] args) {
        Scanner sc = new Scanner(System.in);
        HospitalService hospitalService = new HospitalServiceImpl();
        int choice = -1;

        do {
            try {
                System.out.println("\n=== Hospital Management System ===");
                System.out.println("1. Schedule Appointment");
                System.out.println("2. View Appointment by ID");
                System.out.println("3. View Appointments for Patient");
                System.out.println("4. View Appointments for Doctor");
                System.out.println("5. Update Appointment");
                System.out.println("6. Cancel Appointment");
                System.out.println("7. Exit");
                System.out.print("Enter choice: ");

                choice = Integer.parseInt(sc.nextLine());

                switch (choice) {
                    case 1: {
                    	
                        System.out.print("Enter Patient ID: ");
                        int patientId = Integer.parseInt(sc.nextLine());

                        System.out.print("Enter Doctor ID: ");
                        int doctorId = Integer.parseInt(sc.nextLine());

                        System.out.print("Enter Appointment Date (YYYY-MM-DD): ");
                        String date = sc.nextLine();

                        System.out.print("Enter Description: ");
                        String desc = sc.nextLine();

                        Appointment a = new Appointment(0, patientId, doctorId, date, desc);
                        boolean status = hospitalService.scheduleAppointment(a);
                        System.out.println(status ? "Appointment scheduled successfully with appintment ID : "+a.getAppointmentId() : "Failed to schedule.");
                        break;
                    }

                    case 2: {
                        System.out.print("Enter Appointment ID: ");
                        int id = Integer.parseInt(sc.nextLine());
                        Appointment a = hospitalService.getAppointmentById(id);
                        System.out.println("__________Appintment Detail__________");
                        System.out.println((a != null) ? a.toString() :"No appointment found.");
                        break;
                    }

                    case 3: {
                        System.out.print("Enter Patient ID: ");
                        int pid = Integer.parseInt(sc.nextLine());

                        List<Appointment> list = hospitalService.getAppointmentsForPatient(pid);
                        if (list.isEmpty()) {
                            throw new PatientNumberNotFoundException("No appointments found for Patient ID: " + pid);
                        }
                        System.out.println("__________Appintment Details__________");
                        list.forEach(System.out::println);
                        break;
                    }

                    case 4: {
                        System.out.print("Enter Doctor ID: ");
                        int did = Integer.parseInt(sc.nextLine());

                        List<Appointment> list = hospitalService.getAppointmentsForDoctor(did);
                        if (list.isEmpty()) {
                            System.out.println("No appointments found for Doctor ID: " + did);
                        } else {
                        	System.out.println("__________Appintment Details__________");
                            list.forEach(System.out::println);
                        }
                        break;
                    }

                    case 5: {
                        System.out.print("Enter Appointment ID to Update: ");
                        int appId = Integer.parseInt(sc.nextLine());

                        System.out.print("Enter new Patient ID: ");
                        int patientId = Integer.parseInt(sc.nextLine());

                        System.out.print("Enter new Doctor ID: ");
                        int doctorId = Integer.parseInt(sc.nextLine());

                        System.out.print("Enter new Date (YYYY-MM-DD): ");
                        String date = sc.nextLine();

                        System.out.print("Enter new Description: ");
                        String desc = sc.nextLine();

                        Appointment a = new Appointment(appId, patientId, doctorId, date, desc);
                        boolean updated = hospitalService.updateAppointment(a);
                        System.out.println(updated ? "Updated successfully." : "Update failed.");
                        break;
                    }

                    case 6: {
                        System.out.print("Enter Appointment ID to Cancel: ");
                        int id = Integer.parseInt(sc.nextLine());
                        boolean deleted = hospitalService.cancelAppointment(id);
                        System.out.println(deleted ? "Cancelled successfully." : "Cancellation failed.");
                        break;
                    }

                    case 7:
                        System.out.println("\n=== Hospital Management System === \nThank You \nExiting...");
                        return;

                    default:
                        System.out.println("Invalid choice. Please enter a number between 0 and 6.");
                }

            } catch (PatientNumberNotFoundException e) {
                System.err.println(e.getMessage());
            } catch (InputMismatchException | NumberFormatException e) {
                System.err.println("Invalid input. Please enter valid numeric values.");
            } catch (IllegalArgumentException e) {
                System.err.println(e.getMessage());
            } catch (Exception e) {
                System.err.println(e.getMessage());
                
            }

        } while (choice != 0);

        sc.close();
    }
}
