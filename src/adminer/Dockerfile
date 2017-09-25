FROM dockette/adminer
RUN sed -i \
            -e "s/^expose_php.*/expose_php = Off/" \
            -e "s/^;date.timezone.*/date.timezone = UTC/" \
            -e "s/^memory_limit.*/memory_limit = 2048M/" \
            -e "s/^max_execution_time.*/max_execution_time = 3000/" \
            -e "s/^post_max_size.*/post_max_size = 2048M/" \
            -e "s/^upload_max_filesize.*/upload_max_filesize = 2048M/" \
            -e "s/^; display_errors.*/display_errors = on/" \
            -e "s@^;sendmail_path.*@sendmail_path = /usr/sbin/sendmail -t -i -S opensmtpd:25@" \
            /etc/php7/php.ini