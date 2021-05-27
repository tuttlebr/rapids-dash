ARG CUDA_VERSION=11.0
ARG LINUX_VERSION=ubuntu20.04

FROM rapidsai/rapidsai:cuda${CUDA_VERSION}-runtime-${LINUX_VERSION}

RUN mkdir -p /rapids/census_demo/data/
ADD https://s3.us-east-2.amazonaws.com/rapidsai-data/viz-data/census_data.parquet.tar.gz /rapids/census_demo/data/
RUN tar -xvzf /rapids/census_demo/data/census_data.parquet.tar.gz \
    && rm /rapids/census_demo/data/census_data.parquet.tar.gz

WORKDIR /rapids/census_demo

COPY . .

RUN source activate rapids \
    && conda install -c conda-forge --file environment_for_docker.yml \
    && pip install --no-cache-dir dash-dangerously-set-inner-html

ENTRYPOINT ["bash","./entrypoint.sh"]
