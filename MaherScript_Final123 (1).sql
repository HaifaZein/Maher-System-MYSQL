DROP TABLE ac_department CASCADE CONSTRAINTS;
DROP TABLE admin_employee CASCADE CONSTRAINTS; 
DROP TABLE admin_offices CASCADE CONSTRAINTS; 
DROP TABLE college CASCADE CONSTRAINTS;
DROP TABLE evaluation_survey CASCADE CONSTRAINTS;
DROP TABLE external_org CASCADE CONSTRAINTS;
DROP TABLE faculty_member CASCADE CONSTRAINTS; 
DROP TABLE fills CASCADE CONSTRAINTS; 
DROP TABLE location CASCADE CONSTRAINTS; 
DROP TABLE participate_in CASCADE CONSTRAINTS; 
DROP TABLE presents CASCADE CONSTRAINTS; 
DROP TABLE pd_activity CASCADE CONSTRAINTS; 
DROP TABLE pdactivity_lo CASCADE CONSTRAINTS; 
DROP TABLE question CASCADE CONSTRAINTS; 
DROP TABLE resources CASCADE CONSTRAINTS; 
DROP TABLE role CASCADE CONSTRAINTS; 
DROP TABLE puser CASCADE CONSTRAINTS; 


CREATE TABLE puser(
    ssn CHAR (9) PRIMARY KEY ,
    psu_id VARCHAR(9) NOT NULL UNIQUE, 
    fname VARCHAR (20) NOT NULL,
    lname VARCHAR (20) NOT NULL,
    pwd VARCHAR(45) NOT NULL,
    psu_mail VARCHAR(70) NOT NULL,
    lusername VARCHAR (30), 
    Phone_number CHAR(10) NOT NULL

);


CREATE TABLE admin_offices(
    office_number CHAR (4) PRIMARY KEY,
    office_name VARCHAR (20) NOT NULL

);


CREATE TABLE admin_employee(
    ssn CHAR(9),
    job_position VARCHAR(35) NOT NULL,
    office_number CHAR (4) NOT NULL,
    CONSTRAINT con_ssn_pk PRIMARY KEY (ssn),
    CONSTRAINT ssn_fk FOREIGN KEY (ssn) REFERENCES puser (ssn) ON DELETE CASCADE,
    CONSTRAINT officeno_fk FOREIGN KEY (office_number) REFERENCES admin_offices (office_number) ON DELETE SET NULL
);


CREATE TABLE location(
    loc_id VARCHAR(10) PRIMARY KEY,
    loc_type VARCHAR(20),
    buildingno CHAR (5),
    roomno CHAR (5),
    floorno CHAR(5)
);

CREATE TABLE pd_activity(
    activity_id CHAR (10) PRIMARY KEY,
    activity_title VARCHAR (50),
    type VARCHAR (50),
    start_date DATE,
    end_date DATE,
    loc_id VARCHAR(10) NOT NULL,
    CONSTRAINT locid__fk FOREIGN KEY (loc_id) REFERENCES location (loc_id) ON DELETE SET NULL
);

CREATE TABLE faculty_member(
    ssn CHAR (9),
    Rank VARCHAR(30) NOT NULL,
    CONSTRAINT con_fmssn_pk PRIMARY KEY (ssn),
    CONSTRAINT fmssn_fk FOREIGN KEY (ssn) REFERENCES puser (ssn) ON DELETE SET NULL
);


CREATE TABLE college(
    college_name VARCHAR(50) PRIMARY KEY,
    campus VARCHAR(6)
);

CREATE TABLE ac_department(
    dep_number CHAR(10) PRIMARY KEY,
    dep_name VARCHAR (100) NOT NULL,
    manager_ssn CHAR (9) NOT NULL,
    college_name VARCHAR(50) NOT NULL,
    CONSTRAINT mgrssn_fk FOREIGN KEY (manager_ssn) REFERENCES faculty_member (ssn) ON DELETE SET NULL,
    CONSTRAINT collegename_fk FOREIGN KEY (college_name) REFERENCES college (college_name) ON DELETE SET NULL
);


