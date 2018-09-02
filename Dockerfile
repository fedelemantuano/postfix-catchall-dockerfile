FROM alpine:latest

RUN apk add --no-cache postfix postfix-pcre rsyslog

RUN set -ex; \
    postconf -e "myhostname=localhost"; \
    postconf -e "mynetworks_style=host"; \
    postconf -e "mail_spool_directory=/var/mail/"; \
    postconf -e "virtual_alias_maps=pcre:/etc/postfix/virtual"; \
    echo "/.*/ root" > /etc/postfix/virtual; \
    postmap /etc/postfix/virtual; \
    postalias /etc/postfix/aliases; \
    mkdir /var/mail; \
    chmod -R +r /var/log;

EXPOSE 25
VOLUME ["/var/mail/root"]
CMD ["sh", "-c", "rsyslogd; postfix start; tail -F /var/log/maillog"]