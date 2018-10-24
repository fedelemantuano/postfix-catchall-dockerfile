FROM alpine:latest

RUN apk add --no-cache postfix postfix-pcre rsyslog logrotate

COPY logrotate.d/rsyslog /etc/logrotate.d/rsyslog
COPY postfix/master.cf /etc/postfix/master.cf
#COPY rsyslog/rsyslog.conf /etc/rsyslog.conf

RUN set -ex; \
    postconf -e "myhostname=localhost"; \
    postconf -e "mynetworks_style=host"; \
    postconf -e "mail_spool_directory=/var/mail/"; \
    postconf -e "virtual_alias_maps=pcre:/etc/postfix/virtual"; \
    echo "/.*/ root" > /etc/postfix/virtual; \
    postmap /etc/postfix/virtual; \
    postalias /etc/postfix/aliases; \
    mkdir /var/mail;

EXPOSE 25
VOLUME ["/var/mail/root"]
CMD ["sh", "-c", "rsyslogd; postfix start; tail -F /var/log/maillog"]