ALTER TABLE faculty_member ADD dep_number CHAR(10);
ALTER TABLE faculty_member ADD FOREIGN KEY (dep_number) REFERENCES ac_department (dep_number) ON DELETE SET NULL;


CREATE TABLE external_org(
    Org_Name VARCHAR(50) PRIMARY KEY,
	Address VARCHAR(100),
	Email VARCHAR (100),
	Phone CHAR(10)
);

CREATE TABLE pdactivity_lo(
    Activity_id CHAR(10),
	learning_outcome VARCHAR(200),
    CONSTRAINT activityid_clo_pk PRIMARY KEY (Activity_id,learning_outcome),
    CONSTRAINT activityid_fk  FOREIGN KEY (Activity_id) REFERENCES pd_activity (Activity_id) ON DELETE CASCADE
);

CREATE TABLE presents(
    Activity_id CHAR(10),
	Org_Name VARCHAR(50),
	Presenter VARCHAR(50),
	Gender VARCHAR(1),
    CONSTRAINT Activityid_OrgName_pk PRIMARY KEY (Activity_id , Org_Name),
    CONSTRAINT activity_id_fk  FOREIGN KEY (Activity_id) REFERENCES pd_activity (Activity_id) ON DELETE CASCADE,
    CONSTRAINT OrgName_fk FOREIGN KEY (Org_Name) REFERENCES external_org (Org_Name) ON DELETE CASCADE
);

CREATE TABLE evaluation_survey(
    Survey_No VARCHAR(50) PRIMARY KEY,
	Survey_Date Date,
	Score NUMBER(2) NOT NULL
);


CREATE TABLE question(
    Qno VARCHAR(200) ,
	Survey_No VARCHAR(50),
	Q_Statement VARCHAR(200),
    CONSTRAINT question_pk PRIMARY KEY (Qno, Survey_no),
    CONSTRAINT SurveyNo_fk  FOREIGN KEY (Survey_No) REFERENCES evaluation_survey (Survey_No) ON DELETE CASCADE
);


CREATE TABLE fills(
    ssn CHAR(9),
	Activity_id CHAR(10),
	Questions VARCHAR(200),
    Survey_No VARCHAR(50),
	Answers NUMBER(3,0) NOT NULL,
    CONSTRAINT fills_pk PRIMARY KEY (ssn, activity_id, Questions, Survey_No),
    CONSTRAINT Activityidfk  FOREIGN KEY (Activity_id) REFERENCES pd_activity (Activity_id) ON DELETE CASCADE,
    CONSTRAINT ssnfk FOREIGN KEY (ssn) REFERENCES puser (ssn) ON DELETE CASCADE,
    CONSTRAINT QnoSurveyNo_fk FOREIGN KEY (Questions, Survey_No) REFERENCES question (Qno, Survey_No) ON DELETE CASCADE
);


CREATE TABLE role(
    Role_name VARCHAR(50) PRIMARY KEY,
	Points NUMBER(3,0)
);

CREATE TABLE resources(
    Activity_id CHAR(10) NOT NULL,
	 Handouts VARCHAR(200),
 	 Links VARCHAR(200),
    CONSTRAINT AidHand_pk PRIMARY KEY (Activity_id, Handouts),
    CONSTRAINT Activityidfk_ FOREIGN KEY (Activity_id) REFERENCES pd_activity (Activity_id) ON DELETE CASCADE
);

