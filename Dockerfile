FROM python:3.10.1-slim-bullseye

WORKDIR /app

COPY . .
 
# install python dependencies
RUN pip install --upgrade pip
RUN pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu118
RUN pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

RUN cd "TTS/vits/monotonic_align"
RUN mkdir monotonic_align
RUN python setup.py build_ext --inplace
RUN cp monotonic_align/*.pyd .

WORKDIR /app
EXPOSE 38438

CMD ["./start.sh"]

