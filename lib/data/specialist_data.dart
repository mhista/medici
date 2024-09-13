// import 'package:medici/features/specialists/models/specialist_model.dart';

// import '../features/specialists/models/working_hour.dart';
// import '../utils/constants/image_strings.dart';

// class SpecialistDummyData {
//   static final List<Doctor> dummyDoctors = [
//     Doctor(
//       id: "1",
//       name: "Dr. Sarah Johnson",
//       description:
//           "Dr. Sarah Johnson is a highly skilled Cardiologist with over 15 years of experience in diagnosing and treating cardiovascular diseases. She is known for her compassionate care and personalized treatment plans. Dr. Johnson has worked in leading hospitals across the world and is an active speaker at international cardiology conferences.",
//       noOfPatients: "1,200",
//       specialty: "Cardiologist",
//       phoneNumber: "+1-555-1234",
//       email: "sarah.johnson@example.com",
//       address: "123 Heart Clinic Ave, New York, USA",
//       yearOfExp: "15",
//       rating: 4.8,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 9, 0),
//             endTime: DateTime(2024, 8, 26, 17, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 9, 0),
//             endTime: DateTime(2024, 8, 27, 17, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 9, 0),
//             endTime: DateTime(2024, 8, 28, 17, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 9, 0),
//             endTime: DateTime(2024, 8, 29, 17, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 9, 0),
//             endTime: DateTime(2024, 8, 30, 17, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp3,
//       location: "New York, USA",
//     ),
//     Doctor(
//       id: "2",
//       name: "Dr. Michael Brown",
//       description:
//           "Dr. Michael Brown is a renowned Neurosurgeon with a deep expertise in complex brain surgeries and minimally invasive techniques. He has successfully performed over 2,000 surgeries, with a focus on brain tumor removal and spinal cord injuries. Dr. Brown is known for his meticulous approach and dedication to patient recovery.",
//       noOfPatients: "2,300",
//       specialty: "Neurosurgeon",
//       phoneNumber: "+1-555-5678",
//       email: "michael.brown@example.com",
//       address: "456 NeuroCare Blvd, Los Angeles, USA",
//       yearOfExp: "18",
//       rating: 4.9,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 8, 30),
//             endTime: DateTime(2024, 8, 26, 16, 30)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 8, 30),
//             endTime: DateTime(2024, 8, 27, 16, 30)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 8, 30),
//             endTime: DateTime(2024, 8, 28, 16, 30)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 8, 30),
//             endTime: DateTime(2024, 8, 29, 16, 30)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 8, 30),
//             endTime: DateTime(2024, 8, 30, 16, 30)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp7,
//       location: "Los Angeles, USA",
//     ),
//     Doctor(
//       id: "3",
//       name: "Dr. Emily Davis",
//       description:
//           "Dr. Emily Davis is a dedicated Pediatrician with over 10 years of experience in providing comprehensive care for children of all ages. She specializes in pediatric infectious diseases and vaccinations, and is actively involved in community health programs focused on improving child health outcomes.",
//       noOfPatients: "900",
//       specialty: "Pediatrician",
//       phoneNumber: "+1-555-7890",
//       email: "emily.davis@example.com",
//       address: "789 Child Health Rd, Sydney, Australia",
//       yearOfExp: "10",
//       rating: 4.7,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 9, 30),
//             endTime: DateTime(2024, 8, 26, 17, 30)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 9, 30),
//             endTime: DateTime(2024, 8, 27, 17, 30)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 9, 30),
//             endTime: DateTime(2024, 8, 28, 17, 30)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 9, 30),
//             endTime: DateTime(2024, 8, 29, 17, 30)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 9, 30),
//             endTime: DateTime(2024, 8, 30, 17, 30)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp8,
//       location: "Sydney, Australia",
//     ),
//     Doctor(
//       id: "4",
//       name: "Dr. James Wilson",
//       description:
//           "Dr. James Wilson is a respected Oncologist with a specialization in lung cancer treatment. With over 12 years of experience, Dr. Wilson has been at the forefront of innovative cancer treatments, including targeted therapy and immunotherapy. He is also involved in cancer research, aiming to improve survival rates and quality of life for his patients.",
//       noOfPatients: "1,500",
//       specialty: "Oncologist",
//       phoneNumber: "+44-20-1234-5678",
//       email: "james.wilson@example.com",
//       address: "123 Oncology Lane, London, UK",
//       yearOfExp: "12",
//       rating: 4.8,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 8, 0),
//             endTime: DateTime(2024, 8, 26, 16, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 8, 0),
//             endTime: DateTime(2024, 8, 27, 16, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 8, 0),
//             endTime: DateTime(2024, 8, 28, 16, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 8, 0),
//             endTime: DateTime(2024, 8, 29, 16, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 8, 0),
//             endTime: DateTime(2024, 8, 30, 16, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp1,
//       location: "London, UK",
//     ),
//     Doctor(
//       id: "5",
//       name: "Dr. Aisha Bello",
//       description:
//           "Dr. Aisha Bello is a renowned Dermatologist from Nigeria with over 8 years of experience in treating skin disorders, including acne, eczema, and psoriasis. She is known for her patient-centered approach and is actively involved in public health campaigns to raise awareness about skin health in Africa.",
//       noOfPatients: "800",
//       specialty: "Dermatologist",
//       phoneNumber: "+234-809-1234-567",
//       email: "aisha.bello@example.com",
//       address: "45 Skin Health Street, Lagos, Nigeria",
//       yearOfExp: "8",
//       rating: 4.6,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 9, 0),
//             endTime: DateTime(2024, 8, 26, 17, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 9, 0),
//             endTime: DateTime(2024, 8, 27, 17, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 9, 0),
//             endTime: DateTime(2024, 8, 28, 17, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 9, 0),
//             endTime: DateTime(2024, 8, 29, 17, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 9, 0),
//             endTime: DateTime(2024, 8, 30, 17, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp5,
//       location: "Lagos, Nigeria",
//     ),
//     Doctor(
//       id: "6",
//       name: "Dr. Li Wei",
//       description:
//           "Dr. Li Wei is a skilled Orthopedic Surgeon from China with a focus on joint replacements and sports injuries. He has helped many athletes recover from severe injuries and is well-respected in the field for his precision and innovative techniques. Dr. Wei is also a lecturer at a top medical university in Beijing.",
//       noOfPatients: "1,400",
//       specialty: "Orthopedic Surgeon",
//       phoneNumber: "+86-10-1234-5678",
//       email: "li.wei@example.com",
//       address: "78 Orthopedic Plaza, Beijing, China",
//       yearOfExp: "14",
//       rating: 4.8,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 8, 0),
//             endTime: DateTime(2024, 8, 26, 16, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 8, 0),
//             endTime: DateTime(2024, 8, 27, 16, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 8, 0),
//             endTime: DateTime(2024, 8, 28, 16, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 8, 0),
//             endTime: DateTime(2024, 8, 29, 16, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 8, 0),
//             endTime: DateTime(2024, 8, 30, 16, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp15,
//       location: "Beijing, China",
//     ),
//     Doctor(
//       id: "7",
//       name: "Dr. Ana Silva",
//       description:
//           "Dr. Ana Silva is a leading Gynecologist from Brazil, specializing in maternal and fetal medicine. She has over 11 years of experience and has been instrumental in reducing maternal mortality rates in her region. Dr. Silva is also a strong advocate for women's health and reproductive rights in South America.",
//       noOfPatients: "950",
//       specialty: "Gynecologist",
//       phoneNumber: "+55-21-5678-1234",
//       email: "ana.silva@example.com",
//       address: "12 Women's Health Rd, Rio de Janeiro, Brazil",
//       yearOfExp: "11",
//       rating: 4.7,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 9, 30),
//             endTime: DateTime(2024, 8, 26, 17, 30)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 9, 30),
//             endTime: DateTime(2024, 8, 27, 17, 30)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 9, 30),
//             endTime: DateTime(2024, 8, 28, 17, 30)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 9, 30),
//             endTime: DateTime(2024, 8, 29, 17, 30)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 9, 30),
//             endTime: DateTime(2024, 8, 30, 17, 30)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp4,
//       location: "Rio de Janeiro, Brazil",
//     ),
//     Doctor(
//       id: "8",
//       name: "Dr. Ahmed Khan",
//       description:
//           "Dr. Ahmed Khan is a highly respected Cardiothoracic Surgeon from Egypt. With over 20 years of experience, Dr. Khan has performed numerous heart and lung surgeries. He is renowned for his expertise in complex cardiovascular surgeries and is often called upon for his knowledge in critical cases.",
//       noOfPatients: "2,100",
//       specialty: "Cardiothoracic Surgeon",
//       phoneNumber: "+20-2-3456-7890",
//       email: "ahmed.khan@example.com",
//       address: "90 Heart Surgery Ave, Cairo, Egypt",
//       yearOfExp: "20",
//       rating: 4.9,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 8, 0),
//             endTime: DateTime(2024, 8, 26, 16, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 8, 0),
//             endTime: DateTime(2024, 8, 27, 16, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 8, 0),
//             endTime: DateTime(2024, 8, 28, 16, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 8, 0),
//             endTime: DateTime(2024, 8, 29, 16, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 8, 0),
//             endTime: DateTime(2024, 8, 30, 16, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp8,
//       location: "Cairo, Egypt",
//     ),
//     Doctor(
//       id: "9",
//       name: "Dr. Emily Scott",
//       description:
//           "Dr. Emily Scott is an esteemed Neurologist from Canada with 13 years of experience in treating neurological disorders such as epilepsy, Parkinson’s disease, and multiple sclerosis. She is known for her research contributions and is involved in clinical trials for new therapies.",
//       noOfPatients: "1,100",
//       specialty: "Neurologist",
//       phoneNumber: "+1-416-789-1234",
//       email: "emily.scott@example.com",
//       address: "67 Brain Health Ave, Toronto, Canada",
//       yearOfExp: "13",
//       rating: 4.8,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 9, 0),
//             endTime: DateTime(2024, 8, 26, 17, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 9, 0),
//             endTime: DateTime(2024, 8, 27, 17, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 9, 0),
//             endTime: DateTime(2024, 8, 28, 17, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 9, 0),
//             endTime: DateTime(2024, 8, 29, 17, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 9, 0),
//             endTime: DateTime(2024, 8, 30, 17, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp9,
//       location: "Toronto, Canada",
//     ),
//     Doctor(
//       id: "10",
//       name: "Dr. Mia Kim",
//       description:
//           "Dr. Mia Kim is a skilled Ophthalmologist from South Korea with 9 years of experience in treating eye conditions and performing surgeries like cataract removal and LASIK. She is dedicated to restoring vision and improving the quality of life for her patients.",
//       noOfPatients: "750",
//       specialty: "Ophthalmologist",
//       phoneNumber: "+82-2-4567-8901",
//       email: "mia.kim@example.com",
//       address: "22 Vision Care St, Seoul, South Korea",
//       yearOfExp: "9",
//       rating: 4.7,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 10, 0),
//             endTime: DateTime(2024, 8, 26, 18, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 10, 0),
//             endTime: DateTime(2024, 8, 27, 18, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 10, 0),
//             endTime: DateTime(2024, 8, 28, 18, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 10, 0),
//             endTime: DateTime(2024, 8, 29, 18, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 10, 0),
//             endTime: DateTime(2024, 8, 30, 18, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp13,
//       location: "Seoul, South Korea",
//     ),
//     Doctor(
//       id: "11",
//       name: "Dr. Olivia Martinez",
//       description:
//           "Dr. Olivia Martinez is a prominent Rheumatologist from Spain specializing in autoimmune diseases and arthritis. With over 16 years in practice, she is known for her thorough diagnostic approach and effective management of chronic pain and inflammation conditions.",
//       noOfPatients: "1,000",
//       specialty: "Rheumatologist",
//       phoneNumber: "+34-91-234-5678",
//       email: "olivia.martinez@example.com",
//       address: "34 Arthritis Clinic Blvd, Madrid, Spain",
//       yearOfExp: "16",
//       rating: 4.8,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 9, 0),
//             endTime: DateTime(2024, 8, 26, 17, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 9, 0),
//             endTime: DateTime(2024, 8, 27, 17, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 9, 0),
//             endTime: DateTime(2024, 8, 28, 17, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 9, 0),
//             endTime: DateTime(2024, 8, 29, 17, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 9, 0),
//             endTime: DateTime(2024, 8, 30, 17, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp14,
//       location: "Madrid, Spain",
//     ),
//     Doctor(
//       id: "12",
//       name: "Dr. Isaac Thomas",
//       description:
//           "Dr. Isaac Thomas is an expert in Endocrinology from South Africa, focusing on diabetes management and hormonal disorders. With 14 years of experience, he is well-regarded for his research on metabolic syndrome and his patient-friendly approach to managing chronic endocrine diseases.",
//       noOfPatients: "1,300",
//       specialty: "Endocrinologist",
//       phoneNumber: "+27-11-123-4567",
//       email: "isaac.thomas@example.com",
//       address: "55 Hormone Health St, Johannesburg, South Africa",
//       yearOfExp: "14",
//       rating: 4.7,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 8, 30),
//             endTime: DateTime(2024, 8, 26, 16, 30)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 8, 30),
//             endTime: DateTime(2024, 8, 27, 16, 30)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 8, 30),
//             endTime: DateTime(2024, 8, 28, 16, 30)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 8, 30),
//             endTime: DateTime(2024, 8, 29, 16, 30)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 8, 30),
//             endTime: DateTime(2024, 8, 30, 16, 30)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp11,
//       location: "Johannesburg, South Africa",
//     ),
//     Doctor(
//       id: "13",
//       name: "Dr. Sofia Hernandez",
//       description:
//           "Dr. Sofia Hernandez is an experienced Infectious Disease Specialist from Mexico with a focus on emerging infectious diseases and travel medicine. She has been a key figure in managing outbreaks and providing expert advice on infection control and prevention strategies.",
//       noOfPatients: "1,000",
//       specialty: "Infectious Disease Specialist",
//       phoneNumber: "+52-55-123-4567",
//       email: "sofia.hernandez@example.com",
//       address: "78 Infectious Care Blvd, Mexico City, Mexico",
//       yearOfExp: "12",
//       rating: 4.6,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 9, 0),
//             endTime: DateTime(2024, 8, 26, 17, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 9, 0),
//             endTime: DateTime(2024, 8, 27, 17, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 9, 0),
//             endTime: DateTime(2024, 8, 28, 17, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 9, 0),
//             endTime: DateTime(2024, 8, 29, 17, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 9, 0),
//             endTime: DateTime(2024, 8, 30, 17, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp12,
//       location: "Mexico City, Mexico",
//     ),
//     Doctor(
//       id: "14",
//       name: "Dr. Julia Rossi",
//       description:
//           "Dr. Julia Rossi is an esteemed Geriatrician from Italy, specializing in aging and elderly care. With 17 years of experience, she is known for her holistic approach to treating age-related conditions and her contributions to research on improving the quality of life for older adults.",
//       noOfPatients: "950",
//       specialty: "Geriatrician",
//       phoneNumber: "+39-06-1234-5678",
//       email: "julia.rossi@example.com",
//       address: "23 Elderly Care Ave, Rome, Italy",
//       yearOfExp: "17",
//       rating: 4.8,
//       workingHours: [
//         WorkingHourModel(
//             day: "Monday",
//             startTime: DateTime(2024, 8, 26, 9, 0),
//             endTime: DateTime(2024, 8, 26, 17, 0)),
//         WorkingHourModel(
//             day: "Tuesday",
//             startTime: DateTime(2024, 8, 27, 9, 0),
//             endTime: DateTime(2024, 8, 27, 17, 0)),
//         WorkingHourModel(
//             day: "Wednesday",
//             startTime: DateTime(2024, 8, 28, 9, 0),
//             endTime: DateTime(2024, 8, 28, 17, 0)),
//         WorkingHourModel(
//             day: "Thursday",
//             startTime: DateTime(2024, 8, 29, 9, 0),
//             endTime: DateTime(2024, 8, 29, 17, 0)),
//         WorkingHourModel(
//             day: "Friday",
//             startTime: DateTime(2024, 8, 30, 9, 0),
//             endTime: DateTime(2024, 8, 30, 17, 0)),
//       ],
//       isVerified: true,
//       profileImage: PImages.dp14,
//       location: "Rome, Italy",
//     ),
//   ];
// }
