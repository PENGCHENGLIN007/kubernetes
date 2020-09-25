#版本信息
FROM tomcat

WORKDIR /usr/local/tomcat/webapps

ADD ./target/web_no_db.war /usr/local/tomcat/webapps

EXPOSE 8080

CMD ["/usr/local/tomcat/bin/catalina.sh","run"] && tail -f /usr/local/tomacat/logs/catalina.out