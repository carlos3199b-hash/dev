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
        $db_host = shell_exec('curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/DB_HOST 2>/dev/null');
$db_user = shell_exec('curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/DB_USER 2>/dev/null');
$db_pass = shell_exec('curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/DB_PASS 2>/dev/null');
$db_name = shell_exec('curl -H "Metadata-Flavor: Google" http://metadata.google.internal/computeMetadata/v1/instance/attributes/DB_NAME 2>/dev/null');
        $conn = mysqli_connect($db_host, $db_user, $db_pass, $db_name);
        if ($conn) {
            echo "Connected to database!";
            mysqli_close($conn);
        } else {
            echo "Database connection failed: " . mysqli_connect_error();
        }
    ?>
    </p>
</body>
</html>
PHPEOF

systemctl restart apache2