CREATE TABLE participate_in(
    ssn CHAR(9),
	Role_name VARCHAR(50),
	Activity_id CHAR(10),
	Ticket_no NUMBER(20,0) NOT NULL,
	Certificate VARCHAR(50),
	Points_earned NUMBER(3,0) NOT NULL,
    CONSTRAINT Aid_Role_ssn_pk PRIMARY KEY (Activity_id, Role_name, ssn),
    CONSTRAINT Aidfk_  FOREIGN KEY (Activity_id) REFERENCES pd_activity (Activity_id) ON DELETE CASCADE,
    CONSTRAINT ssnfk_ FOREIGN KEY (ssn) REFERENCES puser (ssn) ON DELETE CASCADE,
    CONSTRAINT Role_name_fk FOREIGN KEY (Role_name) REFERENCES Role (Role_name) ON DELETE CASCADE
);
----puser
INSERT INTO puser VALUES ('231298223', '220410581', 'Haifa', 'Zein', '748294', '220410581@psu.edu.sa' , 'HaifaZeinCS', '0505982950');
INSERT INTO puser VALUES ('131698923', '220450531', 'Jana', 'Alshehri', '048492', '220450531@psu.edu.sa' , 'JanaAlshehriSE', '0598982780');
INSERT INTO puser VALUES ('271223226', '221410541', 'Sara', 'Zamil', '848204', '221410541@psu.edu.sa' , 'SaraZamilIS', '050230950');
INSERT INTO puser VALUES ('228798223', '221410381', 'Ahmad', 'Zein', '743123', '221410381@psu.edu.sa' , 'AhmadZeinCS', '0505456250');
INSERT INTO puser VALUES ('221295423', '218540511', 'Mohammad', 'Salih', '941299', '218540511@psu.edu.sa' , 'MohammadSalihCE', '0555981230');
INSERT INTO puser VALUES ('211498333', '222510531', 'Lenaa', 'Saqr', '749321', '222510531@psu.edu.sa' , 'LenaaSaqrCS', '0550942650');
INSERT INTO puser VALUES ('215198237', '222510345', 'Norah', 'Sami', '944527', '222510345@psu.edu.sa' , 'NorahSamiEng', '0599542345');
INSERT INTO puser VALUES ('214496783', '216510451', 'Tareq', 'Qahtani', '751221', '216510451@psu.edu.sa' , 'TareqQahtaniEng', '0531094650');
INSERT INTO puser VALUES ('131498753', '222410521', 'Jamal', 'Rashid', '814631', '222410521@psu.edu.sa' , 'JamalRashidLaw', '0567941250');
INSERT INTO puser VALUES ('213423813', '220510100', 'Yousuf', 'Ahmad', '449221', '220510100@psu.edu.sa' , 'YousufAhmadDr', '0501242446');
INSERT INTO puser VALUES ('354728497',  '221545632',  'John', 'Mayer', 'Bajsuzys89!', '119836452@psu.edu.sa' ,NULL, '0567774653');
INSERT INTO puser VALUES ('354278497',  '221544442',  'Lujain', 'Alqahtani', 'hElloKitty7@!', '221544442@psu.edu.sa', NULL, '0555718438');
INSERT INTO puser VALUES ('239657453',  '745382916',  'Ibrahim', 'Alotaibi', 'Qwert12345!', '745382916@psu.edu.sa', 'IbraOtaibi76', '0555718438');
INSERT INTO puser VALUES ('132465739',  '227643399',  'Osamah', 'Alshammari', 'yErtajs!fee', '227643399@psu.edu.sa', 'OsamahShammariIS', '0546358963');
INSERT INTO puser VALUES ('338967554',  '110767453',  'Yasmine', 'Alfouzan', '7654321J$', '110767453@psu.edu.sa', 'Yasmine_Fouz', '0550936007');
INSERT INTO puser VALUES ('222064339',  '210946578',  'Sita', 'Mansour', 'beetlejui$E66', '210946578@psu.edu.sa', 'SitaMan02', '0567253904');
INSERT INTO puser VALUES ('192637283',  '192857603',  'Mohammed', 'Altuwaijri', 'bYynBs7vdFEoMPW', '192857603@psu.edu.sa', 'Moe2aijri', '0567394760');
INSERT INTO puser VALUES ('224356700',  '245621907',  'Jomana', 'Alasbali', 'HV3r5cjYljxiJnP', '245621907@psu.edu.sa', 'JomanaAsbaliDr', '0504483692');
INSERT INTO puser VALUES ('221511417',  '112075756',  'Hussain', 'Almutairi', 'iLoveRonaldo7', '1120757456@psu.edu.sa', NULL, '0508342692');
INSERT INTO puser VALUES ('192046530',  '213860680',  'Dana', 'Almajed', 'jeuisuhn1997', '213860680@psu.edu.sa', NULL, '0554382971');
---faculty_member
INSERT INTO faculty_member VALUES ('131698923', 'Professor', Null);
INSERT INTO faculty_member VALUES ('211498333', 'Instructor', NULL);
INSERT INTO faculty_member VALUES ('214496783', 'Instructor', NULL);
INSERT INTO faculty_member VALUES ('231298223', 'Professor', NULL);
INSERT INTO faculty_member VALUES ('221295423', 'Assistant Professor', NULL);
INSERT INTO faculty_member VALUES ('228798223', 'Assistant Professor', NULL);
INSERT INTO faculty_member VALUES ('239657453', 'Associate Professor', NULL);
INSERT INTO faculty_member VALUES ('271223226', 'Professor', NULL);
INSERT INTO faculty_member VALUES ('354728497', 'Professor', NULL);
INSERT INTO faculty_member VALUES ('132465739', 'Instructor', NULL);
INSERT INTO faculty_member VALUES ('224356700', 'Professor', NULL);
INSERT INTO faculty_member VALUES ('131498753', 'Associate Professor', NULL);
INSERT INTO faculty_member VALUES ('215198237', 'Associate Professor', NULL);
----college
INSERT INTO college VALUES('CCIS', 'M/F');
INSERT INTO college VALUES('CAD', 'f');
INSERT INTO college VALUES('CE', 'M');
INSERT INTO college VALUES('CBA', 'M/F');

