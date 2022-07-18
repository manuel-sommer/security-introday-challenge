FROM python
COPY  . .
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt
ENTRYPOINT [ "python", "main.py" ]