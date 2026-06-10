# Plastic Usage Monitoring System

A comprehensive web-based system for tracking and monitoring plastic usage to promote environmental sustainability.

## Project Overview

The Plastic Usage Monitoring System is designed to help individuals and organizations track their daily plastic consumption, analyze usage patterns, and receive alerts when usage exceeds predefined limits. The system aims to create awareness about plastic usage and encourage environmentally responsible behavior.

## Features

### Core Modules

1. **User Module**
   - User registration and login
   - Secure password hashing with BCrypt
   - Session management
   - User profile management

2. **Data Entry Module**
   - Daily plastic usage logging
   - Track bottles, covers, bags, and other plastic items
   - Notes and descriptions
   - Date-based usage tracking

3. **Analytics Module**
   - Daily, weekly, monthly statistics
   - Usage trends and patterns
   - Comparison reports
   - Visual progress tracking

4. **Alert Module**
   - Daily limit exceeded warnings
   - Usage threshold alerts
   - Weekly and monthly summaries
   - Achievement notifications

5. **Database Module**
   - MySQL database with JDBC connectivity
   - Connection pooling with HikariCP
   - Efficient data management
   - Data integrity constraints

## Technology Stack

- **Backend**: Java 11, Servlets, JSP
- **Database**: MySQL 8.0
- **Connectivity**: JDBC with HikariCP connection pooling
- **Frontend**: HTML5, CSS3, JavaScript, JSTL
- **Build Tool**: Maven
- **Server**: Apache Tomcat 9+
- **Security**: BCrypt password hashing

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/plastic/
│   │       ├── dao/           # Data Access Objects
│   │       ├── model/         # Entity Classes
│   │       ├── service/       # Business Logic
│   │       ├── servlet/       # Web Controllers
│   │       ├── filter/        # Security Filters
│   │       └── database/      # Database Configuration
│   └── webapp/
│       ├── WEB-INF/
│       │   ├── views/         # JSP Pages
│       │   └── web.xml       # Deployment Descriptor
│       └── css/              # Stylesheets
└── test/                    # Unit Tests
```

## Database Schema

### Tables

1. **users** - User account information
2. **plastic_usage** - Daily usage records
3. **usage_alerts** - Alert notifications
4. **user_settings** - User preferences

## Installation Guide

### Prerequisites

- Java 11 or higher
- Apache Tomcat 9.0 or higher
- MySQL 8.0 or higher
- Maven 3.6 or higher

### Database Setup

1. Create MySQL database:
   ```sql
   CREATE DATABASE plastic_usage_db;
   ```

2. Run the database schema:
   ```bash
   mysql -u root -p plastic_usage_db < database_schema.sql
   ```

3. Update database connection in `DatabaseConnection.java`:
   ```java
   config.setJdbcUrl("jdbc:mysql://localhost:3306/plastic_usage_db");
   config.setUsername("your_username");
   config.setPassword("your_password");
   ```

### Application Setup

1. Clone or download the project
2. Navigate to project directory
3. Build with Maven:
   ```bash
   mvn clean install
   ```

4. Deploy to Tomcat:
   - Copy `target/plastic-usage-monitoring.war` to Tomcat webapps directory
   - Or use IDE's Tomcat integration

5. Start Tomcat server
6. Access application at: `http://localhost:8080/plastic-usage-monitoring/`

## Usage Instructions

### For Users

1. **Registration**
   - Visit the registration page
   - Fill in personal details
   - Set daily plastic limit
   - Create account

2. **Login**
   - Use registered credentials
   - Access dashboard

3. **Recording Usage**
   - Navigate to "Record Usage"
   - Enter plastic items used
   - Add optional notes
   - Save entry

4. **Viewing Analytics**
   - Dashboard shows current statistics
   - View daily, weekly, monthly trends
   - Monitor progress against limits

### For Administrators

- Monitor all user activities
- Generate system reports
- Manage user accounts
- Configure alert thresholds

## Default Users

For testing purposes, the system includes sample users:

- **Username**: admin, **Password**: password
- **Username**: john_doe, **Password**: password
- **Username**: jane_smith, **Password**: password

## Configuration

### Database Connection

Update connection details in `src/main/java/com/plastic/database/DatabaseConnection.java`:

```java
config.setJdbcUrl("jdbc:mysql://localhost:3306/plastic_usage_db");
config.setUsername("your_username");
config.setPassword("your_password");
```

### Alert Thresholds

Modify alert logic in `AlertService.java` to adjust:
- Daily limit warnings (default: 80%)
- Weekly summary schedule
- Monthly report generation

## Development

### Building the Project

```bash
mvn clean compile
mvn package
```

### Running Tests

```bash
mvn test
```

### Development Server

Use IDE's Tomcat integration or:
```bash
mvn tomcat7:run
```

## Features in Detail

### Dashboard
- Real-time usage statistics
- Progress bars for daily limits
- Recent usage history
- Unread alerts counter

### Usage Entry
- Intuitive form design
- Real-time total calculation
- Date selection
- Optional notes field

### Analytics
- Interactive charts and graphs
- Trend analysis
- Comparison reports
- Export functionality

### Alerts
- Automatic limit checking
- Email notifications (configurable)
- Alert history
- Achievement badges

## Security Features

- Password hashing with BCrypt
- Session management
- SQL injection prevention
- Input validation
- Authentication filters

## Performance Optimizations

- Database connection pooling
- Efficient query design
- Caching mechanisms
- Optimized JSP rendering

## Browser Compatibility

- Chrome 80+
- Firefox 75+
- Safari 13+
- Edge 80+

## Contributing

1. Fork the repository
2. Create feature branch
3. Make changes
4. Add tests
5. Submit pull request

## License

This project is licensed under the MIT License.

## Support

For issues and questions:
- Check documentation
- Review error logs
- Contact development team

## Future Enhancements

- Mobile application
- Advanced analytics
- Social features
- Integration with IoT devices
- Machine learning predictions
- Multi-language support
