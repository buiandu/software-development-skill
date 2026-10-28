# PRD: <Epic Name>

## Tổng quan Epic (Epic Overview)

- **Tên cụm tính năng (Epic Name):** <Tên ngắn gọn, hướng kết quả>
- **Đối tượng sử dụng (Target Persona):** <Vai trò, bối cảnh, tần suất sử dụng>
- **Mục tiêu cốt lõi (Core Objective):** <Hiện trạng> -> <Trạng thái mong muốn>. <Lý do cần làm bây giờ>
- **Tiêu chí thành công (Success Metrics):** <Baseline hoặc target>, <timeframe>, <nguồn đo>. Nếu chưa có: TBD (owner: <role>).
- **Ngoài phạm vi (Out of Scope):** <1-3 mục không nằm trong epic này>

## Giả định & Phụ thuộc (Assumptions & Dependencies)

- <Giả định đang được kiểm chứng>; phụ thuộc vào <hệ thống, đội, hoặc dữ liệu>.

## Câu hỏi mở (Open Questions)

- <Câu hỏi> — người trả lời: <role>. Có chặn triển khai: <Có/Không>.

## Tính năng (Features)

### F01 - <Feature Name>

- **Mục tiêu (Objective):** <Mục tiêu cụ thể của tính năng>
- **Vấn đề giải quyết (Problem Statement):** <Ai bị ảnh hưởng, đau ở đâu, chi phí nếu không làm>
- **Ưu tiên & Phụ thuộc (Priority & Dependencies):** <Must-have / Should-have / Could-have>; phụ thuộc vào <tính năng, hệ thống, hoặc quyết định>.
- **Chi tiết năng lực (Key Capabilities):**
  - **C01 - <Capability Name>:** <Hành vi người dùng quan sát được>
    - *Ví dụ thực tế (Real-world example):* <Tình huống cụ thể>
    - *Trường hợp biên (Edge case):* <Điều kiện bất thường và hành vi mong đợi>
  - **C02 - <Capability Name>:** <Hành vi người dùng quan sát được>
    - *Ví dụ thực tế (Real-world example):* <Tình huống cụ thể>
    - *Trường hợp biên (Edge case):* <Điều kiện bất thường và hành vi mong đợi>
- **Quy tắc / Logic nghiệp vụ (Business Rules):**
  - <Điều kiện, thứ tự ưu tiên, giới hạn, quyền, hành vi khi lỗi>
- **Ngoài phạm vi tính năng (Feature Out of Scope):**
  - <Hành vi hoặc đối tượng không thuộc tính năng này>
- **Kết quả nghiệm thu (Outcomes & Acceptance):**
  - **Definition of Done:**
    - [ ] <Sản phẩm hoặc hành vi kiểm chứng được>
  - **Tiêu chí kiểm thử (Test / Measurable Criteria):**
    - [ ] **Happy path:** <Đầu vào hợp lệ> -> <Kết quả quan sát được>
    - [ ] **Edge case:** <Điều kiện biên> -> <Kết quả quan sát được>
    - [ ] **Error:** <Đầu vào hoặc lỗi hệ thống> -> <Thông báo và trạng thái mong đợi>
    - [ ] **Permission:** <Vai trò không có quyền> -> <Hành vi bị chặn và thông báo>

## UI/UX

- **Vị trí hiển thị (Placement):** <Màn hình hoặc khu vực>
- **Tương tác cốt lõi (Core Interactions):** <Hành động chính của người dùng>
- **Trạng thái (States):** Loading / Empty / Error / Success / Disabled / Permission denied
- **Hiển thị & Nội dung (Responsive & Copy):** <Hành vi trên màn hình nhỏ; nội dung thông báo, nhãn, lỗi>

## Dữ liệu & Tích hợp (Data & Integration)

- **Dữ liệu đầu vào (Inputs):** <Dữ liệu cần để tính năng hoạt động>
- **Tích hợp bên thứ ba (APIs):** <Dịch vụ ngoài cần gọi>
- **Ánh xạ dữ liệu (Data Mapping):**

  | Trường (Field) | Nguồn (Source) | Kiểm tra (Validation) | Ghi chú (Notes) |
  | -------------- | -------------- | --------------------- | --------------- |
  | <field>        | <source>       | <rule>                | <note>          |

- **Hợp đồng tích hợp (Integration Contracts):** <Chiều gọi, payload, sự kiện kích hoạt>
- **Xử lý lỗi (Failure Behavior):** <Timeout, retry, fallback, thông báo cho người dùng>

## Bàn giao (Handoff)

- Breakdown công việc: dùng skill `kanban-task-breakdown`.
