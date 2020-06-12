# Use python 3.7 image from docker hub
FROM python:3.7.7-slim

ENV token ${token}
ENV chat ${chat}

# Copy application code.
COPY . /app/

# Change the working directory
WORKDIR /app

# Install dependencies.
# RUN pwd
RUN export TMPDIR='/app/tmp'
RUN pip3 install -r dependencies/libs.txt

# Run unit tests
RUN python3 ./telegram_unit_test.py

# Start the python app
CMD python3 ./telegram_bot.py --token=${token} --chat=${chat}