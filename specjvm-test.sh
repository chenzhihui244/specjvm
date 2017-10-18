#!/bin/sh

export JAVA_HOME=/usr/estuary/packages/openjdk-1.8.0/jdk8u-server-release-1609
#export JAVA_HOME=/usr/lib/jdk/ezdk-1.8.0_131-8.21.0.54-eval-linux_aarch64
export PATH=$JAVA_HOME/bin:$PATH
export CLASSPATH=$JAVA_HOME/lib

function specjvm_test {
	java -jar SPECjvm2008.jar -Dspecjvm.result.dir=/root/benchmark/specjvm/results -wt 5s -it 5s -bt 2 compress
}

function specjvm_base_metric {
	java -jar SPECjvm2008.jar -Dspecjvm.result.dir=/root/benchmark/specjvm/results --base
}

function specjvm_peak_metric {
	java -jar SPECjvm2008.jar --peak -pf props/specjvm.properties
}

function specjvm_custom_metric_1thread {
	java -Xbootclasspath/p:/SPECjvm2008/lib/javac.jar \
		-server \
		-Dspecjvm.home.dir=/SPECjvm2008 \
		-jar /SPECjvm2008/SPECjvm2008.jar \
		-Dspecjvm.result.dir=/root/benchmark/specjvm/results \
		-ja -server -ikv  -wt 200s -it 50s -bt 1 -i 16 \
		compiler.compiler compress crypto.aes crypto.rsa crypto.signverify derby mpegaudio scimark.lu.large scimark.sor.large scimark.sparse.large scimark.fft.small scimark.lu.small scimark.sor.small scimark.sparse.small scimark.monte_carlo serial sunflow xml.transform xml.validation
}

function specjvm_custom_metric_64thread {
	java -Xbootclasspath/p:/SPECjvm2008/lib/javac.jar \
		-server \
		-Dspecjvm.home.dir=/SPECjvm2008 \
		-jar /SPECjvm2008/SPECjvm2008.jar \
		-Dspecjvm.result.dir=/root/benchmark/specjvm/results \
		-ja -server -ikv  -wt 120s -it 50s -bt 64 -i 5 \
		compiler.compiler compress crypto.aes crypto.rsa crypto.signverify derby mpegaudio scimark.lu.large scimark.sor.large scimark.sparse.large scimark.fft.small scimark.lu.small scimark.sor.small scimark.sparse.small scimark.monte_carlo serial sunflow xml.transform xml.validation
}

function specjvm_peak_zulu_1thread {
	java -Xbootclasspath/p:/root/Azul/SPECjvm2008/lib/javac.jar \
		-server \
		-Dspecjvm.home.dir=/root/Azul/SPECjvm2008 \
		-jar /root/Azul/SPECjvm2008/SPECjvm2008.jar \
		-Dspecjvm.result.dir=/root/Azul/results_ze/ \
		-ja -server -ikv -wt 200s -it 50s -bt 1 -i 16 \
		compiler.compiler compress crypto.aes crypto.rsa crypto.signverify derby mpegaudio scimark.lu.large scimark.sor.large scimark.sparse.large scimark.fft.small scimark.lu.small scimark.sor.small scimark.sparse.small scimark.monte_carlo serial sunflow xml.transform xml.validation
}

function specjvm_peak_zul_64thread {
	java -Xbootclasspath/p:/root/Azul/SPECjvm2008/lib/javac.jar \
		-server \
		-Dspecjvm.home.dir=/root/Azul/SPECjvm2008 \
		-jar /root/Azul/SPECjvm2008/SPECjvm2008.jar \
		-Dspecjvm.result.dir=/root/Azul/results_ze/ \
		-ja -server -ikv -wt 120s -it 50s -bt 64 -i 5 \
		compiler.compiler compress crypto.aes crypto.rsa crypto.signverify derby mpegaudio scimark.lu.large scimark.sor.large scimark.sparse.large scimark.fft.small scimark.lu.small scimark.sor.small scimark.sparse.small scimark.monte_carlo serial sunflow xml.transform xml.validation
}

cd SPECjvm2008
specjvm_base_metric
