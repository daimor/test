FROM intersystemsdc/iris-community

ARG MODULE=test

WORKDIR /home/irisowner/$MODULE
ARG TESTS=0

RUN --mount=type=bind,src=.,dst=. \
  iris start iris && \
  iris session iris "##class(%ZPM.PackageManager).Shell(\"load /home/irisowner/$MODULE -v\",1,1)" && \
  ([ $TESTS -eq 0 ] || iris session iris "##class(%ZPM.PackageManager).Shell(\"test $MODULE -v -only\",1,1)") && \
  iris stop iris quietly
