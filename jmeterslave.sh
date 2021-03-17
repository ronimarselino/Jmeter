curl -O https://download.java.net/java/GA/jdk14/076bab302c7b4508975440c56f6cc26a/36/GPL/openjdk-14_linux-x64_bin.tar.gz
tar xvf openjdk-14_linux-x64_bin.tar.gz
sudo mv jdk-14 /opt/
curl -O https://downloads.apache.org/jmeter/binaries/apache-jmeter-5.2.1.tgz
tar -zxvf apache-jmeter-5.2.1.tgz
sudo chmod 777 /etc/security/limits.conf
sudo chmod 777 /etc/pam.d/sshd
sed -i 's/set HEAP=-Xms1g -Xmx1g -XX:MaxMetaspaceSize=256m/set HEAP=-Xms2g -Xmx4g -XX:MaxMetaspaceSize=256m"/g'  /home/ec2-user/apache-jmeter-5.2.1/bin/jmeter.bat
sudo tee /etc/profile.d/j_ops.sh <<EOF
export _JAVA_OPTIONS=-Xms1g -Xmx64g
EOF
sudo tee /etc/profile.d/jdk14.sh <<EOF
export JAVA_HOME=/opt/jdk-14
export PATH=\$PATH:\$JAVA_HOME/bin
EOF
export JAVA_HOME=/opt/jdk-14
export PATH=\$PATH:\$JAVA_HOME/bin
echo "server.rmi.ssl.disable=true" >> /home/ec2-user/apache-jmeter-5.2.1/bin/user.properties
echo "*                soft     nofile          65535" >>  /etc/security/limits.conf
echo "*                hard     nofile          65535" >>  /etc/security/limits.conf
echo "root             soft     nofile          65535" >>  /etc/security/limits.conf
echo "root             hard     nofile          65535" >>  /etc/security/limits.conf
echo 65534 > /proc/sys/fs/file-max
echo "session    required     pam_limits.so" >> /etc/pam.d/sshd
sh /home/ssm-user/apache-jmeter-5.2.1/bin/jmeter-server
