#!/bin/bash
apt-get update
apt-get install -y apache2 php php-mysql

# Create a simple PHP page
cat > /var/www/html/index.php <<'PHPEOF'
<!DOCTYPE html>
<html>
<head>
    <title>Three-Tier App</title>
</head>
<body>
    <h1>Three-Tier Web Application</h1>
    <p>Server: <?php echo gethostname(); ?></p>
    <p>Region: <?php echo $_SERVER['SERVER_ADDR']; ?></p>
    <p>Database connection: 
    <?php
    $db_host = '10.105.0.3';
    $db_pass = 'UserPassword123';
    $db_user = 'webapp_user';
    $db_name = 'webapp_db';

     echo "Connected!";

    ?>
    </p>
</body>
</html>
PHPEOF

systemctl restart apache2