--ac_department
INSERT INTO ac_Department VALUES ('1', 'Software Engineering', '131698923', 'CCIS');
INSERT INTO ac_Department VALUES ('2', 'Computer Science', '231298223', 'CCIS');
INSERT INTO ac_Department VALUES ('3', 'Information Systems', '132465739', 'CCIS');
INSERT INTO ac_Department VALUES ('4', 'Mechanical Engineering', '221295423', 'CE');
INSERT INTO ac_Department VALUES ('5', 'Industrial Engineering', '215198237', 'CE');
INSERT INTO ac_Department VALUES ('6', 'Finance', '239657453', 'CBA');
INSERT INTO ac_Department VALUES ('7', 'Accounting', '224356700', 'CBA');
INSERT INTO ac_Department VALUES ('8', 'Architecture', '131498753', 'CAD');
INSERT INTO ac_Department VALUES ('9', 'Interior Design', '354728497', 'CAD');
INSERT INTO ac_Department VALUES ('10', 'MBA', '228798223', 'CBA');
--faculty_member after creating ac_department
UPDATE faculty_member
SET Dep_number= '1'
WHERE SSN= '131698923' ;

UPDATE faculty_member
SET Dep_number= '2'
WHERE SSN= '211498333';

UPDATE faculty_member
SET Dep_number= '4'
WHERE SSN= '214496783';

UPDATE faculty_member
SET Dep_number= '2'
WHERE SSN= '231298223';

UPDATE faculty_member
SET Dep_number= '4'
WHERE SSN= '221295423';

UPDATE faculty_member
SET Dep_number= '5'
WHERE SSN= '228798223';

UPDATE faculty_member
SET Dep_number= '6'
WHERE SSN= '239657453';

UPDATE faculty_member
SET Dep_number= '5'
WHERE SSN= '271223226';

UPDATE faculty_member
SET Dep_number= '9'
WHERE SSN= '354728497';

