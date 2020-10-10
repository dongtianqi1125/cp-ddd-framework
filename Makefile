package:clean
	@mvn package

clean:
	@mvn clean
	@cd demo; mvn clean

install:clean test
	@mvn install -Pinstall

test:clean
	@mvn test -Ptest

plugin-test:install
	@cd demo; mvn package; mvn test -Pplugin

coverage:test
	@mvn clean verify -Ptest
	@open cp-ddd-test/target/site/jacoco-aggregate/index.html

javadoc:install
	@mvn javadoc:javadoc -Pinstall
	@open target/site/apidocs/index.html

deploy-github:test
	@mvn deploy -Prelease

release-javadoc:install
	@git checkout gh-pages
	@git pull
	@git checkout master
	@mvn javadoc:javadoc
	@git checkout gh-pages
	@rm -rf doc/apidocs
	@mv -f target/site/apidocs/ doc/
	@git add doc/apidocs
	@git commit -m 'Javadoc released' doc/apidocs
	@git push
	@git checkout master
