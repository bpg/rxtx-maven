#RXTX Maven Wrapper
A simple Bash script to download, wrap and install RXTX library as a Maven artifact in local repository. The artifact includes jar, sources and native .so library (Linux x64 only)

#Usage

The java library can be simply used as any other regular Maven dependency:

pom.xml

    <dependencies>
        ...
        <dependency>
            <groupId>org.rxtx</groupId>
            <artifactId>rxtx</artifactId>
            <version>2.2pre2</version>
        </dependency>
        ...
    </dependencies>

To add the native library to your project you have to do the following:

1. Add file src/main/assemblies/distribution.xml:

    <dependencySets>
        ...
        <dependencySet>
            <outputDirectory>/</outputDirectory>
            <outputFileNameMapping>librxtxSerial.so</outputFileNameMapping>
            <includes>
                <include>*:rxtx:so:bin</include>
            </includes>
            <fileMode>666</fileMode>
        </dependencySet>
        ...
    </dependencySets>

2. Add to the project's pom.xml:

    <dependencies>
        ...
        <dependency>
            <groupId>org.rxtx</groupId>
            <artifactId>rxtx</artifactId>
            <version>2.2pre2</version>
            <type>so</type>
            <classifier>bin</classifier>
            <scope>runtime</scope>
        </dependency>
        ...
    </dependencies>


    <build>
        <plugins>
            ...
            <plugin>
                <groupId>org.apache.maven.plugins</groupId>
                <artifactId>maven-assembly-plugin</artifactId>
                <version>2.2</version>
                <inherited>false</inherited>
                <configuration>
                    <descriptors>
                        <descriptor>src/main/assemblies/distribution.xml</descriptor>
                    </descriptors>
                </configuration>
                <executions>
                    <execution>
                        <id>make-assembly</id>
                        <phase>package</phase>
                        <goals>
                            <goal>single</goal>
                        </goals>
                    </execution>
                </executions>
            </plugin>
            ...
        </plugins>
    </build>

