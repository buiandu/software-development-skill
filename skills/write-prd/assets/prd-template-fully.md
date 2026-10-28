# PRD: <Epic Name>

## Tổng quan Epic (Epic Overview)

- **Tên cụm tính năng (Epic Name):** <Tên ngắn gọn, hướng kết quả>
- **Đối tượng sử dụng (Target Persona):** <Vai trò, bối cảnh, tần suất sử dụng>
- **Mục tiêu cốt lõi (Core Objective):** <Hiện trạng> -> <Trạng thái mong muốn>. <Lý do cần làm bây giờ>
- **Tiêu chí thành công (Success Metrics):** <Baseline hoặc target>, <timeframe>, <nguồn đo>. Nếu chưa có: TBD (owner: <role>).
- **Ngoài phạm vi (Out of Scope):** <1-3 mục không nằm trong epic này>. Lý do: <vì sao loại trừ>; ảnh hưởng: <persona nào chịu ảnh hưởng>.

## Giả định & Phụ thuộc (Assumptions & Dependencies)

- <Giả định đang được kiểm chứng>; phụ thuộc vào <hệ thống, đội, hoặc dữ liệu>.

## Câu hỏi mở (Open Questions)

- <Câu hỏi> — Chủ sở hữu (Owner): <role>. Chặn triển khai (Blocking): <Có/Không>.

## Tính năng (Features)

### F01 - <Feature Name>

- **Mục tiêu (Objective):** <Mục tiêu cụ thể của tính năng>
- **Vấn đề giải quyết (Problem Statement):** <Ai bị ảnh hưởng, đau ở đâu, chi phí nếu không làm>
- **Ưu tiên & Phụ thuộc (Priority & Dependencies):** <Must-have / Should-have / Could-have>; phụ thuộc vào <tính năng, hệ thống, hoặc quyết định>.
- **Chi tiết năng lực (Key Capabilities):**
  - **C01 - <Capability Name>:** <Hành vi người dùng quan sát được>
    - *Ví dụ thực tế (Real-world example):* <Tình huống cụ thể>
    - *Trường hợp biên (Edge case):* <Điều kiện bất thường và hành vi mong đợi>
    - *Ví dụ lỗi (Error example):* <Lỗi đầu vào hoặc lỗi hệ thống và hành vi mong đợi>
    - *Ví dụ quyền (Permission example):* <Vai trò bị chặn và thông báo>
    - *Ví dụ giới hạn (Limit example):* <Ngưỡng và hành vi tại hoặc sau ngưỡng>
  - **C02 - <Capability Name>:** <Hành vi người dùng quan sát được>
    - *Ví dụ thực tế (Real-world example):* <Tình huống cụ thể>
    - *Trường hợp biên (Edge case):* <Điều kiện bất thường và hành vi mong đợi>
    - *Ví dụ lỗi (Error example):* <Lỗi đầu vào hoặc lỗi hệ thống và hành vi mong đợi>
    - *Ví dụ quyền (Permission example):* <Vai trò bị chặn và thông báo>
    - *Ví dụ giới hạn (Limit example):* <Ngưỡng và hành vi tại hoặc sau ngưỡng>
- **Quy tắc / Logic nghiệp vụ (Business Rules):**
  - <Điều kiện, thứ tự ưu tiên, giới hạn, quyền, hành vi khi lỗi>
  - **Quy tắc audit (Audit Rules):** <Sự kiện cần ghi log, ai xem được, thời gian lưu>
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
    - [ ] **Limit:** <Ngưỡng số lượng, thời gian, hoặc tần suất> -> <Hành vi tại và sau ngưỡng>
    - [ ] **Recovery:** <Sự cố hoặc gián đoạn> -> <Cách hệ thống phục hồi và trạng thái cuối>

## UI/UX

