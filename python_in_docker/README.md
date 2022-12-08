# Hello docker
This might turn into a presentation in the future.

# Info
Docker is a set of platform as a service (PaaS) products that use OS-level virtualization to deliver software in packages called containers.
This is usefull in many ways, including cross platform distributiuon.


# Hello docker example
1. Install docker [https://www.docker.com/](https://www.docker.com/)
2. Install Anaconda3 [https://www.anaconda.com/](https://www.anaconda.com/)
3. Install Visual studio code (VS code) [or any other editor] [https://code.visualstudio.com/](https://code.visualstudio.com/)
4. Make a project folder e.g. `python_in_docker`
5. make a `main.py` script in that project
```python
import sys
print("hello there!")
print(sys.version)
``` 
6. make a `Dockerfile` in that project
```bash
FROM python:3.9 
# Or any preferred Python version.
ADD main.py .
RUN pip install requests beautifulsoup4 python-dotenv
CMD python main.py
# Or enter the name of your unique directory and parameter set.
```
7. Build your container using the Windows powershell terminal in VS code
```
cd path\to\project\folder\python_in_docker
docker build -t python-hello-docker .
```
8. Check that python-hello-docker image was built
`docker images` 
9. Run your docker container
`docker run python-hello-docker`