UPDATE faculty_member
SET Dep_number= '3'
WHERE SSN= '132465739';

UPDATE faculty_member
SET Dep_number= '7'
WHERE SSN= '224356700';

UPDATE faculty_member
SET Dep_number= '8'
WHERE SSN= '131498753';


UPDATE faculty_member
SET Dep_number= '5'
WHERE SSN= '215198237';
--admin_offices
INSERT INTO admin_offices VALUES ('101','Admissions Office' );
INSERT INTO admin_offices VALUES ('201','President Office' );
INSERT INTO admin_offices VALUES ('301','Provost Office' );
INSERT INTO admin_offices VALUES ('401','Admin Affairs Office' );
INSERT INTO admin_offices VALUES ('501','HR Office' );
INSERT INTO admin_offices VALUES ('601','Finance Office' );
INSERT INTO admin_offices VALUES ('701','Registration Office' );
INSERT INTO admin_offices VALUES ('801','IT Services Office' );
INSERT INTO admin_offices VALUES ('901','Legal Affairs Office' );
--admin_employee
INSERT INTO admin_employee VALUES ('192046530', 'President', '201' );
INSERT INTO admin_employee VALUES ('338967554', 'Registrar','701' );
INSERT INTO admin_employee VALUES ('222064339', 'Senior IT','801' );
INSERT INTO admin_employee VALUES ('354278497', 'Human Resources','501' );
INSERT INTO admin_employee VALUES ('221511417', 'Chief Financial Officer','601' );
INSERT INTO admin_employee VALUES ('192637283', 'Lawyer','901' );
--location
INSERT INTO location VALUES ('W352', 'Stage', '4', '55', '1');
INSERT INTO location VALUES ('W114', 'Lab', '4', '14', '1');
INSERT INTO location VALUES ('S203', 'Lecture', '3', '3', '2');
INSERT INTO location VALUES ('N401', 'Lab', '1', '1', '4');
INSERT INTO location VALUES ('S321', 'Studio', '3', '1', '4');
INSERT INTO location VALUES ('N211', 'Lecture', '1', '11', '2');
INSERT INTO location VALUES ('W175', 'Lab', '4', '7', '1');
INSERT INTO location VALUES ('S402', 'Lecture', '3', '22', '4');
INSERT INTO location VALUES ('N413', 'Lecture', '1', '32', '4');
INSERT INTO location VALUES ('W330', 'Computer Lab', '4', '27', '3');
--pd_activity
INSERT INTO pd_activity VALUES ('231', 'Leadership Development Workshop', 'Workshop', TO_DATE('NOV-14-2023'), TO_DATE('NOV-17-2023'), 'W352');
INSERT INTO pd_activity VALUES ('232', 'Project Management Seminar', 'Seminar', TO_DATE('JUL-7-2023'), TO_DATE('JUL-10-2023'), 'S203');
INSERT INTO pd_activity VALUES ('233', 'Digital Marketing Certification', 'Course', TO_DATE('DEC-13-2023'), TO_DATE('DEC-20-2023'), 'S321');
INSERT INTO pd_activity VALUES ('234', 'Sales Training', 'Bootcamp', TO_DATE('OCT-25-2023'), TO_DATE('OCT-30-2023'), 'N413');
INSERT INTO pd_activity VALUES ('235', 'Mastering the Art of Communication', 'Workshop', TO_DATE('JAN-09-2023'), TO_DATE('JAN-21-2023'), 'N211');
INSERT INTO pd_activity VALUES ('236', 'Service Beyond Expectations', 'Training', TO_DATE('MAY-05-2023'), TO_DATE('MAY-15-2023'), 'S321');
INSERT INTO pd_activity VALUES ('237', 'Embracing Diversity: Fostering Inclusive Workplace', 'Seminar', TO_DATE('APR-01-2023'), TO_DATE('APR-04-2023'), 'W175');
INSERT INTO pd_activity VALUES ('238', 'Agile Project Management', 'Training', NULL, NULL, 'W330');
INSERT INTO pd_activity VALUES ('239', 'InnovateNow: Unlocking Creativity for Business', 'Bootcamp', NULL, NULL, 'W352');
INSERT INTO pd_activity VALUES ('240', 'CyberShield', 'Program', TO_DATE('JAN-04-2024'), TO_DATE('FEB-02-2024'), 'S321');

