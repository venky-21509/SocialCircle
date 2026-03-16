# Odinnbook

A social media application built with Ruby on Rails, inspired by the Odin Project curriculum.

## Features

- **User Authentication**: Complete user registration, login, and profile management using Devise
- **Social Networking**: Follow/unfollow users with pending follow requests
- **Posts**: Create, view, and delete text posts
- **Interactions**: Like and comment on posts
- **User Profiles**: Customizable profiles with bio and profile pictures
- **Feed**: Personalized feed showing posts from followed users
- **Email Notifications**: Welcome emails for new users
- **Responsive Design**: Clean, modern UI with custom CSS

## Tech Stack

- **Ruby**: 3.3.10
- **Ruby on Rails**: 8.0.4
- **Database**: PostgreSQL
- **Authentication**: Devise gem
- **Email**: Letter Opener (development)
- **Styling**: Custom CSS (Bootstrap-like components)

## Getting Started

### Prerequisites

- Ruby 3.3.10
- PostgreSQL
- Rails 8.0.4

### Installation

1. Clone the repository:
   ```bash
   git clone <repository-url>
   cd odinnbook
   ```

2. Install dependencies:
   ```bash
   bundle install
   ```

3. Set up the database:
   ```bash
   rails db:create
   rails db:migrate
   ```

4. Seed the database with sample data:
   ```bash
   rails db:seed
   ```

5. Start the Rails server:
   ```bash
   rails server
   ```

6. Visit `http://localhost:3000` in your browser.

### Default Users

After seeding the database, you can use these accounts to test:

- **Admin**: admin@odinnbook.com / password123
- **Sample Users**: 10 additional users created with random data

## Usage

1. **Sign Up**: Create a new account with name, username, email, and optional bio/profile picture
2. **Sign In**: Log in with your credentials
3. **Explore**: Browse the users directory and follow other users
4. **Post**: Share updates with your followers
5. **Interact**: Like and comment on posts from users you follow
6. **Profile**: Customize your profile and manage follow requests

## Project Structure

```
app/
├── controllers/
│   ├── application_controller.rb
│   ├── posts_controller.rb
│   ├── users_controller.rb
│   ├── comments_controller.rb
│   ├── likes_controller.rb
│   ├── follows_controller.rb
│   └── users/
│       └── registrations_controller.rb
├── models/
│   ├── user.rb
│   ├── post.rb
│   ├── comment.rb
│   ├── like.rb
│   └── follow.rb
├── views/
│   ├── layouts/
│   ├── posts/
│   ├── users/
│   ├── devise/
│   └── welcome_mailer/
└── mailers/
    └── welcome_mailer.rb
```

## Database Schema

- **Users**: Authentication and profile information
- **Posts**: User-generated content
- **Comments**: Post comments
- **Likes**: Post likes
- **Follows**: User follow relationships with status tracking

## Development

### Running Tests

```bash
rails test
```

### Email Testing

In development, emails are opened automatically using Letter Opener. Check your browser for sent emails.

### Database Management

```bash
# Reset database
rails db:reset

# Run migrations
rails db:migrate

# Seed data
rails db:seed
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is part of The Odin Project curriculum and is for educational purposes.

## Future Enhancements

- Image uploads for posts and profiles
- Real-time notifications
- Direct messaging
- Hashtags and mentions
- Post analytics
- Mobile app

---

Built with ❤️ for The Odin Project
