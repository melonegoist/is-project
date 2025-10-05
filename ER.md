```mermaid
erDiagram
    users ||--o{ profiles : has
    users {
        integer user_id PK
        varchar email
        varchar password_hash
        varchar role
        varchar first_name
        varchar last_name
        timestamp created_at
        boolean is_active
        boolean email_verified
    }
    
    profiles {
        integer profile_id PK
        integer user_id FK
        varchar phone
        varchar avatar_url
        date date_of_birth
        varchar skill_level
        text bio
    }
    
    users ||--o{ courses : creates
    courses {
        integer course_id PK
        varchar title
        text description
        varchar format
        varchar skill_level
        varchar status
        integer teacher_id FK
        integer location_id FK
        timestamp created_at
    }
    
    users }o--o{ courses : enrolls_in
    course_enrollments {
        integer enrollment_id PK
        integer user_id FK
        integer course_id FK
        varchar status
        timestamp enrolled_at
    }
    
    courses ||--o{ lessons : contains
    lessons {
        integer lesson_id PK
        integer course_id FK
        varchar title
        text description
        timestamp start_time
        integer duration_minutes
        varchar video_conf_url
        integer location_id FK
    }
    
    locations ||--o{ courses : hosts
    locations ||--o{ lessons : hosts
    locations {
        integer location_id PK
        varchar name
        text address
    }
    
    users }o--o{ equipment : rents
    equipment_rentals {
        integer rental_id PK
        integer user_id FK
        integer equipment_id FK
        timestamp start_date
        timestamp end_date
        varchar status
        timestamp created_at
    }
    
    equipment {
        integer equipment_id PK
        varchar name
        varchar type
        text description
        varchar status
    }
    
    users ||--o{ payments : makes
    payments {
        integer payment_id PK
        integer user_id FK
        decimal amount
        varchar currency
        varchar status
        varchar payment_type
        integer entity_id
        timestamp created_at
    }
    
    users ||--o{ messages : sends
    users ||--o{ messages : receives
    messages {
        integer message_id PK
        integer sender_id FK
        integer receiver_id FK
        text message_text
        timestamp sent_at
        varchar message_type
    }

```mermaid