--pdactivity_lo
INSERT INTO pdactivity_lo VALUES ('231', 'Self-Awareness and Emotional Intelligence,
Effective Communication,
Strategic Thinking and Visionary Leadership,
Decision-Making and Problem-Solving');
INSERT INTO pdactivity_lo VALUES ('232', 'Project Initiation,
Scope Definition and Management,
Work Breakdown Structure (WBS),
Quality Management');
INSERT INTO pdactivity_lo VALUES ('233', 'Digital Marketing Fundamentals,
Market Research and Analysis,
Content Marketing Strategy,
Social Media Marketing');
INSERT INTO pdactivity_lo VALUES ('234', 'Understanding Sales Fundamentals,
Customer Relationship Building,
Sales Prospecting and Lead Generation,
Consultative Selling,
Negotiation Skills');
INSERT INTO pdactivity_lo VALUES ('235', 'Clear and Concise Communication,
Active Listening Skills,
Nonverbal Communication Mastery,
Articulate Verbal Expression,
Empathy in Communication');
INSERT INTO pdactivity_lo VALUES ('236', 'Understanding Customer Needs,
Effective Communication Skills,
Product/Service Knowledge,
Professionalism and Courtesy');
INSERT INTO pdactivity_lo VALUES ('237', 'Understanding Diversity,
Awareness of Unconscious Bias,
Cultural Competence,
Inclusive Language');
INSERT INTO pdactivity_lo VALUES ('238', 'Understanding Agile Principles,
Scrum Framework Mastery,
Kanban Principles and Practices,
User Stories and Backlog Management,
Sprint Planning and Execution');
INSERT INTO pdactivity_lo VALUES ('239', 'Creativity Techniques,
Design Thinking Process,
Mindset Shift,
Cross-disciplinary Collaboration,
Problem Framing,
Idea Generation and Brainstorming, 
Prototyping and Iteration');
INSERT INTO pdactivity_lo VALUES ('240', 'Understanding of Cybersecurity Principles,
Threat Landscape Awareness,
Risk Management Proficiency,
Knowledge of Security Frameworks and Standards');
--external_org
INSERT INTO external_org VALUES ('LearningHub Solutions', '123 Main Street, Cityville', 'LearningHub@gmail.com', '0556728591');
INSERT INTO external_org VALUES ('SkillForge Institute', '456 Elm Avenue, Townsville', 'SkillForgeI@hotmail.com', '0575786142');
INSERT INTO external_org VALUES ('CareerMinds Training Center', '789 Oak Boulevard, Metro City', 'C_Minds@live.com', '0500632397');
INSERT INTO external_org VALUES ('TechSkills Academy', '234 Pine Lane, Technoville', 'Ac_TechSkillss@live.com', '0541875041');
INSERT INTO external_org VALUES ('GlobalLeadership Seminars', '567 Maple Street, Leadership City', 'GLeadershipS@gmail.com', '0592001571');
INSERT INTO external_org VALUES ('InnovateEd Workshops', '890 Cedar Road, Innovatown', 'EDWorkshops@outlook.com', '0500560570');
INSERT INTO external_org VALUES ('ProDevelopment Network', '1234 Spruce Parkway, ProfCity', 'PD_Network@outlook.com', '0590862833');
INSERT INTO external_org VALUES ('ExecuLearn Conferences', NULL, 'ExecuLearnC@live.com', '0511397110');
INSERT INTO external_org VALUES ('IndustryInsight Training Institute', '901 Pinecrest Lane, Industry Town', 'IITInstitute@gmail.com', NULL);
INSERT INTO external_org VALUES ('ProfessionaLearn Hub', '345 Oak Street, Learnsville', 'PLHub@gmail.com', '0560043289');
--role
INSERT INTO role VALUES ('Trainor',300);
INSERT INTO role VALUES ('Coordinator',200);
INSERT INTO role VALUES ('IT Support',250);
INSERT INTO role VALUES ('Evaluator',150);
INSERT INTO role VALUES ('Program Manager',500);
INSERT INTO role VALUES ('Participant',150);
INSERT INTO role VALUES ('Mentor/Coach',400);
INSERT INTO role VALUES ('Administrator',700);

--resources
INSERT INTO resources VALUES ('233', 'Digital Marketing Basics Guide, Social Media Marketing Tipsheet, (SEO) Checklist, Content Marketing Calendar Template', 'www.dmccourse.net');
INSERT INTO resources VALUES ('234', 'Sales Process Overview, Effective Sales Techniques Cheat Sheet, Customer Persona Template, Object Handling Guide', 'www.training.sales.eduhub.net');
INSERT INTO resources VALUES ('232', 'Project Management Framework Overview, Project Charter Template, Gantt Chart Basics, Work Breakdown Structure (WBS) Example', 'www.paraseminar.com');
INSERT INTO resources VALUES ('240', 'Cybersecurity Basics Guide, Threat Landscape Infographic, Password Best Practices, Phishing Awareness Tipsheet', 'CyberShieldPro.com');
INSERT INTO resources VALUES ('231', 'Cybersecurity Basics Guide, Threat Landscape Infographic,
Password Best Practices, Phishing Awareness Tipsheet', 'CyberShieldPro.com');
INSERT INTO resources VALUES ('231', 'Leadership Styles Overview, Goal Setting and Planning Worksheet, Conflict Resolution Strategies, Decision-Making Framework', NULL ); 
INSERT INTO resources VALUES ('235', 'Effective Communication Principles, The Power of Body Language, Overcoming Communication Barriers, Visual Aids and Presentation Skills', 'CommMasterClass.com' );
INSERT INTO resources VALUES ('236', 'Customer Service Excellence Guide, Understanding Customer Needs Worksheet, Empathy in Customer Interactions, Handling Difficult Situations Guide' , NULL);
INSERT INTO resources VALUES ('237', 'Diversity and Inclusion Overview, Unconscious Bias Awareness, Inclusive Communication Guidelines, Microaggressions Awareness', 'Culture-of-Belonging.net' );
INSERT INTO resources VALUES ('238', 'Agile Methodology Overview, Scrum Framework Guide, Kanban Basics and Implementation, Sprint Planning and Execution', 'AgileMC.net' );
---evaluation_Survey
INSERT INTO evaluation_survey VALUES ('1', '11-16-2023', 10);
INSERT INTO evaluation_survey VALUES ('9', '11-16-2023', 10);
INSERT INTO evaluation_survey VALUES ('2', '11-14-2023', 7);
INSERT INTO evaluation_survey VALUES ('3', '11-12-2023', 4);
INSERT INTO evaluation_survey VALUES ('4', '11-01-2023', 5);
INSERT INTO evaluation_survey VALUES ('5', '11-17-2023', 12);
INSERT INTO evaluation_survey VALUES ('6', '11-6-2023', 7);
INSERT INTO evaluation_survey VALUES ('7', '11-8-2023', 9);
INSERT INTO evaluation_survey VALUES ('8', '11-26-2023', 10);
--question
INSERT INTO question VALUES ('1', '1', 'How much would you rate this activity out of 10?');
INSERT INTO question VALUES ('2', '1', 'How much would you rate this Mentor/Coach out of 10?');
INSERT INTO question VALUES ('1', '2', 'How much would you rate this activity out of 10?');
INSERT INTO question VALUES ('2', '2', 'How much would you rate this Mentor/Coach out of 10?');
INSERT INTO question VALUES ('1', '3', 'How much would you rate this activity out of 10?');
INSERT INTO question VALUES ('2', '3', 'How much would you rate this Mentor/Coach out of 10?');
INSERT INTO question VALUES ('1', '4', 'How much would you rate this activity out of 10?');
INSERT INTO question VALUES ('2', '4', 'How much would you rate this Mentor/Coach out of 10?');
INSERT INTO question VALUES ('1', '6', 'How much would you rate this activity out of 10?');
INSERT INTO question VALUES ('2', '6', 'How much would you rate this Mentor/Coach out of 10?');
----participate_in
INSERT INTO participate_in VALUES ('131698923', 'Participant', '240', 1,'CyberShield++',150 );
INSERT INTO participate_in VALUES ('228798223', 'Mentor/Coach', '240', 2,Null,400 );
INSERT INTO participate_in VALUES ('214496783', 'Participant', '240', 3,'CyberShield++',150 );
INSERT INTO participate_in VALUES ('215198237', 'Coordinator', '240', 4, Null,200 );
INSERT INTO participate_in VALUES ('211498333', 'Participant', '232', 1, 'Project Management Seminar',150 );
INSERT INTO participate_in VALUES ('221295423', 'Participant', '232', 2,'Project Management Seminar',150 );
INSERT INTO participate_in VALUES ('231298223', 'Coordinator', '232', 3, Null,200 );
INSERT INTO participate_in VALUES ('271223226', 'Mentor/Coach', '232', 4,Null,400 );
INSERT INTO participate_in VALUES ('214496783', 'Mentor/Coach', '238', 0 , Null, 0 );
INSERT INTO participate_in VALUES ('213423813', 'Administrator', '238', 0 , Null, 0 );
INSERT INTO participate_in VALUES ('354728497', 'Participant', '238', 0 , Null, 0 );
-------fills
INSERT INTO fills VALUES('131698923', '240', '1', '1', 5 );
INSERT INTO fills VALUES('131698923', '240', '2', '1', 6 );
INSERT INTO fills VALUES('214496783', '240', '1', '1', 6 );
INSERT INTO fills VALUES('214496783', '240', '2', '1', 7 );
INSERT INTO fills VALUES('211498333', '232', '1', '3', 6);
INSERT INTO fills VALUES('211498333', '232', '2', '3', 9 );
INSERT INTO fills VALUES('221295423', '232', '1', '3', 7 );
INSERT INTO fills VALUES('221295423', '232', '2', '3', 8 );
INSERT INTO fills VALUES('354728497', '238', '1', '6', 0 );
INSERT INTO fills VALUES('354728497', '238', '2', '6', 0 );
---------presents
INSERT INTO presents VALUES ('240', 'CareerMinds Training Center', 'MR.Salem Aldosari', 'M');
INSERT INTO presents VALUES ('234', 'SkillForge Institute', 'Ms.Sara Alajlan', 'F');
INSERT INTO presents VALUES ('233', 'TechSkills Academy', NULL, Null);
INSERT INTO presents VALUES ('231', 'ExecuLearn Conferences', 'MR.Jihad Hakij', 'M');
INSERT INTO presents VALUES ('235', 'InnovateEd Workshops', 'MR.Salem Aldosari', 'M');
INSERT INTO presents VALUES ('236', 'ExecuLearn Conferences', 'MS.Naya Ameer', 'F');
INSERT INTO presents VALUES ('238', 'ProDevelopment Network', 'Mr.Maher Alqahtani', 'M');
INSERT INTO presents VALUES ('237', 'SkillForge Institute',NULL,Null);
INSERT INTO presents VALUES ('232', 'GlobalLeadership Seminars', 'Ms.Suaad Husain', 'F');
INSERT INTO presents VALUES ('239', 'ProDevelopment Network', 'Mr.Jamal Alahmadi', 'M');