- **Vị trí hiển thị (Placement):** <Màn hình hoặc khu vực>
- **Tương tác cốt lõi (Core Interactions):** <Hành động chính của người dùng>
- **Trạng thái (States):** Loading / Empty / Error / Success / Disabled / Permission denied
- **Hiển thị & Nội dung (Responsive & Copy):** <Hành vi trên màn hình nhỏ; nội dung thông báo, nhãn, lỗi>
- **Khả năng truy cập & Bàn phím (Accessibility & Keyboard):** <Mức WCAG, thứ tự focus, phím tắt>
- **Đa ngôn ngữ (i18n):** <Ngôn ngữ hỗ trợ, định dạng số/ngày, độ dài chuỗi>
- **Tham chiếu thiết kế (Design References):** <Liên kết hoặc tên file thiết kế>

## Dữ liệu & Tích hợp (Data & Integration)

- **Dữ liệu đầu vào (Inputs):** <Dữ liệu cần để tính năng hoạt động>
- **Tích hợp bên thứ ba (APIs):** <Dịch vụ ngoài cần gọi>
- **Ánh xạ dữ liệu (Data Mapping):**

  | Trường (Field) | Nguồn (Source) | Kiểm tra (Validation) | Ghi chú (Notes) |
  | -------------- | -------------- | --------------------- | --------------- |
  | <field>        | <source>       | <rule>                | <note>          |

- **Hợp đồng tích hợp (Integration Contracts):** <Chiều gọi, payload, sự kiện kích hoạt>
- **Xử lý lỗi (Failure Behavior):** <Timeout, retry, fallback, thông báo cho người dùng>
- **Lưu trữ & Quyền riêng tư (Retention & Privacy):** <Thời gian lưu, dữ liệu cá nhân, quyền truy cập>
- **Khối lượng & Hiệu năng (Volume & Latency):** <Khối lượng dự kiến, p95/p99, giới hạn tải>
- **Giám sát (Observability):** <Log, metric, alert, dashboard>

## Rủi ro & Giảm thiểu (Risks & Mitigations)

| Rủi ro (Risk) | Khả năng (Likelihood) | Tác động (Impact) | Giảm thiểu (Mitigation) |
| ------------- | --------------------- | ----------------- | ----------------------- |
| <risk>        | <low/medium/high>     | <low/medium/high> | <mitigation>            |

## Triển khai & Rollback (Rollout & Rollback)

- **Cách triển khai:** <Feature flag, phần trăm người dùng, hoặc theo nhóm>
- **Điều kiện rollback:** <Ngưỡng lỗi hoặc tín hiệu cần dừng>
- **Người giám sát:** <role>

## Sự kiện phân tích (Analytics Events)

| Sự kiện (Event) | Kích hoạt (Trigger) | Thuộc tính (Properties) | Mục đích (Purpose) |
| --------------- | ------------------- | ----------------------- | ------------------ |
| <event>         | <trigger>           | <properties>            | <purpose>          |

## Yêu cầu phi chức năng (Non-functional Requirements)

- **Hiệu năng:** <Mục tiêu đo được hoặc TBD (owner: <role>)>
- **Bảo mật:** <Mục tiêu hoặc kiểm soát>
- **Quyền riêng tư:** <Dữ liệu cá nhân, đồng ý, thời hạn lưu>
- **Khả năng truy cập:** <Mức WCAG hoặc tiêu chí>
- **Sẵn sàng:** <SLA hoặc thời gian chịu lỗi>

## Ma trận truy vết (Traceability Matrix)

| Năng lực (Capability) | Tiêu chí thành công (Metric) | DoD | Tiêu chí kiểm thử (Test) |
| --------------------- | ---------------------------- | --- | ------------------------ |
| C01                   | <metric>                     | <DoD item> | <test criterion> |

## Phê duyệt (Sign-off)

| Vai trò (Role) | Tên (Name) | Ngày (Date) | Trạng thái (Status) |
| -------------- | ---------- | ----------- | ------------------- |
| Product        | <name>     | <date>      | <pending/approved>  |
| Design         | <name>     | <date>      | <pending/approved>  |
| Engineering    | <name>     | <date>      | <pending/approved>  |
| QA             | <name>     | <date>      | <pending/approved>  |

## Bàn giao (Handoff)

- Breakdown công việc: dùng skill `kanban-task-breakdown`.
