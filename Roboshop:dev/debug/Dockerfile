FROM almalinux:9
RUN dnf install telnet net-tools iputils bind-utils -y
RUN useradd debuguser
USER debuguser
CMD ["sleep","200"]