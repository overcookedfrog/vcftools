FROM alpine:3.7 as builder
RUN apk --no-cache add alpine-sdk perl zlib-dev curl
RUN set -ex \
    && curl -L -O https://github.com/vcftools/vcftools/releases/download/v0.1.15/vcftools-0.1.15.tar.gz \
    && tar zxf vcftools-0.1.15.tar.gz \
    && cd vcftools-0.1.15 \
    && ./configure --prefix=/app/vcftools-0.1.15 \
    && make \
    && make install

FROM alpine:3.7
ENV PATH /app/vcftools-0.1.15/bin:$PATH
ENV PERL5LIB /app/vcftools-0.1.15/share/perl:$PERL5LIB
RUN apk add --no-cache libstdc++ perl zlib
COPY --from=builder /app/ /app/
