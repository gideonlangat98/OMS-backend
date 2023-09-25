puts "Seeding..."

admin1 = Admin.create(first_name: "Gideon", last_name: "Langat", email: "langat@gmail.com", password: "password", isadmin: true)

manager1 = Manager.create(f_name: "Gideon", l_name: "Langat", managers_title: "Project Manager", email: "manager@gmail.com", password: "password")

staff1 = Staff.create(staff_name: "Kimeu", joining_date: Date.tomorrow, reporting_to: "CEO", email: "gideonlangat@gmail.com", password: "password", designation: "React & Rails", isStaff: true, admin_id: admin1.id, manager_id: manager1.id)

staff2 = Staff.create(staff_name: "Giddy", joining_date: Date.tomorrow, reporting_to: "CEO", email: "gideon@gmail.com", password: "password", designation: "React & Rails", isStaff: true, admin_id: admin1.id, manager_id: manager1.id)

staff3 = Staff.create(staff_name: "G", joining_date: Date.tomorrow, reporting_to: "CEO", email: "gideony@gmail.com", password: "password", designation: "React & Rails", isStaff: true, admin_id: admin1.id, manager_id: manager1.id)

leave_form1 = Form.create(your_name: "Kimeu", date_from: Date.today, date_to: Date.tomorrow, days_applied: 10, leaving_type: "Sick Leave", reason_for_leave: "Sick Leave", status: "pending", staff_id: staff1.id)

leave_type1 = LeaveType.create(leave_reason: "Sick Leave", days_allowed: 10, staff_id: staff1.id)

article1 = CompanyArticle.create(title: "ISO CERTIFIED", date: Date.today, content: "We are now ISO certified", staff_id: staff1.id)

client1 = Client.create(client_name: "Maxxy", description: "Fully functional", main_email: "g@gmail.com", second_email: "mister@gmail.com", first_contact: +254701424534, second_contact: +254703383959)

project1 = Project.create(project_name: "Crypto Application", description: "Full Stack Project", client_details: "Gideon", project_managers: "Langat", task_managers: "Anthony")

task1 = Task.create(assignment_date: Date.today, completion_date: Date.tomorrow, task_name: "Office System", assigned_to: "Kimeu", task_manager: "Omera", project_manager: 'Ida', project_name: "Oms", task_deadline:"Three Weeks", avatar_image: "", completed_files: "", project_id: project1.id, isSeen: false, send_type: "admin", staff_id: staff1.id)

timesheet1 = Timesheet.create(date: Date.today, start_time: Time.now, end_time: Time.now, task_id: task1.id, task_detail: "Oms", progress_details: "Completed task", time_limit: " Three Weeks", staff_id: staff1.id)

profile1 = Profile.create(bio: "Software Engineer # FullStack Engineer", avatar: "", about:"", location:"", bio_name: "", my_email: "", tech: "", staff_id: staff1.id)

puts "Done seeding!"
