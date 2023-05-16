+++
title = "Creating a Superuser in Django Using Python Script"
date = 2023-05-03

[taxonomies]
series=["Django Snippet"]
tags=["Django", "Python"]
+++

# In this blog
we will walk through a code snippet that demonstrates how to create a superuser in Django using environment variables. This technique can be useful in production environments where it's not secure to hardcode sensitive information like usernames and passwords in the source code.

# Let's take a look at the code snippet:
```python
import os
import django
from django.contrib.auth import get_user_model

# Set DJANGO_SETTINGS_MODULE environment variable
django.setup()
User = get_user_model()

# Get superuser credentials from environment variables
superuser_username = os.environ.get('DJANGO_SUPERUSER_USERNAME')
superuser_email = os.environ.get('DJANGO_SUPERUSER_EMAIL')
superuser_password = os.environ.get('DJANGO_SUPERUSER_PASSWORD')

try:
    # Check if the superuser already exists
    user = User.objects.get(username=superuser_username)

    # If the user exists but the password doesn't match, update the password
    if not user.check_password(superuser_password):
        user.set_password(superuser_password)
        user.save()
        print('Superuser password updated successfully')
    else:
        print('Superuser already exists')

except User.DoesNotExist:
    # If the superuser doesn't exist, create it
    user = User.objects.create_superuser(
        username=superuser_username,
        email=superuser_email,
        password=superuser_password,
    )
    print('Superuser created successfully')
```
